//
//  NameListStore.h
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NameList;

@interface NameListStore : NSObject
{
    NSMutableArray *allNameLists;
}

- (void)setAllNameLists:(NSArray *)newArray;

+ (NameListStore *)sharedNameListStore;

- (void)removeNameList:(NameList *)g;
- (void)removeAllNameLists;

- (NSMutableArray *)allNameLists;
- (NameList *)createNameList;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;


@end
