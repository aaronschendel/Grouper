//
//  Group.h
//  Grouper
//
//  Created by Aaron Schendel on 3/2/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property NSString *groupName;
@property NSMutableArray *subGroups;
@property NSInteger *numberOfGroups;

@end
