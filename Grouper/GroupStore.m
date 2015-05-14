//
//  GroupStore.m
//  Grouper
//
//  Created by Aaron Schendel on 3/6/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "GroupStore.h"
#import "Group.h"
#import "Person.h"

@implementation GroupStore

- (id)init
{
    self = [super init];
    if (self) {
        allGroups = [[NSMutableArray alloc] init];

        // Setup for group 1
        NSMutableArray *g1 = [[NSMutableArray alloc] init];
        [g1 addObject:[[Person alloc] initWithFirstName:@"Harry" lastName:@"Potter" gender:MALE]];
        [g1 addObject:[[Person alloc] initWithFirstName:@"Hermione" lastName:@"Granger" gender:FEMALE]];
        NSMutableArray *g2 = [[NSMutableArray alloc] init];
        [g2 addObject:[[Person alloc] initWithFirstName:@"Ron" lastName:@"Weasley" gender:MALE]];
        [g2 addObject:[[Person alloc] initWithFirstName:@"Neville" lastName:@"Longbottom" gender:MALE]];
        NSMutableArray *group1SubGroups = [[NSMutableArray alloc] init];
        [group1SubGroups addObject:g1];
        [group1SubGroups addObject:g2];
        
        // Setup for group 2
        NSMutableArray *gg1 = [[NSMutableArray alloc] init];
        [gg1 addObject:[[Person alloc] initWithFirstName:@"Eddard" lastName:@"Stark" gender:MALE]];
        [gg1 addObject:[[Person alloc] initWithFirstName:@"Arya" lastName:@"Stark" gender:FEMALE]];
        NSMutableArray *gg2 = [[NSMutableArray alloc] init];
        [gg2 addObject:[[Person alloc] initWithFirstName:@"Jon" lastName:@"Snow" gender:MALE]];
        [gg2 addObject:[[Person alloc] initWithFirstName:@"Daenerys" lastName:@"Targaryen" gender:FEMALE]];
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

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.allGroups = [coder decodeObjectForKey:@"allGroups"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.allGroups forKey:@"allGroups"];
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
    NSData *allGroupsEncoded = [NSKeyedArchiver archivedDataWithRootObject:self.allGroups];
    [[NSUserDefaults standardUserDefaults] setObject:allGroupsEncoded forKey:@"allGroups"];
}

- (void)loadFromDefaults
{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"allGroups"]) {
        NSData *allGroupsEncoded = [[NSUserDefaults standardUserDefaults] objectForKey:@"allGroups"];
        self.allGroups = [NSKeyedUnarchiver unarchiveObjectWithData:allGroupsEncoded];
    }
    
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
