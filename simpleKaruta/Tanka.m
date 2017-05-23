//
//  Tanka.m
//  simpleKaruta
//  歌データを持つクラス

//  Created by ahausagi on 2017/05/19.
//  Copyright © 2017年 ahausagi. All rights reserved.
//

#import "Tanka.h"

@interface Tanka ()

@property (nonatomic) NSMutableArray *allTankaArray;    // 全首格納した配列

@end


@implementation Tanka

/**
 *  歌情報をJSON から取得し配列に格納する
 *  @return 歌情報取得に成功したかどうか。失敗していたらゲーム実行できないのでエラーを出してください
 **/
- (BOOL) prepareAllTanka
{
    BOOL result = NO;
    self.allTankaArray = [NSMutableArray array];
    
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
            
            // 一首ずつ取り出す
            for (NSDictionary *dic in jsonArray) {
                
                // 歌の区切りごとに配列に格納する
                NSMutableArray *oneTankaArr = [NSMutableArray array];
                for (NSString *str in dic) {
                    [oneTankaArr addObject:str];
                }
                
                [self.allTankaArray addObject:oneTankaArr];
                
            }
            
            self.firstPartsArray = [self prepareFirstParts];
            self.lastPartsArray = [self prepareLastParts];
            if ([self.firstPartsArray count] > 0 && [self.lastPartsArray count] > 0) {
                result = YES;
            } else {
                result = NO;
            }
        }
    }
    
    return result;
    
}

/**
 *  上の句のみの配列をつくる
 *  @return 上の句配列を返す
 **/
- (NSMutableArray *) prepareFirstParts
{
    NSMutableArray *returnArray = [NSMutableArray array];
    
    // [0][0]あきのたの[0][1]かりほのいほの[0][2]とまをあらみ
    // [1][0]はるすぎて[1][1]なつきにけらし[1][2]しろたへの
    // ...
    
    // 一首ずつ取り出す
    for (NSArray *arr in self.allTankaArray) {

        // 上の句（0,1,2番目）のみ取り出す
        NSMutableArray *firstParts = [NSMutableArray array];
        [firstParts addObject:arr[0]];
        [firstParts addObject:arr[1]];
        [firstParts addObject:arr[2]];
        
        [returnArray addObject:firstParts];

    }

    return returnArray;
}

/**
 *  下の句のみの配列をつくる
 *  @return 下の句配列を返す
 **/
- (NSMutableArray *) prepareLastParts
{
    NSMutableArray *returnArray = [NSMutableArray array];
    
    // [0][0]わがころもでは[0][1]つゆにぬれつつ
    // [1][0]ころもほすてふ[1][1]あまのかぐやま
    // ...
    
    // 一首ずつ取り出す
    for (NSArray *arr in self.allTankaArray) {
        
        // 下の句（3,4番目）のみ取り出す
        NSMutableArray *lastParts = [NSMutableArray array];
        [lastParts addObject:arr[3]];
        [lastParts addObject:arr[4]];
        
        [returnArray addObject:lastParts];
        
    }
    
    return returnArray;
}




@end
