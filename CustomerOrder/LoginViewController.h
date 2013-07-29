//
//  LoginViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-13.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{    
    UITableView *_customTV;
    
    NSArray * _loginA;
    NSArray *_shareA;
    NSArray *_sectionA;
    NSArray *_shareImgA;
    
    UITextField *_username;
    UITextField *_pwd;

}

@property(readonly, nonatomic)UITableView *customTV;

@property(retain,nonatomic)NSArray *loginA;
@property(retain,nonatomic)NSArray *shareA;
@property(retain,nonatomic)NSArray *sectionA;
@property(retain,nonatomic)NSArray *shareImgA;;

@property(retain,nonatomic)UITextField *username;
@property(retain,nonatomic)UITextField *pwd;



@end
