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
        allNameLists = [[NSMutableArray alloc] init];
        
        // Setup for NameList 1
        PersonList *nameList1 = [[PersonList alloc] init];
        NSMutableArray *names1 = [[NSMutableArray alloc] init];
        [names1 addObject:@"Harry"];
        [names1 addObject:@"Hermione"];
        [names1 addObject:@"Ron"];
        [names1 addObject:@"Neville"];
        [nameList1 setListName:@"Period 1"];
        [nameList1 setNames:names1];
        
        // Setup for NameList 2
        PersonList *nameList2 = [[PersonList alloc] init];
        NSMutableArray *names2 = [[NSMutableArray alloc] init];
        [names2 addObject:@"Steve"];
        [names2 addObject:@"Jeff"];
        [names2 addObject:@"Zelda"];
        [names2 addObject:@"Neepo"];
        [nameList2 setListName:@"Period 2"];
        [nameList2 setNames:names2];
       
        // Adding nameList 1 and 2 to allNameLists
        [allNameLists addObject:nameList1];
        [allNameLists addObject:nameList2];
        
    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedNameListStore];
}

- (NSMutableArray *)allNameLists
{
    return allNameLists;
}

- (void)setAllNameLists:(NSArray *)newArray
{
    allNameLists = [newArray mutableCopy];
}

- (PersonList *)createNameList
{
    PersonList *nameList = [[PersonList alloc] init];
    [allNameLists addObject:nameList];
    return nameList;
}

- (void)removeNameList:(PersonList *)g
{
    [allNameLists removeObjectIdenticalTo:g];
}

- (void)removeAllNameLists
{
    allNameLists = nil;
}

- (void)saveChanges
{
    
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
    
    PersonList *nl = [allNameLists objectAtIndex:from];
    [allNameLists removeObjectAtIndex:from];
    [allNameLists insertObject:nl atIndex:to];
}

@end