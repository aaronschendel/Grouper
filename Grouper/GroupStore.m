//
//  GroupStore.m
//  Grouper
//
//  Created by Aaron Schendel on 3/6/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "GroupStore.h"
#import "Group.h"

@implementation GroupStore

- (id)init
{
    self = [super init];
    if (self) {
        allGroups = [[NSMutableArray alloc] init];
        

        // Setup for group 1
        NSMutableArray *g1 = [[NSMutableArray alloc] init];
        [g1 addObject:@"Ron"];
        [g1 addObject:@"Hermione"];
        NSMutableArray *g2 = [[NSMutableArray alloc] init];
        [g2 addObject:@"Harry"];
        [g2 addObject:@"Neville"];
        NSMutableArray *group1SubGroups = [[NSMutableArray alloc] init];
        [group1SubGroups addObject:g1];
        [group1SubGroups addObject:g2];
        // Setup for group 2
        NSMutableArray *gg1 = [[NSMutableArray alloc] init];
        [gg1 addObject:@"Steve"];
        [gg1 addObject:@"Jeff"];
        NSMutableArray *gg2 = [[NSMutableArray alloc] init];
        [gg2 addObject:@"Zelda"];
        [gg2 addObject:@"Neepo"];
        NSMutableArray *group2SubGroups = [[NSMutableArray alloc] init];
        [group2SubGroups addObject:gg1];
        [group2SubGroups addObject:gg2];
        
        Group *group1 = [[Group alloc] init];
        [group1 setNumberOfGroups:2];
        [group1 setGroupName:@"Literacy Groups"];
        [group1 setSubGroups:group1SubGroups];

        Group *group2 = [[Group alloc] init];
        [group2 setNumberOfGroups:2];
        [group2 setGroupName:@"Lab #1 Partners"];
        [group2 setSubGroups:group2SubGroups];
        
        [allGroups addObject:group1];
        [allGroups addObject:group2];

    }
    return self;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedGroupStore];
}

- (NSMutableArray *)allGroups
{
    return allGroups;
}

- (void)setAllGroups:(NSArray *)newArray
{
    allGroups = [newArray mutableCopy];
}

- (Group *)createGroup
{
    Group *group = [[Group alloc] init];
    [allGroups addObject:group];
    return group;
}

- (void)removeGroup:(Group *)g
{
    [allGroups removeObjectIdenticalTo:g];
}

- (void)removeAllGroups
{
    allGroups = nil;
}

- (void)saveChanges
{
    
}

+ (GroupStore *)sharedGroupStore
{
    static GroupStore *groupStore = nil;
    if (!groupStore) {
        groupStore = [[super allocWithZone:nil] init];
    }
    return groupStore;
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
    if (from == to) {
        return;
    }
    
    Group *g = [allGroups objectAtIndex:from];
    [allGroups removeObjectAtIndex:from];
    [allGroups insertObject:g atIndex:to];
}






@end
