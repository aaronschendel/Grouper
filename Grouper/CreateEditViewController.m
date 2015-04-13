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
#import "NameListStore.h"
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"Lists"];
    [self.tableView reloadData];
    
    self.navigationController.toolbarHidden = NO;
    
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
                                                               PersonList *nameList = [[NameListStore sharedNameListStore] createNameList];
                                                               
                                                               [nameList setListName:[[alert.textFields objectAtIndex:0] text]];
                                                               [self.tableView reloadData];
                                                           }];
    
    [alert addAction:cancelAction];
    [alert addAction:addAction];
    addAction.enabled = NO;
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Only one section for this list
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // The number of rows is the number of NameLists in sharedNameListStore
    return [[[NameListStore sharedNameListStore] allNameLists] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonList *nameList = [[[NameListStore sharedNameListStore] allNameLists] objectAtIndex:[indexPath row]];
    
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
    PersonList *selectedNameList = [[[NameListStore sharedNameListStore] allNameLists] objectAtIndex:[indexPath row]];
    
    [createEditDetailViewController setNameList:selectedNameList];
    
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
        PersonList *nameListToDelete = [[[NameListStore sharedNameListStore] allNameLists] objectAtIndex:indexPath.row];
        [[NameListStore sharedNameListStore] removeNameList:nameListToDelete];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    [[NameListStore sharedNameListStore] moveItemAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
