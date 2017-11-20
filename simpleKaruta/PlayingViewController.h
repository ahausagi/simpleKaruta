//
//  PlayingViewController.h
//  simpleKaruta
//  ゲーム画面

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "ResultViewController.h"
#import "PauseViewController.h"

@interface PlayingViewController : UIViewController <CardViewDelegate, ResultVCDelegate, PauseVCDelegate>

// 遷移前画面から受け取る情報
@property (nonatomic) NSMutableArray *questionArray;
@property (nonatomic) NSMutableArray *answersArray;

// storyboardのアイテム
@property (weak, nonatomic) IBOutlet UILabel *questionCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UILabel *questionText1;
@property (weak, nonatomic) IBOutlet UILabel *questionText2;
@property (weak, nonatomic) IBOutlet UILabel *questionText3;

@property (weak, nonatomic) IBOutlet CardView *card1;
@property (weak, nonatomic) IBOutlet CardView *card2;
@property (weak, nonatomic) IBOutlet CardView *card3;
@property (weak, nonatomic) IBOutlet CardView *card4;

@end

