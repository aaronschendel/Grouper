//
//  NameListStore.h
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonList;

@interface PersonListStore : NSObject
{
    NSMutableArray *allNameLists;
}

- (void)setAllNameLists:(NSArray *)newArray;

+ (PersonListStore *)sharedNameListStore;

- (void)removeNameList:(PersonList *)g;
- (void)removeAllNameLists;

- (NSMutableArray *)allNameLists;
- (PersonList *)createNameList;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;


@end
