//
//  CreateEditDetailViewController.h
//  Grouper
//
//  Created by Aaron Schendel on 3/18/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonList.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>


@interface CreateEditDetailViewController : UITableViewController <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) PersonList *personList;

- (IBAction)addNewPerson:(id)sender;

@end
