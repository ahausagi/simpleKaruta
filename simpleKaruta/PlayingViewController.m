//
//  PlayingViewController.m
//  simpleKaruta
//
//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "PlayingViewController.h"
#import "ResultViewController.h"
#import "TTTAttributedLabel.h"

@interface PlayingViewController()

@property (nonatomic) NSInteger totalNumberQuestions; // 総出題数
@property (nonatomic) NSInteger questionCount; // 何問目か（画面表示するときは+1する）
@property (nonatomic) NSInteger correctCount; // 正答数
@property (nonatomic) UIImageView *circleIcon; // ○画像
@property (nonatomic) UIImageView *wrongIcon; // ×画像

@end

@implementation PlayingViewController

- (void)viewDidLoad {
    // 各数字を初期化
    self.totalNumberQuestions = 0;
    self.questionCount = 0;
    self.correctCount = 0;
    
    if ([self.questionArray count] > 0 && [self.answersArray count] > 0) {
       
        self.totalNumberQuestions = [self.questionArray count];
        
        // 取り札の初期設定
        [self settingCards];

        // 問題数を表示
        [self changeQuestionCountLabelWithCount:self.questionCount];

        // 正答数を表示
        [self changeCorrectCountLabelWithCount:self.correctCount];
        
        // 1問目を表示
        [self changeQuestionTextWithCount:self.questionCount];
        
        // 取り札を表示
        [self changeCardsWithCount:self.questionCount];
        
        // 正解・不正解の画像を作る
        [self settingImgaes];
        
    } else {
        NSLog(@"question or answer not found");
    }
}

- (void) settingCards {
    
    // デリゲートの設定
    self.card1.delegate = self;
    self.card2.delegate = self;
    self.card3.delegate = self;
    self.card4.delegate = self;
    
    // タップアクションの設定
    [self.card1 setGesture];
    [self.card2 setGesture];
    [self.card3 setGesture];
    [self.card4 setGesture];
    
}

- (void) settingImgaes {
    
    // まる
    UIImageView *circleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"circleIcon"]];
    circleImage.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    [self.view addSubview: circleImage];
    self.circleIcon = circleImage;
    self.circleIcon.hidden = YES;
    
    // ばつ
    UIImageView *wrongImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrongIcon"]];
    wrongImage.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    [self.view addSubview: wrongImage];
    self.wrongIcon = wrongImage;
    self.wrongIcon.hidden = YES;
}

#pragma mark - 遷移処理
// 一時停止画面へ遷移
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"pauseSegue"]) {
        PauseViewController *pauseVC = segue.destinationViewController;
        pauseVC.delegate = self;
        
    } else { /* 何もしない */ }
}


// 結果画面を表示する
- (void)transitionToResultVC {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ResultViewController *resultVC = [storyboard instantiateViewControllerWithIdentifier:@"ResultViewController"];
    resultVC.delegate = self;
    resultVC.modalPresentationStyle = UIModalTransitionStyleCrossDissolve;
    resultVC.correctCount = self.correctCount;
    resultVC.questionCount = self.totalNumberQuestions;
    [self presentViewController:resultVC animated:YES completion:nil];
}

#pragma mark - CardViewDelegate メソッド
// 取り札をタップした
- (void)tappedCardWithNo:(NSInteger)selectedNo {
    if ([self isCorrectCard:selectedNo]) {
        [self selectedCorrectCard];
    } else {
        [self selectedWrongCard];
    }
}

#pragma mark - 正否判定系
// 選んだ札が正解の札かを判定する
- (BOOL) isCorrectCard:(NSInteger)selectedNo {
    
    // 正解の歌番号
    NSInteger correctNo = [self.questionArray[self.questionCount][@"no"] integerValue];
    if (selectedNo == correctNo) {
        return YES;
    } else {
        return NO;
    }
}

