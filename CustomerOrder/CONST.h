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


//会员注册
//
#define MEMBER_REGISTER_API @"http://www.coolelife.com/json/member_json.php"
#define MEMBER_REGISTER_ARGUMENT @"op=register&username=%@&userpwd=%@&repwd=%@&tel=%@&salt=%@"


//会员登录
//
#define MEMBER_LOGIN_API @"http://www.coolelife.com/json/member_json.php"
#define MEMBER_LOGIN_ARGUMENT @"op=login&username=%@&userpwd=%@"


//发表评论
//
#define PUBLISH_COMMENT_API @"http://www.coolelife.com/json/comment_json.php"
#define PUBLISH_COMMENT_ARGUMENT @"op=addComment&online_key=%@&shop_id=%@&grade=%f&avmoney=%f&content=%@"


//获取评论列表
//
#define GET_COMMENT_LIST_API @"http://www.coolelife.com/json/comment_json.php"
#define GET_COMMENT_LIST_ARGUMENT @"op=getCommentList&curpage=%d&shop_id=%d"


#endif
