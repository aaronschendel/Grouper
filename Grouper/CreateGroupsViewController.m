//
//  CreateGroupsViewController.m
//  Grouper
//
//  Created by Aaron Schendel on 4/19/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CreateGroupsViewController.h"
#import "PersonList.h"
#import "PersonListStore.h"

@interface CreateGroupsViewController ()

@end

@implementation CreateGroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNumberOfPeopleValue];
    [self.numberOfPeopleLabel setText:[NSString stringWithFormat:@"%ld",(long)self.totalNumberOfPeople]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationItem setTitle:@"Create Groups"];
    
    [self.navigationController setToolbarHidden:YES];
}

- (void)setNumberOfPeopleValue {
    self.totalNumberOfPeople = 0;
    for (int i = 0; i < self.selectedPersonLists.count; i++) {
        PersonList *p = [self.selectedPersonLists objectAtIndex:i];
        self.totalNumberOfPeople = self.totalNumberOfPeople + p.names.count;
    }
}

- (IBAction)tapReceived:(id)sender {
    [[self view] endEditing:YES];
}

- (void)groupify {
    
}


- (IBAction)createGroups:(id)sender {
    
    NSInteger numberOfPeople = self.totalNumberOfPeople;
    NSInteger numberOfGroups = [self.numberOfGroupsTF.text integerValue];
    NSString *groupSetName = self.groupSetNameTF.text;
    
    NSMutableArray *shuffledNames = [[[PersonListStore sharedNameListStore] allNameLists] copy];
    [shuffledNames ];
    
    func createGroups(numberOfGroups: Int, names: Array<String>) -> Array<Array<String>> {
        
        // Determine how many people in each group and how many are leftover
        var amountInGroup:Int = Int(floor(Float(names.count) / Float(numberOfGroups)))
        var amountRemaining:Int = names.count % numberOfGroups
        
        var shuffledNames = names.shuffleImmutable()
        
        // An array that contains all the group arrays
        var listOfGroups:Array<Array<String>> = []
        
        // For each group
        for (var i = 0; i < numberOfGroups; i++){
            var group:Array<String> = []
            
            // Remove one name from arrayOfNames and add it to the current group
            for (var j = 0; j < amountInGroup; j++) {
                if (!shuffledNames.isEmpty) {
                    group.append(shuffledNames.removeAtIndex(0))
                }
            }
            listOfGroups.append(group)
            
        }
        return listOfGroups
        
    }

    
}

@end