// 正しい札を選んだとき
- (void)selectedCorrectCard {
    
    // マルを表示
    self.circleIcon.alpha = 1.0;
    self.circleIcon.hidden = NO;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{self.circleIcon.alpha = 0;}
                     completion:nil];

    
    // 各カウントを更新
    self.questionCount++;
    self.correctCount++;
    
    if (self.questionCount < self.totalNumberQuestions) {
        // 何問目、正答数の表示を更新
        [self changeQuestionCountLabelWithCount:self.questionCount];
        [self changeCorrectCountLabelWithCount:self.correctCount];
        
        // 問題文と取り札の表示を更新
        [self changeQuestionTextWithCount:self.questionCount];
        [self changeCardsWithCount:self.questionCount];
        
    } else {
        // 誤タップ防止
        self.view.userInteractionEnabled = NO;
        // 結果表示
        [self transitionToResultVC];
    }
}


// 間違った札を選んだとき
- (void)selectedWrongCard {
    
    // バツを表示
    self.wrongIcon.alpha = 1.0;
    self.wrongIcon.hidden = NO;
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{self.wrongIcon.alpha = 0;}
                     completion:nil];
    
    // カウントを更新
    self.questionCount++;
    
    if (self.questionCount < self.totalNumberQuestions) {
        // 何問目、正答数の表示を更新
        [self changeQuestionCountLabelWithCount:self.questionCount];
        
        // 問題文と取り札の表示を更新
        [self changeQuestionTextWithCount:self.questionCount];
        [self changeCardsWithCount:self.questionCount];
        
    } else {
        // 誤タップ防止
        self.view.userInteractionEnabled = NO;
        // 結果表示
        [self transitionToResultVC];
    }
}

#pragma mark - ResultVCDelegate メソッド
- (void)backTopViewFromResult {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PauseVCDelegate メソッド
- (void)backTopViewFromPause {
    self.view.userInteractionEnabled = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 表示を変える系
// 出題数の表示を変える
- (void)changeQuestionCountLabelWithCount:(NSInteger)count {
    self.questionCountLabel.text = [NSString stringWithFormat:@"%ld/%ld",count+1,self.totalNumberQuestions];
}


// 正答数の表示を変える
- (void)changeCorrectCountLabelWithCount:(NSInteger)count {
    self.correctCountLabel.text = [NSString stringWithFormat:@"正答数 %ld",count];
}


// 問題文の表示を変える
- (void)changeQuestionTextWithCount:(NSInteger)count {
    
    self.questionText1.text = self.questionArray[count][@"sentence"][0];
    self.questionText2.text = self.questionArray[count][@"sentence"][1];
    self.questionText3.text = self.questionArray[count][@"sentence"][2];

    self.questionText1.alpha = 0;
    self.questionText2.alpha = 0;
    self.questionText3.alpha = 0;

    // ゆっくり表示
    [UIView animateWithDuration:1
                          delay:0
                        options:UIViewAnimationOptionLayoutSubviews
                     animations:^{_questionText1.alpha = 1;_questionText2.alpha = 1;_questionText3.alpha = 1;}
                     completion:nil];


}


// 取り札の表示を変える
- (void)changeCardsWithCount:(NSInteger)count {
    
    NSArray *lastPartsArray = self.answersArray[count];  // 問題文に対応した下の句リスト
    // 下の句をランダムに並べ替える
    NSMutableArray *sortedArray = [NSMutableArray array];  // ランダムに並べ替えたリスト
    
    NSMutableArray *numArray = [NSMutableArray array];  // ランダム数字リスト
    while ([numArray count] < 4) {
        int randomNum = (int)arc4random_uniform(4);
        
        BOOL existsInArr = NO;
        for (NSNumber *num in numArray) {
            if (num.intValue == randomNum) {
                // 既出
                existsInArr = YES;
            }
        }
        
        if (existsInArr == NO) {    // 初出
            [numArray addObject:@(randomNum)];
        }
    }

    for (NSNumber *num in numArray) {
        [sortedArray addObject:lastPartsArray[[num integerValue]]];
    }
    
    // 表示を更新
    [self.card1 displayNextText:sortedArray[0]];
    [self.card2 displayNextText:sortedArray[1]];
    [self.card3 displayNextText:sortedArray[2]];
    [self.card4 displayNextText:sortedArray[3]];
}


@end
