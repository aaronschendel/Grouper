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
        if (!allGroups) {
            Group *group1 = [[Group alloc] init];
            [group1 setNumberOfGroups:3];
            
            
        }
    }
    return self;


}

@end
