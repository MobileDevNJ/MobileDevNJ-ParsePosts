//
//  SecondViewController.m
//  ParseTest
//
//  Created by David Rodriguez on 4/11/12.
//  Copyright (c) 2012 Forge42. All rights reserved.
//

#import "RegistrationViewController.h"
#import <Parse/Parse.h>

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
    
    if( [PFUser currentUser] != nil ) { // check if user is logged in here
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
    
    viewTitle.text = [NSString stringWithFormat:@"Welcome %@!", [[PFUser currentUser] username]]; //Parse: set the user's username here
    
}

- (void)logoutSuccessful {
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    
    for( UIView *item in itemsToHideOnLogin ) {
        [item setHidden:NO];
    }
    
    viewTitle.text = [NSString stringWithFormat:@"Please Login or Sign Up Below"];
}

- (IBAction)login:(id)sender {
    
    if( [PFUser currentUser] != nil ) { // check if user is logged in here

        [PFUser logOut]; // Logout the user
        
        [self logoutSuccessful];
    } else {
    
        // make sure username and password aren't empty
        if( [[usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
            [self resignKeyboard];
            return;
        }
        if( [[passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
            [self resignKeyboard];
            return;
        }
        
        [self resignKeyboard];
        [loginButton setEnabled:NO];
        [signUpButton setEnabled:NO];
        
        //Parse: login code goes here
        
        [PFUser logInWithUsernameInBackground:usernameField.text password:passwordField.text block:^(PFUser *user, NSError *error) {
            if( error == nil && user != nil ) {
                [loginButton setEnabled:YES];
                [signUpButton setEnabled:YES];
                
                [self loginSuccessful];
            } else {
                UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", [error description]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
                
                [loginButton setEnabled:YES];
                [signUpButton setEnabled:YES];
                
                [alert show];
            }
        }];
    }
}

- (IBAction)signUp:(id)sender {
    
    // make sure username and password aren't empty
    if( [[usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
        [self resignKeyboard];
        return;
    }
    if( [[passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
        [self resignKeyboard];
        return;
    }
    
    [self resignKeyboard];
    [loginButton setEnabled:NO];
    [signUpButton setEnabled:NO];
    
    //Parse: sign up code goes here
    PFUser *user = [PFUser user];
    user.username = usernameField.text;
    user.password = passwordField.text;
    
    // sign up the user
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if( succeeded ) {
            [loginButton setEnabled:YES];
            [signUpButton setEnabled:YES];

            [self loginSuccessful];
        } else {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%@", [error description]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] autorelease];
            
            [loginButton setEnabled:YES];
            [signUpButton setEnabled:YES];
            
            [alert show];
        }
    }];
    
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
