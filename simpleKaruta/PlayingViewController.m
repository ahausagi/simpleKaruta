//
//  PlayingViewController.m
//  simpleKaruta
//
//  Created by cmlab on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "PlayingViewController.h"

@interface PlayingViewController()

@end

@implementation PlayingViewController

- (void)viewDidLoad {
    NSLog(@"questionArray count:%ld",[self.questionArray count]);
    NSLog(@"torifudaArray count:%ld",[self.torifudaArray count]);

    self.kaminoku1.text = self.questionArray[0][@"sentence"][0];
    self.kaminoku2.text = self.questionArray[0][@"sentence"][1];
    self.kaminoku3.text = self.questionArray[0][@"sentence"][2];
}

- (IBAction)tappedStopButton:(id)sender {
    NSLog(@"tapped stop button!");
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
