//
//  AboutPageViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 5/20/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "AboutPageViewController.h"

@interface AboutPageViewController ()

@end

@implementation AboutPageViewController


- (void)composeEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        NSString *emailSubject = [[NSString alloc] initWithFormat:@"%@", @"ClassSplit Feedback"];
        [mailer setSubject:emailSubject];
        
        [mailer setToRecipients:@[@"ClassSplit@gmail.com"]];
        
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentViewController:mailer animated:YES completion:nil];
    } else {
        NSLog(@"Ay bro, you can't send emails!");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)done:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)autoFillSwitcher:(id)sender {
}

- (IBAction)contactMeButton:(id)sender {
    [self composeEmail:nil];
    
}


@end
