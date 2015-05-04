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

@end
