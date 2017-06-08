//
//  Torifuda.h
//  simpleKaruta
//  取り札用の下の句配列を作成するクラス

//  Created by cmlab on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Torifuda : NSObject

@property (nonatomic) NSMutableArray *answerArray;    // 下の句を出題順に格納する


- (void) makeAnswerArrayWithQuestions:(NSArray *) questionArray;

@end
