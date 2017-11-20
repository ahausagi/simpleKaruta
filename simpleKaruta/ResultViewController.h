//
//  ResultViewController.h
//  simpleKaruta
//  成績画面

//  Created by ahausagi on 2017/11/17.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ResultVCDelegate <NSObject>
- (void)backTopView;
@end

@interface ResultViewController : UIViewController

@property(nonatomic, assign) id <ResultVCDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (nonatomic) NSInteger correctCount;
@property (nonatomic) NSInteger questionCount;

@end

