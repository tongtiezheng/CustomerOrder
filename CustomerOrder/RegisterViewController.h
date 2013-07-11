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
    UITextField *userField;
    UITextField *pwdField;
    UITextField *ensurePwdField;
    UITextField *telField;
    UITextField *infoEnsure;

}

@end
