//
//  GroupStore.h
//  Grouper
//
//  Created by Aaron Schendel on 3/6/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Group;

@interface GroupStore : NSObject <NSCoding>
{
    NSMutableArray *allGroups;
}

- (void)setAllGroups:(NSArray *)newArray;

+ (GroupStore *)sharedGroupStore;

- (void)removeGroup:(Group *)g;
- (void)removeAllGroups;

- (NSMutableArray *)allGroups;
- (Group *)createGroup;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (void)saveChanges;
- (void)loadFromDefaults;

@end
