//
//  TopViewController.m
//  simpleKaruta
//  トップ画面

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "TopViewController.h"
#import "Questions.h"
#import "Torifuda.h"

@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // TODO:デバッグ用　あとで消す
    // Questionクラスのテスト
    Questions *questions = [[Questions alloc] init];
    [questions makeQuestionArrayWithOrder:2];
    
    if ([questions.questionArray count] > 0) {
        // Torifudaクラスのテスト
        Torifuda *torifuda = [[Torifuda alloc] init];
        [torifuda makeAnswerArrayWithQuestions:questions.questionArray];
    }
    
    
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
