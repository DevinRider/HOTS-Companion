//
//  DEVAbility.h
//  HeroesNexus
//
//  Created by Devin on 6/17/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//
//This class will hold a single ability for a hero


@interface DEVAbility : NSObject

@property (nonatomic, readonly) NSInteger cost;
@property (nonatomic, readonly) NSInteger cooldown;
@property (nonatomic, readonly) NSInteger firstBaseDamage;
@property (nonatomic, readonly) NSInteger firstDamagePerLevel;
@property (nonatomic, readonly) NSInteger secondBaseDamage;
@property (nonatomic, readonly) NSInteger secondDamagePerLevel;
@property (nonatomic, readonly) NSInteger thirdBaseDamage;
@property (nonatomic, readonly) NSInteger thirdDamagePerLevel;

@property (nonatomic, readonly) NSString *abilityDescription;
@property (nonatomic, readonly) NSString *abilityType;
@property (nonatomic, readonly) NSString *abilityName;


- (instancetype)initAbility:(NSDictionary *)abilityDict;

- (float)abilityDPS;

@end
