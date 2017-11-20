//
//  CardView.m
//  simpleKaruta
//
//  Created by ahausagi on 2017/09/14.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "CardView.h"
#import "TTTAttributedLabel.h"

@interface CardView()
@end

@implementation CardView

- (void) setGesture {
    
    // TODO: 連打防止入れたい
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handleTapAction)];
    [self addGestureRecognizer:tapped];
}


- (void) handleTapAction{
    [self.delegate tappedCardWithNo:self.tankaNo];
}


// 取り札の下の句表示を変える
- (void) displayNextText:(NSDictionary *)dict {

    // 初期化
    for (UIView *view in [self subviews]) {
        [view removeFromSuperview];
    }
    
    // 取り札に歌番号を持たせる
    self.tankaNo = [dict[@"no"] integerValue];
    
    // 下の句を5文字ずつに分割
    NSString *separatedText = dict[@"sentence"][0];
    separatedText = [separatedText stringByAppendingString:dict[@"sentence"][1]];
    separatedText = [self separateFiveCharactersSentence:separatedText];

    // 取り札に下の句をaddする
    // 位置は0,0で指定しないと、取り札にaddしたときに変な位置に表示されてしまう
    CGRect rect = CGRectMake(0, 0, self.frame.size.height, self.frame.size.width);
    TTTAttributedLabel *verticalText = [self makeVerticalWritingLabelWithText:separatedText rect:rect];
//    [verticalText sizeToFit];
    [self addSubview:verticalText];
}


// 5文字ずつで改行したテキストを返す
-(NSString *)separateFiveCharactersSentence:(NSString *)text {
    
    NSString *formattedText = @"";
    formattedText = [[text substringToIndex:5] stringByAppendingString:@"\n"];
    formattedText = [[formattedText stringByAppendingString:[text substringWithRange:NSMakeRange(5, 5)]] stringByAppendingString:@"\n"];
    formattedText = [formattedText stringByAppendingString:[text substringFromIndex:10]];
    
    return formattedText;
}

// TODO: 札いっぱいにバランスよく文字が表示されるようにする
// 縦書きラベルを作るメソッド
- (TTTAttributedLabel *)makeVerticalWritingLabelWithText:(NSString *)text rect:(CGRect) rect {
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    label.backgroundColor = [UIColor clearColor];
    
    // setText の前にラベルオプションを変更する
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:36];
    label.verticalAlignment = TTTAttributedLabelVerticalAlignmentTop;
    
    // ラベルを90°回転させる
    CGFloat angle = M_PI/2;
    label.transform = CGAffineTransformMakeRotation(angle);
    // 表示する文章を指定する
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString)
     {
         // 文章を縦書きに変更する
         [mutableAttributedString addAttribute:(NSString *)kCTVerticalFormsAttributeName value:[NSNumber numberWithBool:YES] range:NSMakeRange(0, [mutableAttributedString length])];
         return mutableAttributedString;
     }];
    
    label.frame = CGRectMake(rect.origin.x, rect.origin.y, label.frame.size.width, label.frame.size.height);
    return label;
}

@end
