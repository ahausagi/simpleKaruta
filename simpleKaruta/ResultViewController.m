//
//  ResultViewController.m
//  simpleKaruta
//  成績画面

//  Created by ahausagi on 2017/11/17.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultsLogic.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 結果の数値を代入
    self.resultLabel.text = [NSString stringWithFormat:@"%ld / %ld",(long)self.correctCount, (long)self.questionCount];
    CGFloat percent = (float)self.correctCount/(float)self.questionCount * 100;
    CGFloat numRound = roundf(percent*10)/10;
    self.percentLabel.text = [NSString stringWithFormat:@"%.1f%%正解！", numRound];
    
    // 結果をDBに格納
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale systemLocale]];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH時mm分"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    
    [[[ResultsLogic alloc] init] insertResultsWithDate:strDate questionCount:self.questionCount correctCount:self.correctCount];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// はじめにもどるボタン
- (IBAction)tappedBackButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate backTopViewFromResult];
}

@end
