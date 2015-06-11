//
//  CreateEditViewController.h
//  ClassSplit
//
//  Created by Aaron Schendel on 3/5/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface CSPManageClassesViewController : UITableViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (strong, nonatomic) UIBarButtonItem *bbi;
@property (strong, nonatomic) UIBarButtonItem *cancelButton;

- (IBAction)addNewNameList:(id)sender;


@end
