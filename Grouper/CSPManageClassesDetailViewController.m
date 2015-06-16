//
//  CreateEditDetailViewController.m
//  ClassSplit
//
//  Created by Aaron Schendel on 3/18/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPManageClassesDetailViewController.h"
#import "CSPNameTableViewCell.h"
#import "CSPClass.h"
#import "CSPClassStore.h"
#import "CSPStudent.h"
#import "CSPAddStudentViewController.h"


@interface CSPManageClassesDetailViewController ()

@end

@implementation CSPManageClassesDetailViewController

@synthesize personList;

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewPerson:)];
    UIBarButtonItem *emptyItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    NSArray *toolbarButtons = [NSArray arrayWithObjects:emptyItem, item1, nil];
    [self setToolbarItems:toolbarButtons];
    
    // Setup for empty data set Pod
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.tableFooterView = [UIView new];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    UINavigationItem *nav = [self navigationItem];
    NSString *title = [[NSString alloc] initWithFormat:@"%@", self.personList.listName];
    [nav setTitle:title];
    
    [self.tableView reloadData];
    
    // Done to fix bug in DZNEmptyDataSet
    if (self.tableView.contentOffset.y < 0 && self.tableView.emptyDataSetVisible) {
        self.tableView.contentOffset = CGPointZero;
    }
    
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
    
    CSPAddStudentViewController *addStudentViewController = [[CSPAddStudentViewController alloc] init];
    addStudentViewController.personList = self.personList;
    [self.navigationController presentViewController:addStudentViewController animated:YES completion:nil];
  
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Should be as many rows as there are names
    return [self.personList.students count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    CSPStudent *person = [personList.students objectAtIndex:indexPath.row];
    
    
    NSString *uniqueIdentifier = @"NameCell";
    CSPNameTableViewCell *cell = nil;
    cell = (CSPNameTableViewCell *) [self.tableView dequeueReusableCellWithIdentifier:uniqueIdentifier];
    if (!cell) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CSPNameTableViewCell" owner:nil options:nil];
        for (id currentObject in topLevelObjects) {
            cell = (CSPNameTableViewCell *)currentObject;
            break;
        }
    }
    
    NSString *fullName = [[NSString alloc] initWithFormat:@"%@ %@", person.firstName, person.lastName];
    [cell.name setText:fullName];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    CSPAddStudentViewController *addStudentViewController = [[CSPAddStudentViewController alloc] init];
    CSPStudent *selectedStudent = [self.personList.students objectAtIndex:[indexPath row]];
    
    [addStudentViewController setIsExistingStudent:true];
    [addStudentViewController setSelectedStudent:selectedStudent];
    
    [self.navigationController presentViewController:addStudentViewController animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [personList.students removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
    [self.tableView reloadData];
}


#pragma mark - DZNEmptyDataSet data source

- (void)dealloc
{
    self.tableView.emptyDataSetSource = nil;
    self.tableView.emptyDataSetDelegate = nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    // The attributed string for the title of the empty dataset
    
    NSString *text = @"Let's Add Some Students!";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    // The attributed string for the description of the empty dataset
    NSString *text = @"Tap the plus to add a student to your new list";
    
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

#pragma mark - DZNEmptyDataSet delegate implementation

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
{
    
}



@end
