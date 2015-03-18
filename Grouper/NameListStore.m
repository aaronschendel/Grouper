//
//  NameListStore.m
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "NameListStore.h"
#import "NameList.h"

@implementation NameListStore
- (id)init
{
    self = [super init];
    if (self) {
        allNameLists = [[NSMutableArray alloc] init];
        
        
        
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

- (NameList *)createNameList
{
    NameList *nameList = [[NameList alloc] init];
    [allNameLists addObject:nameList];
    return nameList;
}

- (void)removeNameList:(NameList *)g
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

+ (NameListStore *)sharedNameListStore
{
    static NameListStore *nameListStore = nil;
    if (!nameListStore) {
        nameListStore = [[super allocWithZone:nil] init];
    }
    return nameListStore;
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
    if (from == to) {
        return;
    }
    
    NameList *nl = [allNameLists objectAtIndex:from];
    [allNameLists removeObjectAtIndex:from];
    [allNameLists insertObject:nl atIndex:to];
}

@end
