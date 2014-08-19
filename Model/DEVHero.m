//
//  DEVHero.m
//  HeroesNexus
//
//  Created by Devin on 6/15/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVHero.h"
#import "DEVAbility.h"
#import "DEVTalentCollection.h"

@interface DEVHero ()

@property (nonatomic) NSArray *roles;

//base values for stats
@property (nonatomic) float baseHitPoints;
@property (nonatomic) float baseHitPointRegen;
@property (nonatomic) float baseEnergy;
@property (nonatomic) float baseEnergyRegen;
@property (nonatomic) float baseAttack;
@property (nonatomic) float baseAttackSpeed;
@property (nonatomic) float range;

//stat gain per level
@property (nonatomic) float hitPointsPerLevel;
@property (nonatomic) float hitPointRegenPerLevel;
@property (nonatomic) float energyPerLevel;
@property (nonatomic) float energyRegenPerLevel;
@property (nonatomic) float attackPerLevel;
@property (nonatomic) float attackSpeedPerLevel;



@end

@implementation DEVHero

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
                     withAbilities:(NSArray *)abilities
{
    self = [super init];
    self.abilityArray = [NSMutableArray new];
    self.talentArray = [NSMutableArray new];
    
    if(self) {
        //load in the info
        self.name = dictionary[@"name"];
        
        self.imagePath = [dictionary[@"name"] stringByAppendingString:@"_profile.png"];
        
        self.lore = dictionary[@"lore"];
        self.universe = dictionary[@"universe"];
        self.title = dictionary[@"title"];
        self.roles = dictionary[@"roles"];
        self.rolesString = [[NSString alloc] initWithFormat:@"%@, %@", self.roles[0], self.roles[1]];
        
        //load in the stats
        self.baseHitPoints = [dictionary[@"baseHP"] floatValue];
        self.baseHitPointRegen = [dictionary[@"baseHPRegen"] floatValue];
        self.baseEnergy = [dictionary[@"baseEnergy"] floatValue];
        self.baseEnergyRegen = [dictionary[@"baseEnergyRegen"] floatValue];
        self.baseAttack = [dictionary[@"baseAttack"] floatValue];
        self.baseAttackSpeed = [dictionary[@"baseAttackSpeed"] floatValue];
        self.range = [dictionary[@"range"] floatValue];
        self.hitPointsPerLevel = [dictionary[@"hitPointsPerLevel"] floatValue];
        self.hitPointRegenPerLevel = [dictionary[@"hitPointRegenPerLevel"] floatValue];
        self.energyPerLevel = [dictionary[@"energyPerLevel"] floatValue];
        self.energyRegenPerLevel = [dictionary[@"energyRegenPerLevel"] floatValue];
        self.attackPerLevel = [dictionary[@"attackPerLevel"] floatValue];
        self.attackSpeedPerLevel = [dictionary[@"attackSpeedPerLevel"] floatValue];
        
        //load in the abilities
        for(NSDictionary *ability in abilities) {
            [self.abilityArray addObject:[[DEVAbility alloc] initAbility:ability]];
        }
        
        //load in the talents
        NSArray *talentArrayWithStrings = dictionary[@"talents"];
        int talentTierInt = 0;
        for (NSArray *singleTier in talentArrayWithStrings) {
            NSMutableArray *talentTierArray = [NSMutableArray new];
            for (NSString *talentName in singleTier) {
                if(talentTierInt != 3) {
                    DEVTalent *talentToBeAdded = [[DEVTalentCollection sharedCollection] getTalentWithStringName:talentName];
                    if(talentToBeAdded != nil) {
                        [talentTierArray addObject:talentToBeAdded];
                    }
                }
            }
            talentTierInt++;
            [self.talentArray addObject:talentTierArray];
        }
        
        //set current level to 1
        self.currentLevel = 1;
    }
    return self;
}

- (void)setLevel:(int)level
{
    self.currentLevel = level;
}

#pragma mark - Methods for retrieving stat data based on current level

- (NSString *)getStat:(DEVHeroStat)stat
{
    NSString *returnString = [NSString alloc];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setUsesSignificantDigits:YES];
    [formatter setMinimumSignificantDigits:1];
    [formatter setMaximumSignificantDigits:4];
    
    float statValue = 0;
    
    if(self.currentLevel == 0 && stat != DEVHeroStatRange && stat != DEVHeroStatDPS) {
        float statValuePerLevel = 0;
        switch (stat) {
            case DEVHeroStatHitPoints:
                statValue = self.baseHitPoints;
                statValuePerLevel = self.hitPointsPerLevel;
                break;
            case DEVHeroStatEnergy:
                statValue = self.baseEnergy;
                statValuePerLevel = self.energyPerLevel;
                break;
            case DEVHeroStatAttack:
                statValue = self.baseAttack;
                statValuePerLevel = self.attackPerLevel;
                break;
            case DEVHeroStatAttackSpeed:
                statValue = self.baseAttackSpeed;
                statValuePerLevel = self.attackSpeedPerLevel;
                break;
            case DEVHeroStatEnergyRegen:
                statValue = self.baseEnergyRegen;
                statValuePerLevel = self.energyRegenPerLevel;
                break;
            case DEVHeroStatHitPointRegen:
                statValue = self.baseHitPointRegen;
                statValuePerLevel = self.hitPointRegenPerLevel;
                break;
        }
        returnString = [returnString initWithFormat:@"%@ + %@ per level",
        [formatter stringFromNumber:[NSNumber numberWithInt:statValue]],
        [formatter stringFromNumber:[NSNumber numberWithFloat:statValuePerLevel]]];
        
    }
    else{
        switch (stat) {
            case DEVHeroStatHitPoints:
                statValue = self.baseHitPoints + (self.currentLevel * self.hitPointsPerLevel);
                break;
            case DEVHeroStatEnergy:
                statValue = self.baseEnergy + (self.currentLevel * self.energyPerLevel);
                break;
            case DEVHeroStatAttack:
                statValue = self.baseAttack + (self.currentLevel * self.attackPerLevel);
                break;
            case DEVHeroStatAttackSpeed:
                statValue = self.baseAttackSpeed + (self.currentLevel * self.attackSpeedPerLevel);
                break;
            case DEVHeroStatEnergyRegen:
                statValue = self.baseEnergyRegen + (self.currentLevel * self.energyRegenPerLevel);
                break;
            case DEVHeroStatHitPointRegen:
                statValue = self.baseHitPointRegen + (self.currentLevel * self.hitPointRegenPerLevel);
                break;
            case DEVHeroStatRange:
                if(self.range == 1) {
                    return @"Melee";
                }
                else {
                    statValue = self.range;
                }
                break;
            case DEVHeroStatDPS:
                statValue = (self.baseAttack + (self.currentLevel * self.attackPerLevel)) / (self.baseAttackSpeed + (self.currentLevel * self.attackSpeedPerLevel));
                break;
        }
        returnString = [formatter stringFromNumber:[NSNumber numberWithFloat:statValue]];
    }

    return returnString;
}

