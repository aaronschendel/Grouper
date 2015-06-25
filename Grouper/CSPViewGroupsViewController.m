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

@interface CSPViewGroupsViewController ()
{
    NSMutableArray *_uniqueClasses;
    NSMutableDictionary *_uniqueClassesDict;
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
    
    _uniqueClasses = [NSMutableArray new];
    _uniqueClassesDict = [NSMutableDictionary new];
    
//    NSSortDescriptor *valueDescriptor = [[NSSortDescriptor alloc] initWithKey:@"MyStringVariableName" ascending:YES];
//    NSArray *descriptors = [NSArray arrayWithObject:valueDescriptor];
//    NSArray *sortedArray = [myArray sortedArrayUsingDescriptors:descriptors];
    
//    -(NSComparisonResult)compare:(MyObject*)obj {
//        return [self.name compare:obj.name];
//    }
//    
//    [array sortUsingSelector:@selector(compare:)];
    
    for (int i = 0; i < [[[CSPGroupStore sharedGroupStore] allGroups] count]; i++) {
        NSMutableArray *currCreatedFrom = [[[[CSPGroupStore sharedGroupStore] allGroups] objectAtIndex:i] classesCreatedFrom];
        NSLog(@"%@",currCreatedFrom);
        for (int j = 0; j < currCreatedFrom.count; j++) {
            NSString *currClass = [currCreatedFrom objectAtIndex:j];
            if (![_uniqueClasses containsObject:currClass]) {
                [_uniqueClasses addObject:currClass];
                [_uniqueClassesDict setObject:@"1" forKey:currClass];
            } else {
                NSInteger tempInt = [[_uniqueClassesDict objectForKey:currClass] integerValue];
                tempInt = tempInt + 1;
                [_uniqueClassesDict setObject:[@(tempInt) stringValue] forKey:currClass];
            }
        }
    }
    NSLog(@"%lu",(unsigned long)_uniqueClasses.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = [[NSString alloc] initWithFormat:@"Created from: %@", [_uniqueClasses objectAtIndex:section]];
    return title;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _uniqueClasses.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //
    return [[_uniqueClassesDict valueForKey:[_uniqueClasses objectAtIndex:section]] integerValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {    
    CSPGroup *group = [[[CSPGroupStore sharedGroupStore] allGroups] objectAtIndex:[indexPath row]];
    
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
        CSPGroup *groupToDelete = [[[CSPGroupStore sharedGroupStore] allGroups] objectAtIndex:indexPath.row];
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
