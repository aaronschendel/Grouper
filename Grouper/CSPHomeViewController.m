//
//  HomeViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 3/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPHomeViewController.h"
#import "CSPSelectClassesViewController.h"
#import "CSPViewGroupsViewController.h"
#import "CSPManageClassesViewController.h"
#import "CSPAboutPageViewController.h"
#import "CSPStudentListStore.h"
#import "CSPGroupStore.h"
#import <ChameleonFramework/Chameleon.h>

@interface CSPHomeViewController ()

-(void)setAppColors;
@end

@implementation CSPHomeViewController

- (void)setAppColors {
    NSMutableArray *colorArray = [[NSMutableArray alloc] initWithArray:[NSArray arrayOfColorsWithColorScheme:ColorSchemeTriadic
                                                                                                        with:FlatSand
                                                                                                  flatScheme:YES]];
    //self.createGroupsButton.backgroundColor = [colorArray objectAtIndex:3];
    //self.createGroupsButton.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.view.backgroundColor = [colorArray objectAtIndex:1];
    
    [self.createGroupsButton setTitleColor:[colorArray objectAtIndex:0] forState:UIControlStateNormal];
    [self.createGroupsButton setTitleColor:[UIColor flatGrayColor] forState:UIControlStateDisabled];
    
    [self.createEditListsButton setTitleColor:[colorArray objectAtIndex:0] forState:UIControlStateNormal];
    [self.viewGroupsButton setTitleColor:[colorArray objectAtIndex:0] forState:UIControlStateNormal];
    [self.aboutButton setTitleColor:[colorArray objectAtIndex:0] forState:UIControlStateNormal];
    
    [self.appNameLabel setTextColor:[colorArray objectAtIndex:4]];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = YES;
    
    if (CSPStudentListStore.sharedPersonListStore.allPersonLists.count < 1) {
        self.createGroupsButton.enabled = NO;
        self.createGroupsButton.alpha = 0.6f;
    } else {
        self.createGroupsButton.enabled = YES;
        self.createGroupsButton.alpha = 1.0f;
    }
    
    if (CSPGroupStore.sharedGroupStore.allGroups.count < 1) {
        self.viewGroupsButton.enabled = NO;
        self.viewGroupsButton.alpha = 0.6f;
    } else {
        self.viewGroupsButton.enabled = YES;
        self.viewGroupsButton.alpha = 1.0f;
    }
    
//    [self setAppColors];
    
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
    
//    if (PersonListStore.sharedPersonListStore.allPersonLists.count < 1) {
//        
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Create Lists First"
//                                                                       message:@"Add some lists of people before creating groups"
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel
//                                                             handler:^(UIAlertAction * action) {}];
//        [alert addAction:okAction];
//
//        [self presentViewController:alert animated:YES completion:nil];
//        
//        
//    }
    CSPSelectClassesViewController *svc = [[CSPSelectClassesViewController alloc] init];
    [[self navigationController] pushViewController:svc animated:YES];

}

- (IBAction)viewEditLists:(UIButton *)sender {
    CSPManageClassesViewController *cevc = [[CSPManageClassesViewController alloc] init];
    [[self navigationController] pushViewController:cevc animated:YES];
}

- (IBAction)viewGroups:(UIButton *)sender {
    CSPViewGroupsViewController *vgvc = [[CSPViewGroupsViewController alloc] init];
    [[self navigationController] pushViewController:vgvc animated:YES];
}

- (IBAction)about:(UIButton *)sender {
    CSPAboutPageViewController *apvc = [[CSPAboutPageViewController alloc] init];
    apvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[self navigationController] presentViewController:apvc animated:YES completion:nil];
}



@end
