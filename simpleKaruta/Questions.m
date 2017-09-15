//
//  Questions.m
//  simpleKaruta
//  問題文を管理する

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "Questions.h"
#import "Tanka.h"

@interface Questions()

@end


@implementation Questions


/**
 *  上の句を出題順に並べて配列に格納する
 *  @param order 出題順。0:1番から、1:100番から、2:ランダム
 **/

- (NSMutableArray *) makeQuestionArrayWithOrder:(NSInteger) order {
    
    NSMutableArray *questionArray = [NSMutableArray array];

    // 歌情報がちゃんと用意できてるか
    BOOL isPrepared = [Tanka sharedManager].isPreparedSuccess;

    if (isPrepared) {
        NSLog(@"prepare success!");
        NSInteger tankaCount = [[Tanka sharedManager].firstPartsArray count];   // 歌合計数

        if (order == 0) {   // 前から
            questionArray = [[Tanka sharedManager].firstPartsArray mutableCopy];
            
        } else if (order == 1) {    // 後ろから
            // 後ろから１つずつ歌を取り出し格納
            for (int i = (int)([[Tanka sharedManager].firstPartsArray count]-1); i >= 0; i--) {
                NSArray *arr = [[Tanka sharedManager].firstPartsArray[i] mutableCopy];
                [questionArray addObject:arr];
            }
            
        } else if (order == 2) {    // ランダム

            NSMutableArray *numArray = [NSMutableArray array];  // 既出数字リスト
            
            while ([questionArray count] < tankaCount) {
                
                // 0~99の乱数を生成
                int randomNum = (int)arc4random_uniform((int)tankaCount);
                
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
                    // 重複しなければ、その歌番号の上の句を出題配列に入れる
                    
                    for (NSDictionary *dict in [Tanka sharedManager].firstPartsArray) {
                        if ([dict[@"no"] intValue] == randomNum) {
                            // 出題配列に入れる
                            [questionArray addObject:[dict mutableCopy]];
                            // 既出数字リストに入れる
                            [numArray addObject:@(randomNum)];
                            
                            break;
                        }
                    }
                    
                }
            }
            
        } else {    // 引数間違い。デフォルトとして前からにする
            questionArray = [[Tanka sharedManager].firstPartsArray mutableCopy];
            
        }
        
        NSLog(@"questionArray \n %@",[questionArray description]);


    } else {
        NSLog(@"Could'nt prepare tanka");
    }
    
    return questionArray;
}

@end
