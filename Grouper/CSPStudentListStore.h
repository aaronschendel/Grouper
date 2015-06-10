//
//  NameListStore.h
//  Grouper
//
//  Created by Aaron Schendel on 3/17/15.
//  Copyright (c) 2015 Aaron. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CSPStudentList;

@interface CSPStudentListStore : NSObject <NSCoding>
{
    NSMutableArray *allPersonLists;
}

- (void)setAllPersonLists:(NSArray *)newArray;

+ (CSPStudentListStore *)sharedPersonListStore;

- (void)removePersonList:(CSPStudentList *)g;
- (void)removeAllNameLists;

- (NSMutableArray *)allPersonLists;
- (CSPStudentList *)createPersonList;
- (void)moveItemAtIndex:(int)from
                toIndex:(int)to;

- (void)saveChanges;
- (void)loadFromDefaults;


@end
