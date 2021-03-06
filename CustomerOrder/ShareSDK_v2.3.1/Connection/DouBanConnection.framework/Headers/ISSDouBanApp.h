//
//  Created by ShareSDK.cn on 13-1-14.
//  官网地址:http://www.ShareSDK.cn
//  技术支持邮箱:support@sharesdk.cn
//  官方微信:ShareSDK   （如果发布新版本的话，我们将会第一时间通过微信将版本更新内容推送给您。如果使用过程中有任何问题，也可以通过微信与我们取得联系，我们将会在24小时内给予回复）
//  商务QQ:4006852216
//  Copyright (c) 2013年 ShareSDK.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDKCoreService/ShareSDKCoreService.h>
#import "SSDouBanUser.h"
#import "ISSDouBanAuthSession.h"
#import "SSDouBanErrorInfo.h"
#import "SSDouBanStatus.h"

/**
 *	@brief	新浪微博请求方式
 */
typedef enum
{
	SSDouBanRequestMethodGet = 0, /**< GET方式 */
	SSDouBanRequestMethodPost = 1, /**< POST方式 */
	SSDouBanRequestMethodMultipartPost = 2, /**< Multipart POST方式，用于上传文件的api接口 */
    SSDouBanRequestMethodDelete = 3 /**< DELETE方式 */
}
SSDouBanRequestMethod;

@protocol ISSDouBanApp <ISSCOpenApp>

/**
 *	@brief	获取授权帐号
 *
 *	@return	授权帐号
 */
- (id<ISSCAccount>)account;

/**
 *	@brief	获取应用Key
 *
 *	@return	应用Key
 */
- (NSString *)appKey;

/**
 *	@brief	获取应用密钥
 *
 *	@return	应用密钥
 */
- (NSString *)appSecret;

/**
 *	@brief	获取应用回调地址
 *
 *	@return	应用回调地址
 */
- (NSString *)redirectUri;

/**
 *	@brief	获取是否转换链接标识
 *
 *	@return	YES 表示转换链接，NO 表示不转换链接
 */
- (BOOL)convertUrlEnabled;

/**
 *	@brief	设置是否转换链接标识
 *
 *	@param 	enabled 	YES 表示转换链接，NO 表示不转换链接
 */
- (void)setConvertUrlEnabled:(BOOL)enabled;

/**
 *	@brief	授权应用
 *
 *	@return	授权会话
 */
- (id<ISSDouBanAuthSession>)authorize;

/**
 *	@brief	注册用户信息
 *
 *	@param 	user 	用户信息
 *
 *	@return	YES 表示注册成功， NO 表示注册失败
 */
- (BOOL)registerUser:(SSDouBanUser *)user;

/**
 *	@brief	注销用户信息
 *
 *	@param 	user 	用户信息
 *
 *	@return	YES 表示注销成功， NO 表示注销失败
 */
- (BOOL)unregisterUser:(SSDouBanUser *)user;

/**
 *	@brief	获取注册用户信息
 *
 *	@param 	uid 	用户ID
 *
 *	@return	返回用户信息，nil表示尚未注册
 */
- (SSDouBanUser *)getUser:(NSString *)uid;

/**
 *	@brief	获取默认注册用户
 *
 *	@return	默认注册用户
 */
- (SSDouBanUser *)defaultUser;

/**
 *	@brief	设置默认注册用户
 *
 *	@param 	defaultUser 	默认注册用户
 */
- (void)setDefaultUser:(SSDouBanUser *)defaultUser;

/**
 *	@brief	检测用户是否已授权
 *
 *	@param 	error 	错误信息
 *
 *	@return	YES 表示没有授权，NO 表示已授权
 */
- (BOOL)checkUnauthWithError:(SSDouBanErrorInfo *)error;

/**
 *	@brief	设置凭证
 *
 *	@param 	credential 	授权凭证信息
 */
- (void)setCredential:(SSDouBanCredential *)credential;

/**
 *	@brief	调用开放平台API
 *
 *	@param 	path 	路径
 *	@param 	params 	请求参数
 *  @param  user    授权用户,如果传入nil则表示默认的授权用户
 *  @param  result  返回回调
 *  @param  fault   失败回调
 */
- (void)api:(NSString *)path
     method:(SSDouBanRequestMethod)method
     params:(id<ISSCParameters>)params
       user:(SSDouBanUser *)user
     result:(void(^)(id responder))result
      fault:(void(^)(SSDouBanErrorInfo *error))fault;

/**
 *	@brief	获取当前授权用户信息
 *
 *  @param  result  返回回调
 */
- (void)showMe:(void(^)(BOOL result, SSDouBanUser *user, SSDouBanErrorInfo *error))result;

/**
 *	@brief	发布广播
 *
 *	@param 	text 	广播文本内容
 *	@param 	image 	我说的图
 *	@param 	recTitle 	推荐网址的标题
 *	@param 	recUrl 	推荐网址的href
 *	@param 	recDesc 	推荐网址的描述
 *	@param 	recImage 	推荐网址的附图url
 *  @param  result  返回回调
 */
- (void)addStatusWithText:(NSString *)text
                    image:(id<ISSCAttachment>)image
                 recTitle:(NSString *)recTitle
                   recUrl:(NSString *)recUrl
                  recDesc:(NSString *)recDesc
                 recImage:(NSString *)recImage
                   result:(void(^)(SSCShareSessionState state, SSDouBanStatus *status, SSDouBanErrorInfo *error))result;

/**
 *	@brief	获取单条广播
 *
 *	@param 	statusId 	广播id
 */
- (void)getStatusWithId:(NSString *)statusId
                 result:(void(^)(BOOL result, SSDouBanStatus *status, SSDouBanErrorInfo *error))result;



@end
