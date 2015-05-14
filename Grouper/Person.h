//
//  Person.h
//  Grouper
//
//  Created by Aaron Schendel on 3/28/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject <NSCoding>

typedef NS_ENUM(NSUInteger, Gender) {
    UNDEFINED,
    MALE,
    FEMALE
};

- (id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName gender:(Gender)aGender;

@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic) Gender gender;


@end