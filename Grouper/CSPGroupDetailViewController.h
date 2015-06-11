//
//  GroupDetailViewController.h
//  ClassSplit
//
//  Created by Aaron Schendel on 3/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CSPGroup.h"

@interface CSPGroupDetailViewController : UITableViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) CSPGroup *group;
@property (nonatomic) BOOL isNewGroup;

@end
