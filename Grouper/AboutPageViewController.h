//
//  AboutPageViewController.h
//  Grouper
//
//  Created by Aaron Schendel on 5/20/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutPageViewController : UIViewController<MFMailComposeViewControllerDelegate>

- (IBAction)done:(UIButton *)sender;
- (IBAction)autoFillSwitcher:(id)sender;
- (IBAction)contactMeButton:(id)sender;

@end
