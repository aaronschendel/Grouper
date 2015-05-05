//
//  GroupDetailViewController.h
//  Grouper
//
//  Created by Aaron Schendel on 3/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "Group.h"

@interface GroupDetailViewController : UITableViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) Group *group;
@property (nonatomic) BOOL isNewGroup;

@end
