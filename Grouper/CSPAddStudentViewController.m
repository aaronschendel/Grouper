//
//  AddPersonViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 5/19/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPAddStudentViewController.h"
#import "CSPStudent.h"
#import "CSPStudentList.h"


@interface CSPAddStudentViewController ()
{
    NSArray *_pickerData;
    CSPStudent *_person;
}
@end

@implementation CSPAddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerData = @[@"Female", @"Male"];
    
    self.genderPicker.dataSource = self;
    self.genderPicker.delegate = self;
    self.firstNameTF.delegate = self;
    self.lastNameTF.delegate = self;
    self.emailAddressTF.delegate = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationItem setTitle:@"Add Person"];
    
    [self.navigationController setToolbarHidden:YES];
}

- (IBAction)addPerson:(id)sender {
    
    _person = [[CSPStudent alloc] init];
    
    _person.firstName = self.firstNameTF.text;
    _person.lastName = self.lastNameTF.text;
    _person.emailAddress = self.emailAddressTF.text;
    
    NSInteger row = [self.genderPicker selectedRowInComponent:0];
    NSString *selectedGender = [_pickerData objectAtIndex:row];
    
    if ([selectedGender  isEqual: @"Male"]) {
        _person.gender = MALE;
        NSLog(@"Gender is male!");
    } else if ([selectedGender  isEqual: @"Female"]) {
        _person.gender = FEMALE;
        NSLog(@"Gender is female!");
    }
    
    [self.personList.people addObject:_person];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Setting up textfield delegation
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)backgroundTapped:(id)sender {
    [[self view] endEditing:YES];
}



#pragma mark - PickerView Setup
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    // Number of columns in picker
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    // Sets date for specific row and component
    return _pickerData[row];
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

@end
