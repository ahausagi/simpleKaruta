//
//  BaseDBLogic.m
//  simpleKaruta
//
//  Created by ahausagi on 2017/11/21.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "BaseDBLogic.h"
#import "DBManager.h"

@implementation BaseDBLogic

- (FMDatabase *) getDB {
	return [FMDatabase databaseWithPath:[[[DBManager alloc] init] getDBPath]];
}

- (void) crashException:(NSException *)exception{
	@throw exception;
}


@end
