//
//  RegisterViewController.h
//  CustomerOrder
//
//  Created by ios on 13-6-8.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *_username;
    UITextField *_userpwd;
    UITextField *_repwd;
    UITextField *_tel;
    UITextField *_salt;
}

@property(retain,nonatomic)UITextField *username;
@property(retain,nonatomic)UITextField *userpwd;
@property(retain,nonatomic)UITextField *repwd;
@property(retain,nonatomic)UITextField *tel;
@property(retain,nonatomic)UITextField *salt;


@end
