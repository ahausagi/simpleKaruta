//
//  Torifuda.m
//  simpleKaruta
//  取り札用の下の句配列を作成するクラス

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "Torifuda.h"

@interface Torifuda ()

@end


@implementation Torifuda


// 歌データの下の句をランダムに4つ格納した配列を作成する
// 出題中の歌番号を受け取って、そいつは必ず含むようにする
// questionArrayの配列番号と対応して配列作るといいかも

// 返却配列イメージ
//[0]:[0] @"no":@"1",
//        @"sentence":[0]@"下の句１",[1]@"下の句２"
//    [1] @"no":@"4",
//        @"sentence":[0]@"下の句１",[1]@"下の句２"
//    [2] @"no":@"62",
//        @"sentence":[0]@"下の句１",[1]@"下の句２"
//    [3] @"no":@"39",
//        @"sentence":[0]@"下の句１",[1]@"下の句２"
//[2]:[0] @"no":@"1",
//        @"sentence":[0]@"下の句１",[1]@"下の句２"
//    [1] @"no":@"4",
//        @"sentence":[0]@"下の句１",[1]@"下の句２"
//    [2] @"no":@"62",
//        @"sentence":[0]@"下の句１",[1]@"下の句２"
//    [3] @"no":@"39",
//        @"sentence":[0]@"下の句１",[1]@"下の句２"
- (void) makeAnswerArrayWithQuestions:(NSArray *) questionArray
{
    NSMutableArray *answerArray = [NSMutableArray array];
    
    for (NSDictionary *dict in questionArray) {
        
        // このディクショナリに
        NSMutableDictionary *answerDict = [NSMutableDictionary dictionary];
        
        // 問題文を1題ずつ取り出す
        NSLog(@"dict %@",[dict description]);
        
        // 問題文の歌番号
        NSLog(@"no %@",dict[@"no"]);

        NSMutableArray *part = [NSMutableArray array];
//        [part addObject:oneTankaArr[0]];
//        [part addObject:oneTankaArr[1]];
//        [part addObject:oneTankaArr[2]];

        [answerDict setObject:dict[@"no"] forKey:@"no"];
        [answerDict setObject:part forKey:@"sentence"];

        
        
    }

    


}


@end
