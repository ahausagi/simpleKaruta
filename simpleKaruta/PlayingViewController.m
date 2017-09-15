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
        
        // 取り札を表示
        [self changeTorifudaWithCount:self.questionCount];

    } else {
        NSLog(@"question or torifuda not found");
    }
}


#pragma mark - ボタンタップ時処理
// TODO: 札タップ時に呼ばれるメソッド作る。
// 正解の札かどうかチェックして、tappedCorrectCard / tappedWrongCard どちらかのメソッドを呼び出す


// 正しい札を選んだとき
- (void)tappedCorrectCard {
    // 各カウントを更新
    self.questionCount++;
    self.correctCount++;
    [self changeQuestionCountLabelWithCount:self.questionCount];
    [self changeCorrectCountLabelWithCount:self.correctCount];

    // 問題文と取り札の表示を更新
    [self changeKaminokuWithCount:self.questionCount];
    [self changeTorifudaWithCount:self.questionCount];
    
}


// 間違った札を選んだとき
- (void)tappedWrongCard {
    // TODO: バツとか表示させる？
    // TODO: 間違った札を消すとかする？
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


- (void)changeTorifudaWithCount:(NSInteger)count {
    
    // TODO:ここもっと効率的にできないか？？
    for (UIView *view in [self.torifuda1 subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.torifuda2 subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.torifuda3 subviews]) {
        [view removeFromSuperview];
    }
    for (UIView *view in [self.torifuda4 subviews]) {
        [view removeFromSuperview];
    }


    NSArray *lastPartsArray = self.torifudaArray[count];  // 問題文に対応した下の句リスト
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
    self.torifuda1.tankaNo = [sortedArray[0][@"no"] integerValue];
    self.torifuda2.tankaNo = [sortedArray[1][@"no"] integerValue];
    self.torifuda3.tankaNo = [sortedArray[2][@"no"] integerValue];
    self.torifuda4.tankaNo = [sortedArray[3][@"no"] integerValue];
    
    
    // 並べ替えた下の句をひとつずつ縦書き変換する
    NSString *torifuda1Str = sortedArray[0][@"sentence"][0];
    torifuda1Str = [torifuda1Str stringByAppendingString:sortedArray[0][@"sentence"][1]];
    torifuda1Str = [self separateFiveCharactersSentence:torifuda1Str];
    NSString *torifuda2Str = sortedArray[1][@"sentence"][0];
    torifuda2Str = [torifuda2Str stringByAppendingString:sortedArray[1][@"sentence"][1]];
    torifuda2Str = [self separateFiveCharactersSentence:torifuda2Str];
    NSString *torifuda3Str = sortedArray[2][@"sentence"][0];
    torifuda3Str = [torifuda3Str stringByAppendingString:sortedArray[2][@"sentence"][1]];
    torifuda3Str = [self separateFiveCharactersSentence:torifuda3Str];
    NSString *torifuda4Str = sortedArray[3][@"sentence"][0];
    torifuda4Str = [torifuda4Str stringByAppendingString:sortedArray[3][@"sentence"][1]];
    torifuda4Str = [self separateFiveCharactersSentence:torifuda4Str];
    
    // 表示する文章を指定して取り札viewに文章をaddする
    // 位置は0,0で指定しないと、取り札にaddしたときに変な位置に表示されてしまう
    CGRect rect = CGRectMake(0, 0, self.torifuda1.frame.size.height, self.torifuda1.frame.size.width);
    TTTAttributedLabel *label1 = [self makeVerticalWritingLabelWithText:torifuda1Str rect:rect];
    [self.torifuda1 addSubview:label1];
    TTTAttributedLabel *label2 = [self makeVerticalWritingLabelWithText:torifuda2Str rect:rect];
    [self.torifuda2 addSubview:label2];
    TTTAttributedLabel *label3 = [self makeVerticalWritingLabelWithText:torifuda3Str rect:rect];
    [self.torifuda3 addSubview:label3];
    TTTAttributedLabel *label4 = [self makeVerticalWritingLabelWithText:torifuda4Str rect:rect];
    [self.torifuda4 addSubview:label4];
    
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
