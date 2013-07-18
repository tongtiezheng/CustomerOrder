//
//  DataBase.m
//  CustomerOrder
//
//  Created by ios on 13-6-14.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "DataBase.h"
#import "FMDatabase.h"
#import "StoreList.h"

//全局的静态变量，保证只有一个数据库实例
static DataBase *sg_database = nil;

@implementation DataBase

+(DataBase*)defaultDataBase
{
    if(!sg_database)
    {
        sg_database = [[DataBase alloc]init];
    }
    return sg_database;
}

//获得沙盒路径
+(NSString*)pathForName:(NSString *)fileName
{
    NSString *home = NSHomeDirectory();
    if(fileName && fileName.length !=0)
    {
        home = [home stringByAppendingFormat:@"/Documents/%@",fileName];
    }
    return home;
}


-(void)createTable
{
    NSString *newTableSql = @"CREATE TABLE IF NOT EXISTS STORELIST (storeid integer Primary Key Autoincrement,storeName TEXT,storeGrade TEXT DEFAULT NULL,avmoney TEXT DEFAULT NULL,pic TEXT DEFAULT NULL,description TEXT DEFAULT NULL,address TEXT DEFAULT NULL,tel TEXT DEFAULT NULL,lat TEXT DEFAULT NULL,lng TEXT DEFAULT NULL)";
    
    //执行语句（删除，修改，插入)
    if([fmdb executeUpdate:newTableSql])
    {
        NSLog(@"创建成功");
    }
    else
    {
        NSLog(@"创建失败");
    }
}

-(void)openDataBase
{
    NSString *path = [DataBase pathForName:@"stores.sqlite"];
    fmdb = [[FMDatabase databaseWithPath:path]retain];
    if([fmdb open])
    {
        NSLog(@"打开成功");
        [self createTable];
    }
    else
    {
        NSLog(@"打开失败:%@",[fmdb lastError]);
    }
}

//如果初始化成功就打开数据库
-(id)init
{
    if(self = [super init])
    {
        [self openDataBase]; 
    }
    return self;
}

//判断数据库中是否存在记录
-(BOOL)isExistItem:(StoreList *)item
{
    NSString *sql = [NSString stringWithFormat:@"SELECT storeName FROM STORELIST WHERE storeName=?"];
    FMResultSet *rs = [fmdb executeQuery:sql,item.name];
    while ([rs next])
    {
        return YES;
    }
    return NO;
}

//插入单条纪录
-(void)insertItem:(StoreList *)item
{
    if([self isExistItem:item])
    {
        NSLog(@"记录已经存在:%@",item.name);
        return;
    }
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO STORELIST(storeName,storeGrade,avmoney,pic,description,address,tel,lat,lng) VALUES (?,?,?,?,?,?,?,?,?)"];
    if([fmdb executeUpdate:sql,item.name,item.grade,item.avmoney,
                                            item.pic,item.description,item.address,item.tel,item.lat,item.lng])
    {
        NSLog(@"插入记录成功");
    }
    else
    {
        NSLog(@"插入记录失败:%@",[fmdb lastError]);
    }
}

//删除一条纪录
-(void)deleteItem:(StoreList *)item
{
    if(![self isExistItem:item])
    {
        NSLog(@"记录不存在");
        return;
    }
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM STORELIST WHERE storeName=?"];
    if([fmdb executeUpdate:sql,item.name])
    {
        NSLog(@"删除纪录成功");
    }
    else
    {
        NSLog(@"删除记录失败:%@",[fmdb lastError]);
    }
}
//查询记录
-(NSMutableArray *)selectStoresItemsFromDataBase
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM STORELIST"];
    NSMutableArray *array = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
    FMResultSet *rs = [fmdb executeQuery:sql];
    while ([rs next])
    {
        StoreList *storeInfo = [[[StoreList alloc]init]autorelease];
        
        storeInfo.name = [rs stringForColumn:@"storeName"];
        storeInfo.grade = [rs stringForColumn:@"storeGrade"];
        storeInfo.avmoney = [rs stringForColumn:@"avmoney"];
        storeInfo.pic = [rs stringForColumn:@"pic"];
        storeInfo.description = [rs stringForColumn:@"description"];
        storeInfo.address = [rs stringForColumn:@"address"];
        storeInfo.tel = [rs stringForColumn:@"tel"];
        storeInfo.lat = [rs stringForColumn:@"lat"];
        storeInfo.lng = [rs stringForColumn:@"lng"];
        
        [array addObject:storeInfo];
    }
    
    return array;
}


@end
