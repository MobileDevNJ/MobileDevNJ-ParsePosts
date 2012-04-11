//
//  SecondViewController.h
//  ParseTest
//
//  Created by David Rodriguez on 4/11/12.
//  Copyright (c) 2012 Forge42. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController

@property (retain, nonatomic) IBOutlet UITextField *usernameField;
@property (retain, nonatomic) IBOutlet UITextField *passwordField;
@property (retain, nonatomic) IBOutlet UIView *registrationView;
@property (retain, nonatomic) IBOutlet UIButton *signUpButton;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UILabel *viewTitle;

@property (retain, nonatomic) IBOutletCollection(UIView) NSArray *itemsToHideOnLogin;

@end
