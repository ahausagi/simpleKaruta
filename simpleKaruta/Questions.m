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

- (void) makeQuestionArrayWithOrder:(NSInteger) order {
    
    self.questionArray = [NSMutableArray array];
    
    Tanka *tanka = [[Tanka alloc] init];
    BOOL isPrepared = [tanka prepareAllTanka];

    if (isPrepared) {
        
        NSInteger tankaCount = [tanka.firstPartsArray count];   // 歌合計数

        if (order == 0) {   // 前から
            self.questionArray = [tanka.firstPartsArray mutableCopy];
            
        } else if (order == 1) {    // 後ろから
            // 後ろから１つずつ歌を取り出し格納
            for (int i = (int)([tanka.firstPartsArray count]-1); i >= 0; i--) {
                NSArray *arr = [tanka.firstPartsArray[i] mutableCopy];
                [self.questionArray addObject:arr];
            }
            
        } else if (order == 2) {    // ランダム

            NSMutableArray *numArray = [NSMutableArray array];  // 既出数字リスト
            
            while ([self.questionArray count] < tankaCount) {
                
                // 0~99の乱数を生成
                int randomNum = (int)arc4random_uniform((int)tankaCount);
                
                // すでに出た数字配列と比べて重複チェック
                BOOL existsInArr = NO;
                for (NSNumber *num in numArray) {
                    if (num.intValue == randomNum) {
                        // 既出
                        NSLog(@"kishutu desu!! randomNum:%d",randomNum);
                        existsInArr = YES;
                        break;
                    }
                }
                
                if (existsInArr == NO) {    // 初出
                    // 重複しなければ、その歌番号の上の句を出題配列に入れる
                    
                    for (NSDictionary *dict in tanka.firstPartsArray) {
                        if ([dict[@"no"] intValue] == randomNum) {
                            // 出題配列に入れる
                            [self.questionArray addObject:[dict mutableCopy]];
                            // 既出数字リストに入れる
                            [numArray addObject:@(randomNum)];
                            
                            break;
                        }
                    }
                    
                }
            }
            
        } else {    // 引数間違い。デフォルトとして前からにする
            self.questionArray = [tanka.firstPartsArray mutableCopy];
            
        }
        
        NSLog(@"questionArray \n %@",[self.questionArray description]);


    } else {
        NSLog(@"Could'nt prepare tanka");
    }
    
    
}

@end
