//
//  PauseViewController.m
//  simpleKaruta
//  一時停止画面

//  Created by ahausagi on 2017/11/20.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "PauseViewController.h"

@interface PauseViewController ()

@end

@implementation PauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)tappedRestart:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)tappedBackTop:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate backTopViewFromPause];
}

@end
