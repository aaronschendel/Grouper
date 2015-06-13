//
//  AddPersonViewController.m
//  ClassSplit
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
    
    if (self.isExistingStudent) {
        [self.addButton setTitle:@"Save" forState:UIControlStateNormal];
        
        [self.firstNameTF setText:self.selectedStudent.firstName];
        [self.lastNameTF setText:self.selectedStudent.lastName];
        [self.emailAddressTF setText:self.selectedStudent.emailAddress];
        if (self.selectedStudent.gender == FEMALE) {
            [self.genderPicker selectRow:0 inComponent:0 animated:YES];
        } else {
            [self.genderPicker selectRow:1 inComponent:0 animated:YES];
        }
    }
    
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
    
    if (self.firstNameTF.text.length == 0) {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"First Name Required"
                                                                       message:@"Please enter this student's first name"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * action) {}];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    

    if (self.isExistingStudent) {
        // Modify existing student
        
        self.selectedStudent.firstName = self.firstNameTF.text;
        self.selectedStudent.lastName = self.lastNameTF.text;
        self.selectedStudent.emailAddress = self.emailAddressTF.text;
        
        NSInteger row = [self.genderPicker selectedRowInComponent:0];
        NSString *selectedGender = [_pickerData objectAtIndex:row];
        
        if ([selectedGender  isEqual: @"Male"]) {
            self.selectedStudent.gender = MALE;
            NSLog(@"Gender is male!");
        } else if ([selectedGender  isEqual: @"Female"]) {
            self.selectedStudent.gender = FEMALE;
            NSLog(@"Gender is female!");
        }
    } else {
        // Create new student
        
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
    }
    
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
