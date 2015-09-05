//
//  CSPExclusionRulesViewController.m
//  ClassSplit
//
//  Created by Aaron Schende on 8/27/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPExclusionRulesViewController.h"
#import "CSPStudent.h"
#import "CSPClass.h"

@interface CSPExclusionRulesViewController ()
{
    NSArray *_pickerData;
    NSMutableArray *_exclusionRules;
}
@end

@implementation CSPExclusionRulesViewController
@synthesize selectedClass;
@synthesize pickerView1;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationItem setTitle:@"Set Exclusion Rules"];
    
    _pickerData = selectedClass.students;
    
    self.pickerView1.dataSource = self;
    self.pickerView1.delegate = self;
    self.pickerView2.dataSource = self;
    self.pickerView2.delegate = self;
}


#pragma mark - PickerView Setup
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // Number of columns in picker
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // Sets date for specific row and component
    NSString *firstName = [[_pickerData objectAtIndex:row] firstName];
    NSString *lastName = [[_pickerData objectAtIndex:row] lastName];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    return fullName;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // Number of rows of data
    return _pickerData.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // Handle which row was selected
    if (row == 0) {
        //NSLog(@"Female picked");
        //_person.gender = FEMALE;
    } else if (row == 1) {
        //NSLog(@"Male picked");
        //_person.gender = MALE;
    }
}



- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createExclusionRule:(id)sender {
    NSInteger row1 = [self.pickerView1 selectedRowInComponent:0];
    CSPStudent *selectedStudent1 = [_pickerData objectAtIndex:row1];
    NSInteger row2 = [self.pickerView2 selectedRowInComponent:0];
    CSPStudent *selectedStudent2 = [_pickerData objectAtIndex:row2];
    
    NSLog(@"%@", selectedStudent1);
    NSLog(@"%@", selectedStudent2);
    
    NSArray *newExclusionRule = [NSArray arrayWithObjects:selectedStudent1, selectedStudent2, nil];
    

}
@end
