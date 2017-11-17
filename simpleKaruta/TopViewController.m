//
//  TopViewController.m
//  simpleKaruta
//  トップ画面

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "TopViewController.h"
#import "PlayingViewController.h"
#import "Questions.h"
#import "Answers.h"

@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 遷移前に呼ばれる処理。次の画面に渡す情報を作る
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"startNewGameSegue"]) {  // はじめから
        
        // TODO: 最終的には順番選択画面を挟むつもりだが、現時点ではとりあえず固定でランダム出題にしておく
        
        PlayingViewController *playingVC = segue.destinationViewController;
        
        // 問題文配列を作成して次画面へ渡す
        NSMutableArray *questionArray = [[[Questions alloc] init] makeQuestionArrayWithOrder:2];
        playingVC.questionArray = questionArray;

        // 取り札配列を作成して次画面へ渡す
        NSMutableArray *answersArray = [[[Answers alloc] init] makeAnswerArrayWithQuestions:questionArray];
        playingVC.answersArray = answersArray;
        
    } else {
        // TODO: つづきから　タップ時の処理とか書き足す
    }
}

@end
