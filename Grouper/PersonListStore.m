//
//  NameListStore.m
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "PersonListStore.h"
#import "PersonList.h"

@implementation PersonListStore
- (id)init
{
    self = [super init];
    if (self) {
        allPersonLists = [[NSMutableArray alloc] init];
        
        // Setup for NameList 1
        PersonList *nameList1 = self.createPersonList;
        NSMutableArray *names1 = [[NSMutableArray alloc] init];
        [names1 addObject:@"Harry"];
        [names1 addObject:@"Hermione"];
        [names1 addObject:@"Ron"];
        [names1 addObject:@"Neville"];
        [nameList1 setListName:@"Period 1"];
        [nameList1 setNames:names1];
        
        // Setup for NameList 2
        PersonList *nameList2 = self.createPersonList;
        NSMutableArray *names2 = [[NSMutableArray alloc] init];
        [names2 addObject:@"Steve"];
        [names2 addObject:@"Jeff"];
        [names2 addObject:@"Zelda"];
        [names2 addObject:@"Neepo"];
        [nameList2 setListName:@"Period 2"];
        [nameList2 setNames:names2];
       
        // Adding nameList 1 and 2 to allNameLists
        //[allPersonLists addObject:nameList1];
        //[allNameLists addObject:nameList2];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if ((self = [super init])) {
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
    [[NSUserDefaults standardUserDefaults] setObject:self.allPersonLists forKey:@"allPersonLists"];
}

- (void)loadFromDefaults
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"allPersonLists"]) {
        self.allPersonLists = [[NSUserDefaults standardUserDefaults] objectForKey:@"allPersonLists"];
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
