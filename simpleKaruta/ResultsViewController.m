//
//  ResultsViewController.m
//  simpleKaruta
//  成績画面

//  Created by ahausagi on 2017/11/22.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "ResultsViewController.h"
#import "ResultsLogic.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView
- (IBAction)tappedBackButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)   {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.backgroundColor = [UIColor magentaColor];

    return cell;
}

@end
