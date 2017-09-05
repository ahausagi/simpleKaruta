//
//  PlayingViewController.m
//  simpleKaruta
//
//  Created by cmlab on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "PlayingViewController.h"

@interface PlayingViewController()

@property (nonatomic) NSInteger totalNumberQuestions; // 総出題数
@property (nonatomic) NSInteger questionCount; // 何問目か（画面表示するときは+1する）
@property (nonatomic) NSInteger correctCount; // 正答数

@end

@implementation PlayingViewController

- (void)viewDidLoad {
    NSLog(@"questionArray count:%ld",[self.questionArray count]);
    NSLog(@"torifudaArray count:%ld",[self.torifudaArray count]);

    // 各数字を初期化
    self.totalNumberQuestions = 0;
    self.questionCount = 0;
    self.correctCount = 0;
    
    if ([self.questionArray count] > 0 && [self.torifudaArray count] > 0) {
       
        self.totalNumberQuestions = [self.questionArray count];

        // 問題数を表示
        [self changeQuestionCountLabelWithCount:self.questionCount];

        // 正答数を表示
        [self changeCorrectCountLabelWithCount:self.correctCount];
        
        // 1問目を表示
        [self changeKaminokuWithCount:self.questionCount];

    } else {
        NSLog(@"question or torifuda not found");
    }
}


#pragma mark - ボタンタップ時処理
// 正しい札を選んだとき
- (void)tappedCorrectCard {
    self.questionCount++;
    self.correctCount++;

    [self changeKaminokuWithCount:self.questionCount];
    [self changeQuestionCountLabelWithCount:self.questionCount];
    [self changeCorrectCountLabelWithCount:self.correctCount];
}


// 閉じるボタン
- (IBAction)tappedStopButton:(id)sender {
    NSLog(@"tapped stop button!");
    
    // TODO: デバッグ中　押したら次の問題を表示
    [self tappedCorrectCard];
    
    // TODO: 本来はこっちの処理をする
    //    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 表示を変える系
// 問題文の表示を変える
- (void)changeKaminokuWithCount:(NSInteger)count {
    self.kaminoku1.text = self.questionArray[count][@"sentence"][0];
    self.kaminoku2.text = self.questionArray[count][@"sentence"][1];
    self.kaminoku3.text = self.questionArray[count][@"sentence"][2];

    self.kaminoku1.alpha = 0;
    self.kaminoku2.alpha = 0;
    self.kaminoku3.alpha = 0;

    // ゆっくり表示
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{_kaminoku1.alpha = 1;_kaminoku2.alpha = 1;_kaminoku3.alpha = 1;}
                     completion:nil];


}


// 出題数の表示を変える
- (void)changeQuestionCountLabelWithCount:(NSInteger)count {
    self.questionCountLabel.text = [NSString stringWithFormat:@"%ld/%ld",count+1,self.totalNumberQuestions];
}


// 正答数の表示を変える
- (void)changeCorrectCountLabelWithCount:(NSInteger)count {
    self.correctCountLabel.text = [NSString stringWithFormat:@"正答数 %ld",count];
}




@end
