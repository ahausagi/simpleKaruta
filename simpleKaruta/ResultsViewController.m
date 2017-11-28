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
@property (nonatomic) NSArray *resultsArray;
@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    NSArray *resultsArray = [[[ResultsLogic alloc] init] selectResults];
    if ([resultsArray count] > 0) {
        self.resultsArray = [[[ResultsLogic alloc] init]sortResultsArrayInDescOrderOfPercentage];

    } else {
        self.resultsArray = [NSArray array];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - TableView
- (IBAction)tappedBackButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.resultsArray count] > 0) {
        return 10;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(!cell)   {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([self.resultsArray count] > 0) {
        if ([self.resultsArray count] > row) {
            NSString *date = self.resultsArray[row][@"date"];
            NSNumber *perNum = self.resultsArray[indexPath.row][@"percentage"];
            CGFloat perFloat = [perNum floatValue];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld位: %.1f%%", indexPath.row+1, perFloat];
            cell.detailTextLabel.text = date;
        }
        
    } else {
        cell.textLabel.text = @"成績情報がありません";
    }

    return cell;
}

@end
