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
        NSLog(@"%@",[jsonArray class]);
        
        if (!error2) {
            
            NSLog(@"jsonArray count %lu, \n%@", (unsigned long)[jsonArray count],[jsonArray description]);
            
            // JSON のオブジェクトは NSDictionary に変換されている
            
            // 一首ずつ取り出す
            for (NSDictionary *dic in jsonArray) {
                NSLog(@"dic\n%@", [dic description]);
                
                // 歌の区切りごとに配列に格納する
                NSMutableArray *oneTankaArr = [NSMutableArray array];
                
                for (NSString *str in dic) {
                    NSLog(@"str\n%@", str);
                    [oneTankaArr addObject:str];
                }
                
                [self.allTankaArray addObject:oneTankaArr];
                
            }
            
            NSLog(@"allTankaArray\n%@", [self.allTankaArray description]);
            NSLog(@"%@", self.allTankaArray[0][1]);

            
            self.firstPartsArray = [self prepareFirstParts];
            self.lastPartsArray = [self prepareLastParts];
            
            result = YES;
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
                     
                     
                     
    return returnArray;
}

- (NSMutableArray *) prepareLastParts
{
    NSMutableArray *returnArray = [NSMutableArray array];
    
    
    
    return returnArray;
}




@end
