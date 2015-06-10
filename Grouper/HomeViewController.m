//
//  HomeViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 3/15/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "HomeViewController.h"
#import "SelectListsViewController.h"
#import "ViewGroupsViewController.h"
#import "CreateEditViewController.h"
#import "AboutPageViewController.h"
#import "PersonListStore.h"
#import "GroupStore.h"
#import <ChameleonFramework/Chameleon.h>

@interface HomeViewController ()

-(void)setAppColors;
@end

@implementation HomeViewController

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
    
    if (PersonListStore.sharedPersonListStore.allPersonLists.count < 1) {
        self.createGroupsButton.enabled = NO;
        self.createGroupsButton.alpha = 0.6f;
    } else {
        self.createGroupsButton.enabled = YES;
        self.createGroupsButton.alpha = 1.0f;
    }
    
    if (GroupStore.sharedGroupStore.allGroups.count < 1) {
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
    SelectListsViewController *svc = [[SelectListsViewController alloc] init];
    [[self navigationController] pushViewController:svc animated:YES];

}

- (IBAction)viewEditLists:(UIButton *)sender {
    CreateEditViewController *cevc = [[CreateEditViewController alloc] init];
    [[self navigationController] pushViewController:cevc animated:YES];
}

- (IBAction)viewGroups:(UIButton *)sender {
    ViewGroupsViewController *vgvc = [[ViewGroupsViewController alloc] init];
    [[self navigationController] pushViewController:vgvc animated:YES];
}

- (IBAction)about:(UIButton *)sender {
    AboutPageViewController *apvc = [[AboutPageViewController alloc] init];
    apvc.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [[self navigationController] presentViewController:apvc animated:YES completion:nil];
}



@end
