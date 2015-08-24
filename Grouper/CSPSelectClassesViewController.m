//
//  SelectListsViewController.m
//  ClassSplit
//
//  Created by Aaron on 4/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPSelectClassesViewController.h"
#import "CSPClass.h"
#import "CSPClassStore.h"
#import "CSPGroupMemberTableViewCell.h"
#import "CSPCreateGroupsViewController.h"
#import <ChameleonFramework/Chameleon.h>

@interface CSPSelectClassesViewController ()

@end

@implementation CSPSelectClassesViewController
@synthesize selectedPersonLists;


- (id)init {
    self = [super initWithNibName:@"CSPSelectClassesViewController" bundle:nil];
    if (self) {
        [[[self navigationController] navigationBar] setHidden:NO];
        
        if (!self.selectedPersonLists) {
            self.selectedPersonLists = [[NSMutableArray alloc] init];
        }
        //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

    
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"Pick Class"];
    [self.tableView reloadData];
    
    [self.navigationController setToolbarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [super viewDidLoad];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createGroupsFromSelectedPersonLists:)];
    UIBarButtonItem *emptyItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *toolbarButtons = [NSArray arrayWithObjects:emptyItem, item1, nil];
    [self setToolbarItems:toolbarButtons];
    
    // Setup for empty data set Pod
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createGroupsFromSelectedPersonLists:(id)sender {
    CSPCreateGroupsViewController *createGroupsVC = [[CSPCreateGroupsViewController alloc] init];
    [createGroupsVC setSelectedClasses:self.selectedPersonLists];
    if (self.selectedPersonLists.count > 0) {
        [[self navigationController] pushViewController:createGroupsVC animated:YES];
    }
}

#pragma mark - DZNEmptyDataSet data source

- (void)dealloc
{
    self.tableView.emptyDataSetSource = nil;
    self.tableView.emptyDataSetDelegate = nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    // The attributed string for the title of the empty dataset
    
    NSString *text = @"You Need Lists First!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    // The attributed string for the description of the empty dataset
    NSString *text = @"Create some lists of people in the Create/Edit Lists view, then split them into groups!";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    //The attributed string to be used for the specified button state
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0]};
    
    return [[NSAttributedString alloc] initWithString:@"" attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    // The background color for the empty dataset
    return [UIColor whiteColor];
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
    // Modify the horizontal and/or vertical alignments
    return CGPointMake(0, -self.tableView.tableHeaderView.frame.size.height/2);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[CSPClassStore sharedPersonListStore] allPersonLists] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSPClass *nameList = [[[CSPClassStore sharedPersonListStore] allPersonLists] objectAtIndex:[indexPath row]];
    
    NSString *uniqueIdentifier = @"GroupCell";
    CSPGroupMemberTableViewCell *cell = nil;
    cell = (CSPGroupMemberTableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CSPGroupMemberTableViewCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            cell = (CSPGroupMemberTableViewCell *)currentObject;
            break;
        }
    }
    
    [[cell groupMemberLabel] setText:nameList.listName];
    
    return cell;

}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    // If a row has a checkmark, do not allow any other rows to be selected
    if ([self.selectedPersonLists count] == 1 && cell.accessoryType != UITableViewCellAccessoryCheckmark) {
        return nil;
    }
    
    // By default, allow row to be selected
    return indexPath;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedPersonLists removeObjectIdenticalTo:[[[CSPClassStore sharedPersonListStore] allPersonLists] objectAtIndex:[indexPath row]]];
        
    } else if (cell.accessoryType == UITableViewCellAccessoryNone) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.selectedPersonLists addObject:[[[CSPClassStore sharedPersonListStore] allPersonLists] objectAtIndex:[indexPath row]]];

    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
