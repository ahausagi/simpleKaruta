//
//  ResultsLogic.h
//  simpleKaruta
//
//  Created by ahausagi on 2017/11/21.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "BaseDBLogic.h"

@interface ResultsLogic : BaseDBLogic

// 成績データを取得
- (NSMutableArray *)selectResults;

// 新しい成績データを保存
- (void) insertResultsWithDate:(NSString *) date
                 questionCount:(NSInteger) qCount
                  correctCount:(NSInteger) cCount;
@end