- (NSString *)talentDescription:(DEVTalent *)talent
{
    NSString *returnString = talent.description;
    if (talent.firstDamagePerLevel != nil) {
        NSString *statValue = [NSString new];
        if(self.currentLevel != 0) {
            statValue = [NSString stringWithFormat:@"%d", ([talent.firstBaseDamage intValue] + (self.currentLevel * [talent.firstDamagePerLevel intValue]))];
        }
        else {
            statValue = [NSString stringWithFormat:@"(%@ + %@ per level)", talent.firstBaseDamage, talent.firstDamagePerLevel];
        }
        returnString = [returnString stringByReplacingOccurrencesOfString:@"###" withString:statValue];
        
        if([returnString rangeOfString:@"@@@"].location != NSNotFound) {
            if(self.currentLevel != 0) {
                statValue = [NSString stringWithFormat:@"%d", ([talent.secondBaseDamage intValue] + (self.currentLevel * [talent.secondDamagePerLevel intValue]))];
            }
            else {
                statValue = [NSString stringWithFormat:@"(%@ + %@ per level)", talent.secondBaseDamage, talent.secondDamagePerLevel];
            }
            returnString = [returnString stringByReplacingOccurrencesOfString:@"@@@" withString:statValue];
        }
    }
    
    return returnString;
}

- (NSString *)abilityDescription:(DEVAbility *)ability
{
    NSString *returnString = [NSString new];
    
    returnString = ability.abilityDescription;
    //if the string contains "###", then replace ### with the actual damage values
    if([ability.abilityDescription rangeOfString:@"###"].location != NSNotFound){
        NSString *statValue;
        if(self.currentLevel != 0) {
            statValue = [NSString stringWithFormat:@"%d", (ability.firstBaseDamage + (self.currentLevel * ability.firstDamagePerLevel))];
        }
        else {
            statValue = [NSString stringWithFormat:@"(%d + %d per level)", ability.firstBaseDamage, ability.firstDamagePerLevel];
        }
        returnString = [returnString stringByReplacingOccurrencesOfString:@"###" withString:statValue];
    }
    
    //if the string contains "$$$", then replace $$$ with the actual (second) damage values
    if([ability.abilityDescription rangeOfString:@"$$$"].location != NSNotFound){
        NSString *statValue;
        if(self.currentLevel != 0) {
            statValue = [NSString stringWithFormat:@"%d", (ability.secondBaseDamage + (self.currentLevel * ability.secondDamagePerLevel))];
        }
        else {
            statValue = [NSString stringWithFormat:@"(%d + %d per level)", ability.secondBaseDamage, ability.secondDamagePerLevel];
        }
        returnString = [returnString stringByReplacingOccurrencesOfString:@"$$$" withString:statValue];
    }
    
    //if it contains "@@@" then replace @@@ with the actual (third) damage values
    if([ability.abilityDescription rangeOfString:@"@@@"].location != NSNotFound){
        NSString *statValue;
        if(self.currentLevel != 0) {
            statValue = [NSString stringWithFormat:@"%i", (ability.thirdBaseDamage + (self.currentLevel * ability.thirdDamagePerLevel))];
        }
        else {
            statValue = [NSString stringWithFormat:@"(%d + %d per level)", ability.thirdBaseDamage, ability.thirdDamagePerLevel];
        }
        returnString = [returnString stringByReplacingOccurrencesOfString:@"@@@" withString:statValue];
    }
    return returnString;
}

- (DEVAbility *)getAbility:(DEVHeroAbility)ability
{
    switch (ability) {
        case DEVHeroAbilityTrait:
            return self.abilityArray[0];
            break;
        case DEVHeroAbilityQ:
            return self.abilityArray[1];
            break;
        case DEVHeroAbilityW:
            return self.abilityArray[2];
            break;
        case DEVHeroAbilityE:
            return self.abilityArray[3];
            break;
        case DEVHeroAbilityROne:
            return self.abilityArray[4];
            break;
        case DEVHeroAbilityRTwo:
            return self.abilityArray[5];
            break;
    }
}

@end
