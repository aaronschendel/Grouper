//
//  NameList.m
//  ClassSplit
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "CSPClass.h"

@implementation CSPClass

@synthesize listName, students;

- (id)init {
    self = [super init];
    if (self) {
        
        if (!self.students) {
            self.students = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"PersonList: %@", listName];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:listName forKey:@"listName"];
    [coder encodeObject:students forKey:@"people"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
    
        self.listName = [decoder decodeObjectForKey:@"listName"];
        self.students = [decoder decodeObjectForKey:@"people"];
    }
    return self;
}

@end
