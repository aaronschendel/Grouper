//
//  CreateEditDetailViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 3/18/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CreateEditDetailViewController.h"
#import "NameTableViewCell.h"
#import "PersonList.h"
#import "NameListStore.h"


@interface CreateEditDetailViewController ()

@end

@implementation CreateEditDetailViewController

@synthesize nameList;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPerson:)];
    UIBarButtonItem *emptyItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *toolbarButtons = [NSArray arrayWithObjects:emptyItem, item1, nil];
    [self setToolbarItems:toolbarButtons];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    UINavigationItem *nav = [self navigationItem];
    NSString *title = [[NSString alloc] initWithFormat:@"%@", self.nameList.listName];
    [nav setTitle:title];
    
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

- (void)addNewPerson:(id)sender {
    // present personCreateView and get the name of the person
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Add Name"
                                                                   message:@"Enter Name of Person"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"Name";
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

        [self.nameList.names addObject:[[alert.textFields objectAtIndex:0] text]];
                                                          
        [[self tableView] reloadData];
    }];
    
    
    [alert addAction:cancelAction];
    [alert addAction:addAction];
    addAction.enabled = NO;
    [self presentViewController:alert animated:YES completion:nil];
    
    
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Should be as many rows as there are names
    return [self.nameList.names count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    NSString *name = [nameList.names objectAtIndex:indexPath.row];
    
    
    NSString *uniqueIdentifier = @"NameCell";
    NameTableViewCell *cell = nil;
    cell = (NameTableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"NameTableViewCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            cell = (NameTableViewCell *)currentObject;
            break;
        }
    }
    
    [cell.name setText: name];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [nameList.names removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"TEST");
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        NameList *nameListToDelete = [[[NameListStore sharedNameListStore] allNameLists] objectAtIndex:indexPath.row];
//        [[NameListStore sharedNameListStore] removeNameList:nameListToDelete];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }
//}

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
