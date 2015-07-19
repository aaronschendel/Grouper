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
    NSArray *_allGroupsSorted;
    NSArray *_uniqueClassesSorted;
    NSMutableDictionary *_classCounterDict;
    int _tableViewCounter;
    NSMutableArray *_colorPalette;
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
    _tableViewCounter = 0;
    NSMutableArray  *_uniqueClasses = [NSMutableArray new];
    _classCounterDict = [NSMutableDictionary new];
    
    // Get a copy of allGroups and sort them alphabetically
    NSMutableArray *allGroupsCopy = [[[CSPGroupStore sharedGroupStore] allGroups] copy];
    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"classCreatedFrom" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
    _allGroupsSorted = [allGroupsCopy sortedArrayUsingDescriptors:descriptors];
    
    // Populate the unique classes array and populate the classCounterDict
    for (int i = 0; i < [_allGroupsSorted count]; i++) {
        NSString *currCreatedFrom = [[_allGroupsSorted objectAtIndex:i] classCreatedFrom];
        if (![_uniqueClasses containsObject:currCreatedFrom]) {
            [_uniqueClasses addObject:currCreatedFrom];
            [_classCounterDict setObject:@"1" forKey:currCreatedFrom];
        } else {
            NSInteger tempInt = [[_classCounterDict objectForKey:currCreatedFrom] integerValue];
            tempInt = tempInt + 1;
            [_classCounterDict setObject:[@(tempInt) stringValue] forKey:currCreatedFrom];
        }
    }
    
    _uniqueClassesSorted = [_uniqueClasses sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
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
    NSString *title = [[NSString alloc] initWithFormat:@"Class: %@", [_uniqueClassesSorted objectAtIndex:section]];
    return title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _uniqueClassesSorted.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //
    return [[_classCounterDict valueForKey:[_uniqueClassesSorted objectAtIndex:section]] integerValue];
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
    CSPGroup *group = [_allGroupsSorted objectAtIndex:_tableViewCounter];
    _tableViewCounter++;
    
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
    CSPGroup *selectedGroup = [[[CSPGroupStore sharedGroupStore] allGroups] objectAtIndex:[indexPath row]];
    
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
        CSPGroup *groupToDelete = [_allGroupsSorted objectAtIndex:indexPath.row];
        [[[CSPGroupStore sharedGroupStore] allGroups] removeObjectIdenticalTo:groupToDelete];
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
