//
//  CONST.h
//  CustomerOrder
//
//  Created by ios on 13-6-25.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#ifndef CustomerOrder_CONST_h
#define CustomerOrder_CONST_h

#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define TABBAR_HEIGHT  self.tabBarController.tabBar.bounds.size.height

//******** API ********//

//城市列表
//
#define CITY_LIST_API @"http://www.coolelife.com/json/province_json.php"
#define CITY_LIST_ARGUMENT @"op=getProvince"

//商铺列表
//
#define STORE_LIST_API @"http://www.coolelife.com/json/shop_json.php"
#define STORE_LIST_ARGUMENT @"op=getNewsList&curpage=%d&pro_id=%d"

#endif
