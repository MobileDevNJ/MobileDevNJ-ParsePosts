//
//  NewPostViewController.h
//  ParseTest
//
//  Created by David Rodriguez on 4/11/12.
//  Copyright (c) 2012 Forge42. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPostViewController : UIViewController <UITextViewDelegate>
@property (retain, nonatomic) IBOutlet UITextView *postTextView;

@end
