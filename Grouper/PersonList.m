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

- (NSString *) description {
    return [NSString stringWithFormat:@"PersonList: %@", listName];
}

@end
