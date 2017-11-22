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


- (void) insertResultsWithDate:(NSString *) date questionCount:(NSInteger) qCount correctCount:(NSInteger) cCount {

    if (date != nil && qCount > 0 && cCount > 0) {
        
            FMDatabase *db    = [self getDB];
            BOOL isSucceeded = YES;
            
            @try {
                [db open];
                
                NSString *insertSQL = @"INSERT INTO Results (date, questionCount, correctCount) VALUES (?,?,?);";
                NSNumber *qCountNum = [NSNumber numberWithInteger:qCount];
                NSNumber *cCountNum = [NSNumber numberWithInteger:cCount];
                if (![db executeUpdate:insertSQL,date, qCountNum, cCountNum]) {
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


@end
