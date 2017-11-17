//
//  PlayingViewController.m
//  simpleKaruta
//
//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "PlayingViewController.h"
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
        [self changeKaminokuWithCount:self.questionCount];
        
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

#pragma mark - ボタンタップ時処理
// 閉じるボタン
// TODO:ゆくゆくはpause button にして、一時停止orゲーム終了を選べるようにしたい
- (IBAction)tappedStopButton:(id)sender {
    NSLog(@"tapped stop button!");
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [self changeQuestionCountLabelWithCount:self.questionCount];
    [self changeCorrectCountLabelWithCount:self.correctCount];

    // 問題文と取り札の表示を更新
    [self changeKaminokuWithCount:self.questionCount];
    [self changeCardsWithCount:self.questionCount];
    
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
    
    // 各カウントを更新
    self.questionCount++;
    [self changeQuestionCountLabelWithCount:self.questionCount];
    
    // 問題文と取り札の表示を更新
    [self changeKaminokuWithCount:self.questionCount];
    [self changeCardsWithCount:self.questionCount];

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


- (void)changeCardsWithCount:(NSInteger)count {
    
    // TODO:ここもっと効率的にできないか？？
    for (UIView *view in [self.card1 subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.card2 subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.card3 subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.card4 subviews]) {
        [view removeFromSuperview];
    }


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
    
    // 取り札ビューに歌番号を持たせる
    self.card1.tankaNo = [sortedArray[0][@"no"] integerValue];
    self.card2.tankaNo = [sortedArray[1][@"no"] integerValue];
    self.card3.tankaNo = [sortedArray[2][@"no"] integerValue];
    self.card4.tankaNo = [sortedArray[3][@"no"] integerValue];
    
    
    // 並べ替えた下の句をひとつずつ縦書き変換する
    NSString *card1Str = sortedArray[0][@"sentence"][0];
    card1Str = [card1Str stringByAppendingString:sortedArray[0][@"sentence"][1]];
    card1Str = [self separateFiveCharactersSentence:card1Str];
    NSString *card2Str = sortedArray[1][@"sentence"][0];
    card2Str = [card2Str stringByAppendingString:sortedArray[1][@"sentence"][1]];
    card2Str = [self separateFiveCharactersSentence:card2Str];
    NSString *card3Str = sortedArray[2][@"sentence"][0];
    card3Str = [card3Str stringByAppendingString:sortedArray[2][@"sentence"][1]];
    card3Str = [self separateFiveCharactersSentence:card3Str];
    NSString *card4Str = sortedArray[3][@"sentence"][0];
    card4Str = [card4Str stringByAppendingString:sortedArray[3][@"sentence"][1]];
    card4Str = [self separateFiveCharactersSentence:card4Str];
    
    // 表示する文章を指定して取り札viewに文章をaddする
    // 位置は0,0で指定しないと、取り札にaddしたときに変な位置に表示されてしまう
    CGRect rect = CGRectMake(0, 0, self.card1.frame.size.height, self.card1.frame.size.width);
    TTTAttributedLabel *label1 = [self makeVerticalWritingLabelWithText:card1Str rect:rect];
    [self.card1 addSubview:label1];
    TTTAttributedLabel *label2 = [self makeVerticalWritingLabelWithText:card2Str rect:rect];
    [self.card2 addSubview:label2];
    TTTAttributedLabel *label3 = [self makeVerticalWritingLabelWithText:card3Str rect:rect];
    [self.card3 addSubview:label3];
    TTTAttributedLabel *label4 = [self makeVerticalWritingLabelWithText:card4Str rect:rect];
    [self.card4 addSubview:label4];
    
}

// 出題数の表示を変える
- (void)changeQuestionCountLabelWithCount:(NSInteger)count {
    self.questionCountLabel.text = [NSString stringWithFormat:@"%ld/%ld",count+1,self.totalNumberQuestions];
}


// 正答数の表示を変える
- (void)changeCorrectCountLabelWithCount:(NSInteger)count {
    self.correctCountLabel.text = [NSString stringWithFormat:@"正答数 %ld",count];
}


// 取り札表示用文言を作る
// 5文字ずつで改行したテキストを返す
-(NSString *)separateFiveCharactersSentence:(NSString *)text {

    NSString *formattedText = @"";
    formattedText = [[text substringToIndex:5] stringByAppendingString:@"\n"];
    formattedText = [[formattedText stringByAppendingString:[text substringWithRange:NSMakeRange(5, 5)]] stringByAppendingString:@"\n"];
    formattedText = [formattedText stringByAppendingString:[text substringFromIndex:10]];

    return formattedText;
}


// 縦書きラベルを作るメソッド
- (TTTAttributedLabel *)makeVerticalWritingLabelWithText:(NSString *)text rect:(CGRect) rect {
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)];
    label.backgroundColor = [UIColor clearColor];
    
    // setText の前にラベルオプションを変更する
    label.textColor = [UIColor blackColor];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:28];
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
