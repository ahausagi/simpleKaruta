//
//  DBManager.m
//  simpleKaruta
//
//  Created by ahausagi on 2017/11/21.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

NSString *const DB_FILE_NAME = @"simpleKaruta.db";
NSInteger const DB_VERSION = 1;
NSString *const DB_UPGRADE_BASE_FILE_NAME = @"simpleKaruta_upgrade_";
// 今後DBをアップデートするときは、"simpleKaruta_upgrade_2.sql"というファイルに差分SQLを記述

// TODO: 説明文書く
/*
 * ver_1 :
 */


- (FMDatabase *) getDB {
    return [FMDatabase databaseWithPath:[[[DBManager alloc] init] getDBPath]];
}


- (NSString *)getDBPath {
	NSArray* paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* dbPath = [paths objectAtIndex:0];
	dbPath = [dbPath stringByAppendingPathComponent:DB_FILE_NAME];
	return dbPath;
}


- (NSInteger) getDBVersion {
    
    NSInteger version = 0;
    FMDatabase *db = [self getDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM DBVersion"];
    
    @try {
        [db open];
        FMResultSet *results = [db executeQuery:sql];
        while([results next] )
        {
            version = [results intForColumnIndex:0];
        }
        
    } @catch (NSException *exception) {
        @throw exception;
        
    } @finally {
        [db close];
    }
    
    return version;
}


#pragma mark - DB生成、アップデート
// DBの生成orアップデート処理を行う
- (void)dbGenerateOrUpdate {
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if ([fileManager fileExistsAtPath:[self getDBPath]]) {
		// DBファイルが存在する
		// DBに保存してあるDBVersionとver変数の比較を行う
        NSInteger nowVersion = [self getDBVersion];
        NSInteger newVersion = DB_VERSION;
        if (nowVersion != 0 && nowVersion != newVersion) {
            // バージョン情報の更新
            [self onUpgrade:nowVersion newVersion:newVersion];
        }
	} else {
		// DBファイルが存在しない
		[self generateDBAndDefineDefaultData];
	}

}


// DB生成処理&デフォルトデータ設定
-(void)generateDBAndDefineDefaultData {

    FMDatabase *db = [self getDB];
	
	// テーブル作成
	[self createDBVersionTable:db];
    [self createResultsTable:db];
	
	// 初期データ挿入
	[self insertDefaultDBVersion];

}


// DBのアップデート処理
-(void)onUpgrade:(NSInteger)nowVersion newVersion:(NSInteger)newVersion {
    
    // 差分からループ数を確定する
    NSInteger roopCount = newVersion - nowVersion;
    FMDatabase *db = [self getDB];
    __block BOOL isTotalSuccess = YES;
    
    for(NSInteger i = 1; i <= roopCount; i++) {
        
        // 1バージョンごとにアップデートしていく
        if(!isTotalSuccess){
            // 2段階以降のアプデ時に途中で失敗していた場合
            break;
        }
        
        @try {
            // SQLファイルから実行するSQLごとにパース
            NSString *nextVersion = [NSString stringWithFormat:@"%zd" , (nowVersion + i)];
            NSString *sqlFileName = [NSString stringWithFormat:@"%@%@", DB_UPGRADE_BASE_FILE_NAME,nextVersion];
            NSString *filePath = [[NSBundle mainBundle] pathForResource:sqlFileName ofType:@"sql"];
            NSError *error = nil;
            
            __block BOOL isUpdateSuccess = YES;
            NSString *sqlText = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
            if (error) { // ファイル参照失敗
                isTotalSuccess = NO;
                break;
            }
            
            NSArray *sqlArray = [sqlText componentsSeparatedByString:@";\n"];
            
            [db open];
            [db beginTransaction];
            // ファイルエンコードの関係上、行替えコード or 空文字が入る可能性があるため、
            // 5文字制限をかけておく
            int minLength = 5;
            
            // アップデートSQL実行
            [sqlArray enumerateObjectsUsingBlock:^(NSString *sql, NSUInteger idx, BOOL * _Nonnull stop) {
                if(sql.length < minLength) {
                    // パースの関係で最後の文字が発生した場合
                } else {
                    isUpdateSuccess = [db executeUpdate:sql];
                    if(!isUpdateSuccess) {
                        // SQL実行失敗なのでロールバック
                        [db rollback];
                        // 次のバージョンへ更新させない
                        isTotalSuccess = NO;
                        *stop = YES;
                    } else {
                        // 成功したので次のSQLへ
                    }
                }
            }];
            
            // DBVarsion更新処理
            if(!isUpdateSuccess) {
                // 失敗しているのでDBの情報を更新しない
            } else {
                NSString *deleteSQL = [NSString stringWithFormat:@"DELETE FROM DBVersion"];
                if(![db executeUpdate:deleteSQL]){
                    isUpdateSuccess = NO;
                }
                
                // DELETEに成功したらINSERT
                if (isUpdateSuccess) {
                    NSString *insertSQL = @"INSERT INTO DBVersion (version) VALUES (?);";
                    isUpdateSuccess = [db executeUpdate:insertSQL, nextVersion];
                }
                
                if(!isUpdateSuccess){
                    // 失敗したのでロールバック
                    [db rollback];
                    isTotalSuccess = NO;
                } else {
                    // 1バージョン全てSQLは問題ないのでコミット
                    [db commit];
                }
            }
            
        } @catch (NSException *exception) {
            @throw exception;
            
        } @finally {
            [db close];
        }
        
    }
    
    if(isTotalSuccess) {
        // 最後までアップデート成功
    } else {
        // アップデート失敗
    }
    
}


# pragma mark - テーブル作成
// DBバージョンテーブルを生成
- (BOOL)createDBVersionTable:(FMDatabase *)db {
	
	BOOL isSucceedCreate = YES;
	NSString *createDBVersion = @"CREATE TABLE `DBVersion` (`version` INTEGER);";
	
	@try {
		[db open];
		[db beginTransaction];
		
		isSucceedCreate = [db executeUpdate:createDBVersion];
		
		if(isSucceedCreate){
			[db commit];
		} else {
			[db rollback];
		}
		
	} @catch (NSException *exception) {
		[db rollback];
        @throw exception;
        
	} @finally {
		[db close];
	}
}


// 成績テーブルを生成
- (BOOL)createResultsTable:(FMDatabase *)db {
    
    BOOL isSucceedCreate = YES;
    NSString *createResults = @"CREATE TABLE `Results` (`date` TEXT, `questionCount` INTEGER, `correctCount` INTEGER, `percentage` REAL);";
    
    @try {
        [db open];
        [db beginTransaction];
        
        isSucceedCreate = [db executeUpdate:createResults];
        
        if(isSucceedCreate){
            [db commit];
        } else {
            [db rollback];
        }
        
    } @catch (NSException *exception) {
        [db rollback];
        @throw exception;
        
    } @finally {
        [db close];
    }
}


# pragma mark - 初期データ
// 初期DBバージョン格納
- (void)insertDefaultDBVersion{
	
    FMDatabase *db    = [self getDB];
    BOOL isSucceeded = YES;
    
    @try {
        [db open];
        
        NSString *insertSQL = @"INSERT INTO DBVersion (version) VALUES (?);";
        NSNumber *verNum = [NSNumber numberWithInteger:DB_VERSION];
        if (![db executeUpdate:insertSQL, verNum]) {
            isSucceeded  = NO;
        }
        
        if(isSucceeded){
            [db commit];
        } else {
            [db rollback];
        }

    } @catch (NSException *exception) {
        @throw exception;
        
    } @finally {
        [db close];
    }
    
}


@end
