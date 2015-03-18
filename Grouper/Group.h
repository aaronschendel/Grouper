//
//  Group.h
//  Grouper
//
//  Created by Aaron Schendel on 3/2/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Group : NSObject

@property (nonatomic, strong) NSString *groupName;
@property (nonatomic, strong) NSMutableArray *subGroups;
@property (nonatomic) int numberOfGroups;

@end
