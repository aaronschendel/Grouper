//
//  GroupDetailViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 3/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "GroupMemberTableViewCell.h"
#import <MessageUI/MessageUI.h>

@interface GroupDetailViewController ()

@end

@implementation GroupDetailViewController
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
    
    UIBarButtonItem *composeEmailButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector((composeEmail:))];
    [self.navigationItem setRightBarButtonItem:composeEmailButton];
    
    // If this page is presented from CreateGroupsViewController
    if (self.isNewGroup) {
        UIBarButtonItem *takeMeHomeButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(takeMeHome:)];
        [self.navigationItem setLeftBarButtonItem:takeMeHomeButton];
        
    }
}

- (NSMutableString *)createEmailBodyFromGroup {
    NSMutableString *emailBody = [[NSMutableString alloc] initWithFormat:@" "];
    for (int i = 0; i < self.group.subGroups.count; i++) {
        NSString *groupX = [[NSString alloc] initWithFormat:@"Group %d \n", i + 1];
        [emailBody appendString: groupX];
        [emailBody appendString:@"-\n"];
        
        NSMutableArray *currSubGroup = [self.group.subGroups objectAtIndex:i];
        for (int j = 0; j < [currSubGroup count]; j++) {
            [emailBody appendString:[currSubGroup objectAtIndex:j]];
            [emailBody appendString:@"\n"];
        }
        [emailBody appendFormat:@"---------------------\n"];
    }
    return emailBody;
}

- (void)composeEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        
        NSString *emailSubject = [[NSString alloc] initWithFormat:@"%@", self.group.groupName];
        [mailer setSubject:emailSubject];
        
        
        NSMutableString *emailBody = [self createEmailBodyFromGroup];
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
    
    NSString *name = [[group.subGroups objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
     
     NSString *uniqueIdentifier = @"GroupMemberCell";
     GroupMemberTableViewCell *cell = nil;
     cell = (GroupMemberTableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
     if (!cell) {
         NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GroupMemberTableViewCell" owner:nil options:nil];
         for (id currentObject in topLevelObjects) {
             cell = (GroupMemberTableViewCell *)currentObject;
             break;
         }
     }
     
    [[cell groupMemberLabel] setText:name];
    
     
     
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
