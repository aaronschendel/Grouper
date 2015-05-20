//
//  Person.m
//  Grouper
//
//  Created by Aaron Schendel on 3/28/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import "Person.h"

@implementation Person

@synthesize lastName, firstName, gender;


- (id)initWithFirstName:(NSString *)aFirstName lastName:(NSString *)aLastName emailAddress:(NSString *)anEmailAddress gender:(Gender)aGender {
    
    self = [self init];
    
    
        self.lastName = aLastName;
        self.firstName = aFirstName;
        self.gender = aGender;
        self.emailAddress = anEmailAddress;
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
    
        self.lastName = [aDecoder decodeObjectForKey:@"lastName"];
        self.firstName = [aDecoder decodeObjectForKey:@"firstName"];
        self.emailAddress = [aDecoder decodeObjectForKey:@"emailAddress"];
        self.gender = [aDecoder decodeIntForKey:@"gender"];
        
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.lastName forKey:@"lastName"];
    [aCoder encodeObject:self.firstName forKey:@"firstName"];
    [aCoder encodeObject:self.emailAddress forKey:@"emailAddress"];
    [aCoder encodeInt:self.gender forKey:@"gender"];
}



@end
