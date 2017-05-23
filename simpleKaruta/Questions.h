//
//  Questions.h
//  simpleKaruta
//  問題文を管理する

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Questions : NSObject

@property (nonatomic) NSMutableArray *questionArray;    // 上の句を出題順に格納する
- (void) makeQuestionArrayWithOrder:(NSInteger) order;

@end
