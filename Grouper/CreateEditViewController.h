//
//  CreateEditViewController.h
//  Grouper
//
//  Created by Aaron Schendel on 3/5/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEditViewController : UITableViewController

@property (strong, nonatomic) UIBarButtonItem *addButton;

- (IBAction)addNewList:(id)sender;

@end
