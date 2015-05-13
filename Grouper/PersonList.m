//
//  NameList.m
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "PersonList.h"

@implementation PersonList

@synthesize listName, names;

- (id)init {
    self = [super init];
    if (self) {
        
        if (!self.names) {
            self.names = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"PersonList: %@", listName];
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:listName forKey:@"listName"];
    [coder encodeObject:names forKey:@"names"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
    
        self.listName = [decoder decodeObjectForKey:@"listName"];
        self.names = [decoder decodeObjectForKey:@"names"];
    }
    return self;
}

@end
