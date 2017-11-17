//
//  PlayingViewController.h
//  simpleKaruta
//  ゲーム画面

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface PlayingViewController : UIViewController <CardViewDelegate>

// 遷移前画面から受け取る情報
@property (nonatomic) NSMutableArray *questionArray;
@property (nonatomic) NSMutableArray *torifudaArray;

// storyboardのアイテム
@property (weak, nonatomic) IBOutlet UILabel *questionCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *correctCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *kaminoku1;
@property (weak, nonatomic) IBOutlet UILabel *kaminoku2;
@property (weak, nonatomic) IBOutlet UILabel *kaminoku3;

@property (weak, nonatomic) IBOutlet CardView *card1;
@property (weak, nonatomic) IBOutlet CardView *card2;
@property (weak, nonatomic) IBOutlet CardView *card3;
@property (weak, nonatomic) IBOutlet CardView *card4;

@end

