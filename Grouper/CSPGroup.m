//
//  Group.m
//  ClassSplit
//
//  Created by Aaron Schendel on 3/2/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPGroup.h"
#import "CSPStudent.h"

@implementation CSPGroup

@synthesize groupName, subGroups, numberOfGroups, classesCreatedFrom;

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        self.groupName = [coder decodeObjectForKey:@"groupName"];
        self.subGroups = [coder decodeObjectForKey:@"subGroups"];
        self.numberOfGroups = [coder decodeIntegerForKey:@"numberOfGroups"];
        self.classesCreatedFrom = [coder decodeObjectForKey:@"classCreatedFrom"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.groupName forKey:@"groupName"];
    [coder encodeObject:self.subGroups forKey:@"subGroups"];
    [coder encodeInteger:self.numberOfGroups forKey:@"numberOfGroups"];
    [coder encodeObject:self.classesCreatedFrom forKey:@"classesCreatedFrom"];
}

- (void)moveItemAtIndex:(NSIndexPath *)from toIndex:(NSIndexPath *)to {
    if (from == to) {
        return;
    }
    
    NSMutableArray *fromSubgroup = [subGroups objectAtIndex:from.section];
    CSPStudent *selectedPerson = [fromSubgroup objectAtIndex:from.row];
    [fromSubgroup removeObjectAtIndex:from.row];
    
    NSMutableArray *toSubgroup = [subGroups objectAtIndex:to.section];
    [toSubgroup insertObject:selectedPerson atIndex:to.row];
}

@end
