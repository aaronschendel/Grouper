//
//  NameListStore.h
//  ClassSplit
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSPClass;

@interface CSPClassStore : NSObject <NSCoding>
{
    NSMutableArray *allPersonLists;
}

- (void)setAllPersonLists:(NSArray *)newArray;

+ (CSPClassStore *)sharedPersonListStore;

- (void)removePersonList:(CSPClass *)g;
- (void)removeAllNameLists;

- (NSMutableArray *)allPersonLists;
- (CSPClass *)createPersonList;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (void)saveChanges;
- (void)loadFromDefaults;


@end
