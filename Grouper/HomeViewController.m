//
//  HomeViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 3/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "HomeViewController.h"
#import "ViewGroupsViewController.h"
#import "CreateEditViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)createGroups:(UIButton *)sender {
}

- (IBAction)viewEditLists:(UIButton *)sender {
    CreateEditViewController *cevc = [[CreateEditViewController alloc] init];
    [[self navigationController] pushViewController:cevc animated:YES];
}

- (IBAction)viewGroups:(UIButton *)sender {
    ViewGroupsViewController *vgvc = [[ViewGroupsViewController alloc] init];
    [[self navigationController] pushViewController:vgvc animated:YES];
}

@end
