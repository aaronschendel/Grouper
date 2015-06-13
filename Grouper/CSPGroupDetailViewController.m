//
//  GroupDetailViewController.m
//  ClassSplit
//
//  Created by Aaron Schendel on 3/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPGroupDetailViewController.h"
#import "CSPGroupMemberTableViewCell.h"
#import <MessageUI/MessageUI.h>
#import "CSPStudent.h"

@interface CSPGroupDetailViewController ()

@end

@implementation CSPGroupDetailViewController
@synthesize group;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    
    UINavigationItem *nav = [self navigationItem];
    NSString *title = [[NSString alloc] initWithFormat:@"%@", self.group.groupName];
    [nav setTitle:title];
    
    //UIBarButtonItem *composeEmailButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector((composeEmail:))];
    //[self.navigationItem setRightBarButtonItem:composeEmailButton];
    
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // If this page is presented from CreateGroupsViewController
    if (self.isNewGroup) {
        UIBarButtonItem *takeMeHomeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(takeMeHome:)];
        [self.navigationItem setLeftBarButtonItem:takeMeHomeButton];
    }
    
    [self.navigationController setToolbarHidden:NO];
}

- (NSArray *)createToListAndEmailBodyFromGroup {
    
    BOOL shouldAutoFillTo = nil;
    
    // Determine if "To:" toggle was selected
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"shouldAutoFillTo"]) {
        shouldAutoFillTo = [[NSUserDefaults standardUserDefaults] boolForKey:@"shouldAutoFillTo"];
    } else {
        shouldAutoFillTo = false;
    }
    
    NSMutableArray *toList = [[NSMutableArray alloc] init];
    NSMutableString *emailBody = [[NSMutableString alloc] initWithFormat:@" "];
    
    // Loop through all the subgroups
    for (int i = 0; i < self.group.subGroups.count; i++) {
        NSString *groupX = [[NSString alloc] initWithFormat:@"Group %d \n", i + 1];
        [emailBody appendString: groupX];
        [emailBody appendString:@"\n"];
        
        // Loop through each student and add their name/email address to the appropriate string/list
        NSMutableArray *currSubGroup = [self.group.subGroups objectAtIndex:i];
        for (int j = 0; j < [currSubGroup count]; j++) {
            CSPStudent *currStudent = [currSubGroup objectAtIndex:j];
            NSString *fullName = [[NSString alloc] initWithFormat:@"%@ %@", currStudent.firstName, currStudent.lastName];
            [emailBody appendString:fullName];
            [emailBody appendString:@"\n"];
            
            if (shouldAutoFillTo && currStudent.emailAddress.length > 0) {
                [toList addObject:currStudent.emailAddress];
            }
        }
        [emailBody appendFormat:@"---------------------\n"];
    }
    
    NSArray *results = @[toList, emailBody];
    
    return results;
}

- (void)composeEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        NSString *emailSubject = [[NSString alloc] initWithFormat:@"%@", self.group.groupName];
        [mailer setSubject:emailSubject];
        
        // toList = 0; emailBody = 1
        NSArray *toListAndEmailBody = [self createToListAndEmailBodyFromGroup];
        
        NSString *messageBody = [toListAndEmailBody objectAtIndex:1];
        [mailer setMessageBody:messageBody isHTML:NO];
       
        NSArray *toList = [toListAndEmailBody objectAtIndex:0];
        if ([toList count] > 0) {
            [mailer setToRecipients:toList];
        }
        
        
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

    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeEmail:)];
    UIBarButtonItem *emptyItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *toolbarButtons = [NSArray arrayWithObjects:emptyItem, item1, nil];
    [self setToolbarItems:toolbarButtons];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.group moveItemAtIndex:sourceIndexPath toIndex:destinationIndexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // The number of sections is the number of sub groups
    return self.group.numberOfGroups;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // The number of rows in a given section is equal to the number of names in a given subgroup
    return [[self.group.subGroups objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Each section heading will be "Group [section number]"
    NSString *title = [[NSString alloc] initWithFormat:@"%@ %ld", @"Group", section + 1];
    return title;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CSPStudent *person = [[group.subGroups objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
     
     NSString *uniqueIdentifier = @"GroupMemberCell";
     CSPGroupMemberTableViewCell *cell = nil;
     cell = (CSPGroupMemberTableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
     if (!cell) {
         NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CSPGroupMemberTableViewCell" owner:nil options:nil];
         for (id currentObject in topLevelObjects) {
             cell = (CSPGroupMemberTableViewCell *)currentObject;
             break;
         }
     }
    
    NSString *fullName = [[NSString alloc] initWithFormat:@"%@ %@", person.firstName, person.lastName];
    [cell.groupMemberLabel setText:fullName];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
     
     
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

#pragma mark - Other things

- (void)takeMeHome:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/



@end
