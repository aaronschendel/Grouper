//
//  CSPExclusionRuleRootController.m
//  ClassSplit
//
//  Created by Aaron Schende on 9/5/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPExclusionRuleRootController.h"
#import "CSPExclusionRulesViewController.h"

@interface CSPExclusionRuleRootController ()

@end

@implementation CSPExclusionRuleRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    CSPExclusionRulesViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CSPExclusionRulesViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    CSPExclusionRulesViewController *childViewController = [[CSPExclusionRulesViewController alloc] initWithNibName:@"CSPExclusionRulesViewController" bundle:nil];
    childViewController.index = index;
    childViewController.selectedClass = self.selectedClass;
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(CSPExclusionRulesViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(CSPExclusionRulesViewController *)viewController index];
    
    index++;
    
    if (index == 2) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 2;
}

-(NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}




@end
