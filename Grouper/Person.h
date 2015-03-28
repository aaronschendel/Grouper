//
//  Person.h
//  Grouper
//
//  Created by Aaron Schendel on 3/28/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *fullName;

typedef NS_ENUM(NSUInteger, Gender) {
    MALE,
    FEMALE
};

@end
