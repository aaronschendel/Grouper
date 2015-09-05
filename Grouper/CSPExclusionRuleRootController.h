//
//  CSPExclusionRuleRootController.h
//  ClassSplit
//
//  Created by Aaron Schende on 9/5/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPClass.h"

@interface CSPExclusionRuleRootController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) CSPClass *selectedClass;

@end
