//
//  DataBase.h
//  CustomerOrder
//
//  Created by ios on 13-6-14.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMDatabase;
@class StoreList;

@interface DataBase : NSObject
{
    FMDatabase *fmdb;
}

//获得指定名字的文件在沙盒下的路径
+(NSString*)pathForName:(NSString *)fileName;
+(DataBase*)defaultDataBase;
-(id)init;

//插入单条纪录
-(void)insertItem:(StoreList *)item;

//删除一条纪录
-(void)deleteItem:(StoreList *)item;

//查询记录
-(NSMutableArray *)selectStoresItemsFromDataBase;

//创建新表
-(void)createTable;

-(void)openDataBase;

//判断数据库中是否存在记录
-(BOOL)isExistItem:(StoreList *)item;



@end
