//
//  DEVHeroCollection.h
//  HeroesNexus
//
//  Created by Devin on 6/15/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEVHeroCollection : NSObject

+ (instancetype)sharedCollection;
//+ (instancetype)heroCollection;

- (NSDictionary *)allItems;

- (NSArray *)allItemsArray;

@end
