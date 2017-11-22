//
//  BaseDBLogic.h
//  simpleKaruta
//
//  Created by ahausagi on 2017/11/21.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface BaseDBLogic : NSObject

// DBインスタンスを返す
- (FMDatabase *) getDB;
	
// クラッシュ時のハンドリング(NSLog吐いてthrowさせる)
- (void)crashException:(NSException *)exception;

@end
