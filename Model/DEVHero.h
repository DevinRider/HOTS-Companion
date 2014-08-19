//
//  DEVHero.h
//  HeroesNexus
//
//  Created by Devin on 6/15/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DEVAbility;
@class DEVTalent;

@interface DEVHero : NSObject

//information properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSString *lore;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *rolesString;
@property (nonatomic) NSString *universe;
@property (nonatomic) NSString *imagePath;

//array to hold the talents of a hero. The array contains more arrays that represent the tiers of talents for a hero
//each sub-array contains all of the hero's talents in DEVTalents
@property (nonatomic) NSMutableArray *talentArray;

//NSIntegers to represent various rankings among heroes
@property (nonatomic) int heroHPRank;
@property (nonatomic) int heroAttackRank;
@property (nonatomic) int heroAttackSpeedRank;
@property (nonatomic) int heroDPSRank;

//abilities for the hero
//locations in array are as follows:
//0 - trait
//1 - q ability
//2 - w ability
//3 - e ability
//4 - r1 ability
//5 - r2 ability
/////////////////
//only abathur has 2 q, w, e moves so this is for him
//6-q2
//7- w2
//8- e2
@property (nonatomic) NSMutableArray *abilityArray;

@property (nonatomic) int currentLevel;

typedef enum DEVHeroStat {
    DEVHeroStatHitPoints,
    DEVHeroStatHitPointRegen,
    DEVHeroStatEnergy,
    DEVHeroStatEnergyRegen,
    DEVHeroStatAttack,
    DEVHeroStatAttackSpeed,
    DEVHeroStatRange,
    DEVHeroStatDPS
} DEVHeroStat;

typedef enum DEVHeroAbility {
    DEVHeroAbilityQ,
    DEVHeroAbilityW,
    DEVHeroAbilityE,
    DEVHeroAbilityTrait,
    DEVHeroAbilityROne,
    DEVHeroAbilityRTwo
} DEVHeroAbility;

//the designated initializer, a hero needs to be filled with stats on initialization
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
                     withAbilities:(NSArray *)abilities;

/** Better naming 
 - (NSString *)heroStatStringForStat:(DEVHeroStat)stat;
 */

- (void)setLevel:(int)level;

- (NSString *)talentDescription:(DEVTalent *)talent;

- (NSString *)abilityDescription:(DEVAbility *)ability;

- (DEVAbility *)getAbility:(DEVHeroAbility)ability;

- (NSString *)getStat:(DEVHeroStat)stat;

@end