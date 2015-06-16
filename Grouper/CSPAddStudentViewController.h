//
//  AddPersonViewController.h
//  ClassSplit
//
//  Created by Aaron Schendel on 5/19/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPClass.h"
#import "CSPStudent.h"

@interface CSPAddStudentViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UITextField *emailAddressTF;
@property (weak, nonatomic) IBOutlet UIPickerView *genderPicker;

- (IBAction)backgroundTapped:(id)sender;

- (IBAction)addPerson:(id)sender;
- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) CSPClass *personList;
@property (nonatomic) BOOL isExistingStudent;
@property (nonatomic, strong) CSPStudent *selectedStudent;

@end
