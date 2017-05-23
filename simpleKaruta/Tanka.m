//
//  Tanka.m
//  simpleKaruta
//  歌データを持つクラス

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "Tanka.h"

@interface Tanka ()
@end


@implementation Tanka

/**
 *  歌情報をJSON から取得し配列に格納する
 *  @return 歌情報取得に成功したかどうか。失敗していたらゲーム実行できないのでエラーを出してください
 **/
- (BOOL) prepareAllTanka
{
    BOOL result = NO;
    self.firstPartsArray = [NSMutableArray array];
    self.lastPartsArray = [NSMutableArray array];
    
    // JSON データの読み込み
    
    // ファイルパスを指定して JSON 文字列を取得する
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"allTankaData" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (!error) {
        // NSData に変換する
        NSData *jsonData = [jsonString dataUsingEncoding:NSUnicodeStringEncoding];
        
        // JSON を NSArray に変換する
        NSError *error2 = nil;
        id jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error2];
        
        if (!error2 && [jsonArray count] > 0) {
            
            int count = 0;  // 歌番号になる
            
            // 一首ずつ取り出す
            for (NSDictionary *dic in jsonArray) {
                
                // 歌の区切りごとに配列に格納する
                NSMutableArray *oneTankaArr = [NSMutableArray array];
                for (NSString *str in dic) {
                    [oneTankaArr addObject:str];
                }
                
                // 歌番号をつけて上の句配列/下の句配列を作成
                // 上の句
                NSMutableArray *firstPart = [NSMutableArray array];
                [firstPart addObject:oneTankaArr[0]];
                [firstPart addObject:oneTankaArr[1]];
                [firstPart addObject:oneTankaArr[2]];
                NSMutableDictionary *firstPartDict = [NSMutableDictionary dictionary];
                [firstPartDict setObject:@(count) forKey:@"no"];
                [firstPartDict setObject:firstPart forKey:@"sentence"];
                [self.firstPartsArray addObject:firstPartDict];

                // 下の句
                NSMutableArray *lastPart = [NSMutableArray array];
                [lastPart addObject:oneTankaArr[3]];
                [lastPart addObject:oneTankaArr[4]];
                NSMutableDictionary *lastPartDict = [NSMutableDictionary dictionary];
                [lastPartDict setObject:@(count) forKey:@"no"];
                [lastPartDict setObject:lastPart forKey:@"sentence"];
                [self.lastPartsArray addObject:lastPartDict];

                count++;
            }
            
            if ([self.firstPartsArray count] > 0 && [self.lastPartsArray count] > 0) {
                result = YES;
            } else {
                result = NO;
            }
        }
    }
    
    return result;
    
}


@end
