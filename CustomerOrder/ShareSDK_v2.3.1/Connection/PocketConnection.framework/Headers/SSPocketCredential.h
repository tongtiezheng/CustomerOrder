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
#import <ShareSDKCoreService/SSCDataObject.h>

///#begin   zh-cn
/**
 *	@brief	授权凭证
 */
///#end
///#begin   en
/**
 *	@brief	The user's authorization certificate
 */
///#end
@interface SSPocketCredential : SSCDataObject

///#begin   zh-cn
/**
 *	@brief	Access Token
 */
///#end
///#begin   en
/**
 *	@brief	Access Token
 */
///#end
@property (nonatomic,readonly) NSString *accessToken;

///#begin   zh-cn
/**
 *	@brief	用户名称
 */
///#end
///#begin   en
/**
 *	@brief	user name
 */
///#end
@property (nonatomic,readonly) NSString *userName;

///#begin   zh-cn
/**
 *	@brief	判断授权数据是否有效
 */
///#end
///#begin   en
/**
 *	@brief	To determine whether the authorization data
 */
///#end
@property (nonatomic,readonly) BOOL available;

/**
 *	@brief	初始化授权信息
 *
 *	@param 	sourceData 	源授权数据
 *
 *	@return	授权信息
 */
- (id)initWithData:(NSDictionary *)sourceData;

/**
 *	@brief	初始化授权凭证
 *
 *	@param 	credentialData 	授权凭证数据
 *
 *	@return	授权凭证
 */
- (id)initWithCredentialData:(NSDictionary *)credentialData;


@end
