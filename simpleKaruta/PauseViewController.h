//
//  PauseViewController.h
//  simpleKaruta
//  一時停止画面

//  Created by ahausagi on 2017/11/20.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PauseVCDelegate <NSObject>
- (void)backTopViewFromPause;
@end

@interface PauseViewController : UIViewController
@property(nonatomic, assign) id <PauseVCDelegate> delegate;

@end

