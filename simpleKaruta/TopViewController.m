//
//  TopViewController.m
//  simpleKaruta
//  トップ画面

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "TopViewController.h"
#import "Tanka.h"

@interface TopViewController ()

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Tankaクラスのテスト
    Tanka *tanka = [[Tanka alloc] init];
    [tanka prepareAllTanka];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
