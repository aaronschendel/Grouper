//
//  NameList.h
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonList : NSObject

@property (nonatomic, strong) NSString *listName;
@property (nonatomic, strong) NSMutableArray *names;

@end
