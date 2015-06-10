//
//  NameList.h
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSPStudentList : NSObject <NSCoding>
{
    NSMutableArray *people;
}

@property (nonatomic, strong) NSString *listName;
@property (nonatomic, strong) NSMutableArray *people;

@end
