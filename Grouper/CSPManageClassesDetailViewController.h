//
//  CreateEditDetailViewController.h
//  ClassSplit
//
//  Created by Aaron Schendel on 3/18/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPClass.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface CSPManageClassesDetailViewController : UITableViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) CSPClass *personList;

- (IBAction)addNewPerson:(id)sender;

@end
