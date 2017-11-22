//
//  ResultPopupViewController.h
//  simpleKaruta
//  成績ポップアップ

//  Created by ahausagi on 2017/11/17.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ResultPopupDelegate <NSObject>
- (void)backTopViewFromResult;
@end

@interface ResultPopupViewController : UIViewController

@property(nonatomic, assign) id <ResultPopupDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (nonatomic) NSInteger correctCount;
@property (nonatomic) NSInteger questionCount;

@end

