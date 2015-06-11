//
//  GroupStore.h
//  ClassSplit
//
//  Created by Aaron Schendel on 3/6/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSPGroup;

@interface CSPGroupStore : NSObject <NSCoding>
{
    NSMutableArray *allGroups;
}

- (void)setAllGroups:(NSArray *)newArray;

+ (CSPGroupStore *)sharedGroupStore;

- (void)removeGroup:(CSPGroup *)g;
- (void)removeAllGroups;

- (NSMutableArray *)allGroups;
- (CSPGroup *)createGroup;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (void)saveChanges;
- (void)loadFromDefaults;

@end
