//
//  DEVHeroTalent.h
//  HeroesNexus
//
//  Created by Devin on 6/18/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEVTalent : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) NSString *imagePath;

@property (nonatomic) NSNumber *firstBaseDamage;
@property (nonatomic) NSNumber *firstDamagePerLevel;
@property (nonatomic) NSNumber *secondBaseDamage;
@property (nonatomic) NSNumber *secondDamagePerLevel;
@property (nonatomic) NSNumber *cooldown;

@end
