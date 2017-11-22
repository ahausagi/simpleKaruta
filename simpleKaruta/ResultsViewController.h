//
//  ResultsViewController.h
//  simpleKaruta
//  成績画面

//  Created by ahausagi on 2017/11/22.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

