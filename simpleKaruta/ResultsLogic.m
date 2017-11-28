//
//  ResultsLogic.m
//  simpleKaruta
//
//  Created by ahausagi on 2017/11/22.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "ResultsLogic.h"

@implementation ResultsLogic


- (NSMutableArray *)selectResults {
    NSMutableArray *array = [NSMutableArray array];
    
    FMDatabase *db = [self getDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Results"];
    
    @try {
        [db open];
        FMResultSet *results = [db executeQuery:sql];
        while([results next] )
        {
            NSMutableDictionary *dic = [[results resultDictionary] mutableCopy];
            [array addObject:dic];
        }
        
    } @catch (NSException *exception) {
        [self crashException:exception];
        
    } @finally {
        [db close];
    }
    
    return array;
}


- (void) insertResultsWithDate:(NSString *) date questionCount:(NSInteger) qCount correctCount:(NSInteger) cCount percentage:(double) per {

    if (date != nil && qCount > 0 && cCount > 0) {
        
            FMDatabase *db    = [self getDB];
            BOOL isSucceeded = YES;
            
            @try {
                [db open];
                
                NSString *insertSQL = @"INSERT INTO Results (date, questionCount, correctCount, percentage) VALUES (?,?,?,?);";
                NSNumber *qCountNum = [NSNumber numberWithInteger:qCount];
                NSNumber *cCountNum = [NSNumber numberWithInteger:cCount];
                NSNumber *perNum = [NSNumber numberWithDouble:per];
                if (![db executeUpdate:insertSQL,date, qCountNum, cCountNum, perNum]) {
                    isSucceeded  = NO;
                }
                
                // Commit
                if(isSucceeded){
                    [db commit];
                } else {
                    [db rollback];
                }
                
            } @catch (NSException *exception) {
                [self crashException:exception];
                
            } @finally {
                [db close];
            }
        
    } else {
        // 引数が間違っているので何もしない
    }
}


- (NSMutableArray *) sortResultsArrayInDescOrderOfPercentage {
    
    NSMutableArray *sortedArray = [self selectResults];
    
    NSInteger i; // 配列の先頭を指すインデックス
    NSInteger j; // 残りの要素を指すインデックス
    NSInteger max; // 最大値を持つ要素のインデックス
    NSDictionary *tmpDic; // 交換用の一時変数
    
    // 配列の先頭と先頭以降の要素を比較し、先頭以降の要素の方が大きければ交換する
    for (i = 0; i < [sortedArray count] - 1; i++) {
        max = i; // まず配列の先頭を最大値とする
        
        for (j = i+1; j < [sortedArray count]; j++) { // 先頭以降の値と比較するループ
            // 先頭
            NSNumber *firstPer = sortedArray[i][@"percentage"];
            double firstPerDouble = [firstPer floatValue];
            
            // 先頭以降j個目
            NSNumber *targetPer = sortedArray[j][@"percentage"];
            double targetPerDouble = [targetPer floatValue];
            
            if (targetPerDouble > firstPerDouble) {
                // 現在の最大値と比較
                NSNumber *maxPer = sortedArray[max][@"percentage"];
                double maxPerDouble = [maxPer floatValue];
                if (targetPerDouble > maxPerDouble) {
                    max = j; // 最大値を持つ要素を更新
                }
            }
        }
        // 最大値を持つ要素を先頭の要素と交換
        tmpDic = [sortedArray[i] mutableCopy];
        [sortedArray replaceObjectAtIndex:i withObject:sortedArray[max]];
        [sortedArray replaceObjectAtIndex:max withObject:tmpDic];
    }

    return sortedArray;
}


@end
