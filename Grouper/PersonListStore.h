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
    NSMutableArray *allPersonLists;
}

- (void)setAllPersonLists:(NSArray *)newArray;

+ (PersonListStore *)sharedNameListStore;

- (void)removePersonList:(PersonList *)g;
- (void)removeAllNameLists;

- (NSMutableArray *)allPersonLists;
- (PersonList *)createPersonList;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;


@end
