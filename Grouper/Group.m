//
//  Group.m
//  Grouper
//
//  Created by Aaron Schendel on 3/2/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "Group.h"

@implementation Group

@synthesize groupName, subGroups, numberOfGroups;

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.groupName = [coder decodeObjectForKey:@"groupName"];
        self.subGroups = [coder decodeObjectForKey:@"subGroups"];
        self.numberOfGroups = [coder decodeIntegerForKey:@"numberOfGroups"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.groupName forKey:@"groupName"];
    [coder encodeObject:self.subGroups forKey:@"subGroups"];
    [coder encodeInteger:self.numberOfGroups forKey:@"numberOfGroups"];
}

@end
