//
//  NameListStore.h
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonList;

@interface PersonListStore : NSObject <NSCoding>
{
    NSMutableArray *allPersonLists;
}

- (void)setAllPersonLists:(NSArray *)newArray;

+ (PersonListStore *)sharedPersonListStore;

- (void)removePersonList:(PersonList *)g;
- (void)removeAllNameLists;

- (NSMutableArray *)allPersonLists;
- (PersonList *)createPersonList;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (void)saveChanges;
- (void)loadFromDefaults;


@end
