//
//  CardView.m
//  simpleKaruta
//
//  Created by ahausagi on 2017/09/14.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "CardView.h"

@interface CardView()
@end

@implementation CardView

- (void) setGesture {
    
    // TODO: 連打防止入れたい
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handleTapAction)];
    [self addGestureRecognizer:tapped];
    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
//                                      initWithTarget:self
//                                      action:@selector(longPressAction)];
//    [self addGestureRecognizer:longPress];

}

- (void) handleTapAction{
    [self.delegate tappedCardWithNo:self.tankaNo];
}

//- (void) longPressAction{
//    self.backgroundColor = [UIColor lightGrayColor];
//    [UIView animateWithDuration:0.2
//                          delay:0
//                        options:UIViewAnimationOptionLayoutSubviews
//                     animations:^{self.backgroundColor = [UIColor whiteColor];}
//                     completion:nil];
//    
//}

@end
