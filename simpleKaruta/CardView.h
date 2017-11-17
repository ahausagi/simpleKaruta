//
//  CardView.h
//  simpleKaruta
//  取り札のビュー

//  Created by ahausagi on 2017/09/14.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@protocol CardViewDelegate <NSObject>
- (void)tappedCardWithNo:(NSInteger)selectedNo;
@end

@interface CardView : UIView
@property(nonatomic, assign) id <CardViewDelegate> delegate;
@property (nonatomic) NSInteger tankaNo;    // 表示している句の歌番号
@property (nonatomic) TTTAttributedLabel *text; // 下の句を表示する縦書きラベル

- (void) setGesture;
@end

