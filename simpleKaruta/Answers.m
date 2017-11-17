//
//  Answers.m
//  simpleKaruta
//  取り札用の下の句配列を作成するクラス

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "Answers.h"
#import "Tanka.h"

@interface Answers ()

@end


@implementation Answers

/**
 *  歌データの下の句をランダムに4つ格納した配列を作成する
 *  @param questionArray 出題順に並べられた上の句配列
 *  @return NSMutableArray 上の句と対応する下の句 + それ以外の下の句を3つを、出題順に格納した配列
 **/
//  返却配列イメージ
//  [0]:[0] @"no":@"1",
//          @"sentence":[0]@"下の句１",[1]@"下の句２"
//      [1] @"no":@"4",
//          @"sentence":[0]@"下の句１",[1]@"下の句２"
//      [2] @"no":@"62",
//          @"sentence":[0]@"下の句１",[1]@"下の句２"
//      [3] @"no":@"39",
//          @"sentence":[0]@"下の句１",[1]@"下の句２"
//  [2]:[0] @"no":@"1",
//          @"sentence":[0]@"下の句１",[1]@"下の句２"
//      [1] @"no":@"4",
//          @"sentence":[0]@"下の句１",[1]@"下の句２"
//      [2] @"no":@"62",
//          @"sentence":[0]@"下の句１",[1]@"下の句２"
//      [3] @"no":@"39",
//          @"sentence":[0]@"下の句１",[1]@"下の句２"

- (NSMutableArray *) makeAnswerArrayWithQuestions:(NSArray *) questionArray
{
    NSMutableArray *answersArray = [NSMutableArray array];
    
    for (NSDictionary *dict in questionArray) {
        
        NSMutableArray *answer = [NSMutableArray array];

        // まず問題文と対応する下の句を配列へ格納
        NSInteger questionNo = [dict[@"no"] integerValue];   // 問題文の上の句の歌番号
        [answer addObject:[[Tanka sharedManager].lastPartsArray objectAtIndex:questionNo]];
        
        
        // 次に、選択肢としてランダムな3つの下の句を入れる
        NSMutableArray *numArray = [NSMutableArray array];  // 既出数字リスト
        [numArray addObject:@(questionNo)];         // 問題分の番号は除外
        
        while ([answer count] < 4) {
            
            // 0~99の乱数を生成
            int randomNum = (int)arc4random_uniform((int)[[Tanka sharedManager].firstPartsArray count]);
            
            // すでに出た数字配列と比べて重複チェック
            BOOL existsInArr = NO;
            for (NSNumber *num in numArray) {
                if (num.intValue == randomNum) {
                    // 既出
                    existsInArr = YES;
                    break;
                }
            }
            
            if (existsInArr == NO) {    // 初出
                // 重複しなければ、その歌番号の下の句を出題配列に入れる
                [answer addObject:[[Tanka sharedManager].lastPartsArray objectAtIndex:randomNum]];
                // 既出数字リストに入れる
                [numArray addObject:@(randomNum)];
                
            }

        }
        
        [answersArray addObject:answer];
        
    }

    NSLog(@"answers array \n%@",[answersArray description]);
    
    return answersArray;

}


@end
