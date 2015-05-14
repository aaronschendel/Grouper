//
//  NameList.m
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "PersonList.h"

@implementation PersonList

@synthesize listName, people;

- (id)init {
    self = [super init];
    if (self) {
        
        if (!self.people) {
            self.people = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"PersonList: %@", listName];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:listName forKey:@"listName"];
    [coder encodeObject:people forKey:@"people"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
    
        self.listName = [decoder decodeObjectForKey:@"listName"];
        self.people = [decoder decodeObjectForKey:@"people"];
    }
    return self;
}

@end
