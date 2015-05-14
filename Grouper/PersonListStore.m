//
//  NameListStore.m
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "PersonListStore.h"
#import "PersonList.h"
#import "Person.h"

@implementation PersonListStore
- (id)init
{
    self = [super init];
    if (self) {
        allPersonLists = [[NSMutableArray alloc] init];
        
        // Setup for PersonList 1
        PersonList *nameList1 = self.createPersonList;
        NSMutableArray *people1 = [[NSMutableArray alloc] init];
        [people1 addObject:[[Person alloc] initWithFirstName:@"Harry" lastName:@"Potter" gender:MALE]];
        [people1 addObject:[[Person alloc] initWithFirstName:@"Hermione" lastName:@"Granger" gender:FEMALE]];
        [people1 addObject:[[Person alloc] initWithFirstName:@"Ron" lastName:@"Weasley" gender:MALE]];
        [people1 addObject:[[Person alloc] initWithFirstName:@"Neville" lastName:@"Longbottom" gender:MALE]];
        [nameList1 setListName:@"Period 1"];
        [nameList1 setPeople:people1];
        
        NSLog(@"%lu", (unsigned long)[[nameList1 people] count]);
        NSLog(@"test %@", [[nameList1.people objectAtIndex:0] firstName]);
        
        // Setup for PersonList 2
        PersonList *nameList2 = self.createPersonList;
        NSMutableArray *people2 = [[NSMutableArray alloc] init];
        [people2 addObject:[[Person alloc] initWithFirstName:@"Eddard" lastName:@"Stark" gender:MALE]];
        [people2 addObject:[[Person alloc] initWithFirstName:@"Arya" lastName:@"Stark" gender:FEMALE]];
        [people2 addObject:[[Person alloc] initWithFirstName:@"Jon" lastName:@"Snow" gender:MALE]];
        [people2 addObject:[[Person alloc] initWithFirstName:@"Daenerys" lastName:@"Targaryen" gender:FEMALE]];
        [nameList2 setListName:@"Period 2"];
        [nameList2 setPeople:people2];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.allPersonLists = [coder decodeObjectForKey:@"allPersonLists"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.allPersonLists forKey:@"allPersonLists"];
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedNameListStore];
}

- (NSMutableArray *)allPersonLists
{
    return allPersonLists;
}

- (void)setAllPersonLists:(NSArray *)newArray
{
    allPersonLists = [newArray mutableCopy];
}

- (PersonList *)createPersonList
{
    PersonList *personList = [[PersonList alloc] init];
    [allPersonLists addObject:personList];
    return personList;
}

- (void)removePersonList:(PersonList *)g
{
    [allPersonLists removeObjectIdenticalTo:g];
}

- (void)removeAllNameLists
{
    allPersonLists = nil;
}

- (void)saveChanges
{
    NSData *allPersonListsEncoded = [NSKeyedArchiver archivedDataWithRootObject:self.allPersonLists];
    [[NSUserDefaults standardUserDefaults] setObject:allPersonListsEncoded forKey:@"allPersonLists"];
}

- (void)loadFromDefaults
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"allPersonLists"]) {
        NSData *allPersonListsEncoded = [[NSUserDefaults standardUserDefaults] objectForKey:@"allPersonLists"];
        self.allPersonLists = [NSKeyedUnarchiver unarchiveObjectWithData:allPersonListsEncoded];
    }
    
}

+ (PersonListStore *)sharedNameListStore
{
    static PersonListStore *nameListStore = nil;
    if (!nameListStore) {
        nameListStore = [[super allocWithZone:nil] init];
    }
    return nameListStore;
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
    if (from == to) {
        return;
    }
    
    PersonList *nl = [allPersonLists objectAtIndex:from];
    [allPersonLists removeObjectAtIndex:from];
    [allPersonLists insertObject:nl atIndex:to];
}

@end
