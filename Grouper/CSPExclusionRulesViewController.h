//
//  CSPExclusionRulesViewController.h
//  ClassSplit
//
//  Created by Aaron Schende on 8/27/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPClass.h"

@interface CSPExclusionRulesViewController : UIViewController <UIPickerViewAccessibilityDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) CSPClass *selectedClass;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView1;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView2;

@property (assign, nonatomic) NSInteger index;

- (IBAction)cancel:(id)sender;
- (IBAction)createExclusionRule:(id)sender;

@end
