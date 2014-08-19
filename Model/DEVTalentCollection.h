//
//  DEVTalentCollection.h
//  HeroesAppRoundTwo
//
//  Created by Devin on 8/12/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVTalent.h"

@interface DEVTalentCollection : NSObject

+ (instancetype)sharedCollection;

- (DEVTalent *)getTalentWithStringName:(NSString *)name;

@end