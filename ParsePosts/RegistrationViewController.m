//
//  SecondViewController.m
//  ParseTest
//
//  Created by David Rodriguez on 4/11/12.
//  Copyright (c) 2012 Forge42. All rights reserved.
//

#import "RegistrationViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize usernameField;
@synthesize passwordField;
@synthesize registrationView;
@synthesize signUpButton;
@synthesize loginButton;
@synthesize viewTitle;
@synthesize itemsToHideOnLogin;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if( false ) { // check if user is logged in here
        [self loginSuccessful];
    }
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setRegistrationView:nil];
    [self setSignUpButton:nil];
    [self setLoginButton:nil];
    [self setViewTitle:nil];
    [self setItemsToHideOnLogin:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)dealloc {
    [usernameField release];
    [passwordField release];
    [registrationView release];
    [signUpButton release];
    [loginButton release];
    [viewTitle release];
    [itemsToHideOnLogin release];
    [super dealloc];
}

#pragma mark -
#pragma mark Login/Logout Actions

- (void)loginSuccessful {
    [loginButton setTitle:@"Logout" forState:UIControlStateNormal];
    
    for( UIView *item in itemsToHideOnLogin ) {
        [item setHidden:YES];
    }
    
    viewTitle.text = [NSString stringWithFormat:@"Welcome %@!", @"Username"]; //Parse: set the user's username here
    
}

- (void)logoutSuccessful {
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    
    for( UIView *item in itemsToHideOnLogin ) {
        [item setHidden:NO];
    }
    
    viewTitle.text = [NSString stringWithFormat:@"Please Login or Sign Up Below"];
}

- (IBAction)login:(id)sender {

    if( false ) { // check if user is logged in here
        [self logoutSuccessful];
    } else {
    
        //Parse: login code goes here
    
        [self resignKeyboard];
        [self loginSuccessful];
    }
}

- (IBAction)signUp:(id)sender {
    
    //Parse: sign up code goes here
    
    [self resignKeyboard];
    [self loginSuccessful];
}

#pragma mark -
#pragma mark Keyboard Actions

- (IBAction)resignKeyboard {
    [usernameField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (IBAction)endedEditing:(id)sender {
    [self resignFirstResponder];
}

@end
