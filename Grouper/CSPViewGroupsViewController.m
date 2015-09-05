//
//  ViewGroupsViewController.m
//  ClassSplit
//
//  Created by Aaron Schendel on 3/9/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPViewGroupsViewController.h"
#import "CSPGroupStore.h"
#import "CSPGroupTableViewCell.h"
#import "CSPGroup.h"
#import "CSPGroupDetailViewController.h"
#import <ChameleonFramework/Chameleon.h>

@interface CSPViewGroupsViewController ()
{
    NSMutableArray *_colorPalette;
    NSMutableArray *_classesCreatedFromArrays;
}
@end

@implementation CSPViewGroupsViewController

@synthesize numOfGroups;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setTitle:@"Groups"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Reset the instance variables whenever on page load
    
    NSMutableArray *allGroupsCopy = [[[CSPGroupStore sharedGroupStore] allGroups] copy];
    
    NSMutableArray  *_uniqueClasses = [NSMutableArray new];
    // Populate the unique classes array and populate the classCounterDict
    for (CSPGroup *currGroup in allGroupsCopy) {
        if (![_uniqueClasses containsObject:[currGroup classCreatedFrom]]) {
            [_uniqueClasses addObject:[currGroup classCreatedFrom]];
        }
    }
    
    //http://www.ioscreator.com/tutorials/customizing-headers-footers-table-view-ios7
    
    //loop through all unique classes and then for each class loop through every group seeing if they match, if they do then put them in an array and build the dictionary based on that.
    _classesCreatedFromArrays = [NSMutableArray new];
    for (NSString *currClass in _uniqueClasses) {
        NSMutableArray *currClassArray = [NSMutableArray new];
        for (CSPGroup *currGroup in allGroupsCopy) {
            if ([currGroup.classCreatedFrom isEqualToString:currClass]) {
                [currClassArray addObject:currGroup];
            }
        }
        [_classesCreatedFromArrays addObject:currClassArray];
    }
    

    
    _colorPalette = [[NSMutableArray alloc] initWithArray:[NSArray arrayOfColorsWithColorScheme:ColorSchemeTriadic
                                                                                                        with:FlatSand
                                                                                                  flatScheme:YES]];
    self.view.backgroundColor = [_colorPalette objectAtIndex:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = [[NSString alloc] initWithFormat:@"Class: %@", [[[_classesCreatedFromArrays objectAtIndex:section] objectAtIndex:0] classCreatedFrom]];
    return title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _classesCreatedFromArrays.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_classesCreatedFromArrays objectAtIndex:section] count];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor flatWhiteColorDark];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    //return 20.0f;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CSPGroup *group = [[_classesCreatedFromArrays objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    
    
    
    
    NSString *uniqueIdentifier = @"GroupCell";
    CSPGroupTableViewCell *cell = nil;
    cell = (CSPGroupTableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CSPGroupTableViewCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            cell = (CSPGroupTableViewCell *)currentObject;
            break;
        }
    }
    
    [[cell groupName] setText:group.groupName];
    cell.backgroundColor = [_colorPalette objectAtIndex:1];
    
//    self.view.backgroundColor = [colorArray objectAtIndex:1];
//    
//    [self.createGroupsButton setTitleColor:[colorArray objectAtIndex:0] forState:UIControlStateNormal];
//    [self.createGroupsButton setTitleColor:[UIColor flatGrayColor] forState:UIControlStateDisabled];
//    
//    [self.createEditListsButton setTitleColor:[colorArray objectAtIndex:0] forState:UIControlStateNormal];
//    [self.viewGroupsButton setTitleColor:[colorArray objectAtIndex:0] forState:UIControlStateNormal];
//    [self.aboutButton setTitleColor:[colorArray objectAtIndex:0] forState:UIControlStateNormal];
//    
//    [self.appNameLabel setTextColor:[colorArray objectAtIndex:4]];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSPGroupDetailViewController *groupDetailViewController = [[CSPGroupDetailViewController alloc] init];
    CSPGroup *selectedGroup = [[_classesCreatedFromArrays objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [groupDetailViewController setGroup:selectedGroup];
    
    [[self navigationController] pushViewController:groupDetailViewController animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        CSPGroup *groupToDelete = [[_classesCreatedFromArrays objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        [[_classesCreatedFromArrays objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
        [[CSPGroupStore sharedGroupStore] removeGroup:groupToDelete];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
