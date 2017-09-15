//
//  TorifudaView.h
//  simpleKaruta
//  取り札のビュー

//  Created by ahausagi on 2017/09/14.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTAttributedLabel.h"

@interface TorifudaView : UIView

@property (nonatomic) NSInteger tankaNo;    // 表示している句の歌番号
@property (nonatomic) TTTAttributedLabel *text; // 下の句を表示する縦書きラベル

@end

