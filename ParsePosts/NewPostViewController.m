//
//  NewPostViewController.m
//  ParseTest
//
//  Created by David Rodriguez on 4/11/12.
//  Copyright (c) 2012 Forge42. All rights reserved.
//

#import "NewPostViewController.h"
#import <Parse/Parse.h>

@interface NewPostViewController ()

@end

@implementation NewPostViewController
@synthesize postTextView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setPostTextView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [postTextView release];
    [super dealloc];
}

- (void)viewDidAppear:(BOOL)animated {
    
    if( [PFUser currentUser] == nil ) {
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"New Post" message:@"You need to be logged in to post." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alert show];

    }
}

#pragma mark -
#pragma mark Button Actions

- (IBAction)doneWithPost:(id)sender {
    
    //remove the keyboard
    [postTextView resignFirstResponder];
    
    // show an alert message if text field empty or it's the default text
    if( [postTextView.text isEqualToString:@"Enter your post here!"] || 
        [[postTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
        
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"New Post" message:@"Please type something in." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [alert show];
        
    } else {
        
        //Parse: save the new post here
        PFObject *post = [PFObject objectWithClassName:@"posts"];
        [post setObject:postTextView.text forKey:@"comment"];
        [post setObject:[PFUser currentUser] forKey:@"user"];
        [post save];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadParseTableData" object:nil];
        
        // dismiss the controller
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark -
#pragma mark UITextViewDelegate Methods

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if( [textView.text isEqualToString:@"Enter your post here!"] ) {
        textView.text = @"";
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    // if string is empty or just whitespace characters
    if( [[textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
        textView.text = @"Enter your post here!";
    }
}


@end
