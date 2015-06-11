//
//  HomeViewController.h
//  ClassSplit
//
//  Created by Aaron Schendel on 3/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSPHomeViewController : UIViewController

- (IBAction)createGroups:(UIButton *)sender;
- (IBAction)viewEditLists:(UIButton *)sender;
- (IBAction)viewGroups:(UIButton *)sender;
- (IBAction)about:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *createGroupsButton;
@property (weak, nonatomic) IBOutlet UIButton *createEditListsButton;
@property (weak, nonatomic) IBOutlet UIButton *viewGroupsButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;


@property (weak, nonatomic) IBOutlet UILabel *appNameLabel;

@end
