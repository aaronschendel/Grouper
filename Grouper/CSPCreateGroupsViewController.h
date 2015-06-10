//
//  CreateGroupsViewController.h
//  Grouper
//
//  Created by Aaron Schendel on 4/19/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSPCreateGroupsViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSMutableArray *selectedPersonLists;
@property (nonatomic) NSInteger totalNumberOfPeople;

@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleLabel;
@property (weak, nonatomic) IBOutlet UITextField *numberOfGroupsTF;
@property (weak, nonatomic) IBOutlet UITextField *groupSetNameTF;

- (IBAction)createGroups:(id)sender;

@end
