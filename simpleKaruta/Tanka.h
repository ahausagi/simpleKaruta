//
//  Tanka.h
//  simpleKaruta
//  歌データを持つクラス

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tanka : NSObject

@property (nonatomic) NSMutableArray *allTankaArray;
@property (nonatomic) NSMutableArray *firstPartsArray;  // 上の句
@property (nonatomic) NSMutableArray *lastPartsArray;   // 下の句
- (BOOL) prepareAllTanka;

@end
