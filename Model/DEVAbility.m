//
//  DEVAbility.m
//  HeroesNexus
//
//  Created by Devin on 6/17/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVAbility.h"

@implementation DEVAbility

- (instancetype)initAbility:(NSDictionary *)abilityDict
{
    self = [super init];
    if(self) {
        _abilityName = abilityDict[@"name"];
        _abilityDescription = abilityDict[@"description"];
        _abilityType = abilityDict[@"type"];
        
        _cost = [abilityDict[@"cost"] integerValue];
        _cooldown = [abilityDict[@"cooldown"] integerValue];
        if(abilityDict[@"firstBaseDamage"] != nil) {
            _firstBaseDamage = [abilityDict[@"firstBaseDamage"] integerValue];
        }
        if(abilityDict[@"firstDamagePerLevel"] != nil) {
            _firstDamagePerLevel = [abilityDict[@"firstDamagePerLevel"] integerValue];
        }
        if(abilityDict[@"secondBaseDamage"] != nil) {
            _secondBaseDamage = [abilityDict[@"secondBaseDamage"] integerValue];
        }
        if(abilityDict[@"secondDamagePerLevel"] != nil) {
            _secondDamagePerLevel = [abilityDict[@"secondDamagePerLevel"] integerValue];
        }
        if(abilityDict[@"thirdBaseDamage"] != nil) {
            _thirdBaseDamage = [abilityDict[@"thirdBaseDamage"] integerValue];
        }
        if(abilityDict[@"thirdDamagePerLevel"] != nil) {
            _thirdDamagePerLevel = [abilityDict[@"thirdDamagePerLevel"] integerValue];
        }
    }
    return self;
}

- (float)abilityDPS
{
    NSLog(@"Ability DPS not yet implemented!");
    return 0;
}

@end
