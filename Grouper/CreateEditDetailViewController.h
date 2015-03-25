//
//  CreateEditDetailViewController.h
//  Grouper
//
//  Created by Aaron Schendel on 3/18/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NameList.h"

@interface CreateEditDetailViewController : UITableViewController

@property (nonatomic, strong) NameList *nameList;

- (IBAction)addNewPerson:(id)sender;

@end
