//
//  DBManager.h
//  simpleKaruta
//
//  Created by ahausagi on 2017/11/21.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface DBManager : NSObject

-(NSString *)getDBPath;
-(void)dbGenerateOrUpdate;

@end
