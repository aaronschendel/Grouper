//
//  CreateEditViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 3/5/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CreateEditViewController.h"
#import "Group.h"
#import "PersonList.h"
#import "PersonListStore.h"
#import "NameListTableViewCell.h"
#import "CreateEditDetailViewController.h"


@interface CreateEditViewController ()

@end

@implementation CreateEditViewController
@synthesize bbi, cancelButton;

#pragma mark - Aaron's Pieces

- (id)init
{
    self = [super initWithNibName:@"CreateEditViewController" bundle:nil];
    if (self) {
        [[[self navigationController] navigationBar] setHidden:NO];
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewNameList:)];
    UIBarButtonItem *emptyItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *toolbarButtons = [NSArray arrayWithObjects:emptyItem, item1, nil];
    [self setToolbarItems:toolbarButtons];
    
    // Setup for DZNEmptyDataSet
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"Lists"];
    [self.tableView reloadData];
    
    self.navigationController.toolbarHidden = NO;
    
    // Done to fix bug in DZNEmptyDataSet
    if (self.tableView.contentOffset.y < 0 && self.tableView.emptyDataSetVisible) {
        self.tableView.contentOffset = CGPointZero;
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertTextFieldDidChange:(NSNotification *)notification
// Used with the UIAlertController in addNewNameList to determine if addButton should be enabled
{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController)
    {
        UITextField *login = alertController.textFields.firstObject;
        UIAlertAction *okAction = alertController.actions.lastObject;
        okAction.enabled = login.text.length > 0;
    }
}


- (void)addNewNameList:(id)sender
{
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Add List"
                                                                   message:@"Enter List Name"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"List Name";
         textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
         [[NSNotificationCenter defaultCenter] addObserver:self
                                                  selector:@selector(alertTextFieldDidChange:)
                                                      name:UITextFieldTextDidChangeNotification
                                                    object:textField];
     }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                           handler:^(UIAlertAction * action) {}];
    
    UIAlertAction* addAction = [UIAlertAction actionWithTitle:@"Add" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action) {
                                                               
                                                               [[NSNotificationCenter defaultCenter] removeObserver:self
                                                                                                               name:UITextFieldTextDidChangeNotification
                                                                                                             object:nil];
                                                               PersonList *personList = [[PersonListStore sharedPersonListStore] createPersonList];
                                                               
                                                               [personList setListName:[[alert.textFields objectAtIndex:0] text]];
                                                               [self.tableView reloadData];
                                                               NSLog(@"NameLists:  %@", [[PersonListStore sharedPersonListStore] allPersonLists]);
                                                           }];
    
    [alert addAction:cancelAction];
    [alert addAction:addAction];
    addAction.enabled = NO;
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}

#pragma mark - DZNEmptyDataSet data source

- (void)dealloc
{
    self.tableView.emptyDataSetSource = nil;
    self.tableView.emptyDataSetDelegate = nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    // The attributed string for the title of the empty dataset
    
    NSString *text = @"Looks Like You Need to Create Lists!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    // The attributed string for the description of the empty dataset
    NSString *text = @"Create a new list by tapping the plus";
    
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

//- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView {
//    // Modify the horizontal and/or vertical alignments
//    return CGPointMake(0, -self.tableView.tableHeaderView.frame.size.height/2);
//}

#pragma mark - DZNEmptyDataSet delegate implementation

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    self.tableView.reloadData;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Only one section for this list
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // The number of rows is the number of NameLists in sharedNameListStore
    return [[[PersonListStore sharedPersonListStore] allPersonLists] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonList *nameList = [[[PersonListStore sharedPersonListStore] allPersonLists] objectAtIndex:[indexPath row]];
    
    NSString *uniqueIdentifier = @"NameListCell";
    NameListTableViewCell *cell = nil;
    cell = (NameListTableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NameListTableViewCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            cell = (NameListTableViewCell *)currentObject;
            break;
        }
    }
    
    [[cell nameOfList] setText:nameList.listName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CreateEditDetailViewController *createEditDetailViewController = [[CreateEditDetailViewController alloc] init];
    PersonList *selectedPersonList = [[[PersonListStore sharedPersonListStore] allPersonLists] objectAtIndex:[indexPath row]];
    
    [createEditDetailViewController setPersonList:selectedPersonList];
    
    [[self navigationController] pushViewController:createEditDetailViewController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



// Disables swipe-to-delete
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Detemine if it's in editing mode
    if (self.tableView.editing)
    {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        PersonList *nameListToDelete = [[[PersonListStore sharedPersonListStore] allPersonLists] objectAtIndex:indexPath.row];
        [[PersonListStore sharedPersonListStore] removePersonList:nameListToDelete];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [self.tableView reloadData];
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[PersonListStore sharedPersonListStore] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
