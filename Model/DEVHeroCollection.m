//
//  DEVHeroCollection.m
//  HeroesNexus
//
//  Created by Devin on 6/15/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVHeroCollection.h"
#import "DEVHero.h"


@interface DEVHeroCollection ()

@property (nonatomic) NSMutableDictionary *privateHeroesCollection;
@property (nonatomic) NSMutableArray *heroArray;

@end

@implementation DEVHeroCollection

+ (instancetype)sharedCollection
{
    static DEVHeroCollection *_sharedCollection;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedCollection = [[self alloc]initPrivate];
    });
    
    return _sharedCollection;
}


//this method will populate the collection with all heroes from heroList.plist
- (instancetype)initPrivate
{
    self = [super init];
    self.privateHeroesCollection = [NSMutableDictionary new];
    self.heroArray = [NSMutableArray new];
    NSString *plistHeroPath = [[NSBundle mainBundle] pathForResource:@"Hero List" ofType:@"plist"];
    NSArray *dictArray = [[NSArray alloc] initWithContentsOfFile:plistHeroPath];
    
    NSString *plistAbilPath = [[NSBundle mainBundle] pathForResource:@"Ability List" ofType:@"plist"];
    NSDictionary *abilDict = [[NSDictionary alloc] initWithContentsOfFile:plistAbilPath];
    
    if (self) {
        //fill the dict with heroes
        for (NSDictionary *oneHero in dictArray) {
            NSArray *oneHerosAbilities = abilDict[oneHero[@"name"]];
            
            DEVHero *hero = [[DEVHero alloc] initWithDictionary:oneHero
                                                  withAbilities:oneHerosAbilities];
        
            [self.heroArray addObject:hero];
            [self.privateHeroesCollection setObject:hero forKey:hero.name];
        }
    }
    [self setHeroStatRankings];
    return self;
}


- (NSDictionary *)allItems
{
    return [self.privateHeroesCollection copy];
}

- (NSArray *)allItemsArray
{
    return [self.heroArray copy];
}

#pragma mark - Methods for ranking heroes based on stats
//heroes will be ranked in HP, Attack Damage and DPS

- (NSArray *)getSortedArrayForStat:(DEVHeroStat)stat
{
    NSArray *sortedArray;
    sortedArray = [self.heroArray sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        //remove the commas in the stats since they mess up intValues. 1,000 = "1", while 950 = "950".
        NSString *firstString = [[(DEVHero *)a getStat:stat] stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSString *secondString = [[(DEVHero *)b getStat:stat] stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        NSNumber *first = [NSNumber numberWithFloat:[firstString floatValue]];
        NSNumber *second = [NSNumber numberWithFloat:[secondString floatValue]];
        return -[first compare:second];
    }];
    return sortedArray;
}

- (void)setHeroStatRankings
{
    NSArray *tempArray;
    //rank stats for HP...
    tempArray = [self getSortedArrayForStat:DEVHeroStatHitPoints];
    for (int rank = 0; rank < [tempArray count]; rank++) {
        ((DEVHero *)tempArray[rank]).heroHPRank = rank + 1;
    }
    //rank stats for attack...
    tempArray = [self getSortedArrayForStat:DEVHeroStatAttack];
    for (int rank = 0; rank < [tempArray count]; rank++) {
        ((DEVHero *)tempArray[rank]).heroAttackRank = rank + 1;
    }
    //rank stats for attack speed
    tempArray = [self getSortedArrayForStat:DEVHeroStatAttackSpeed];
    for (int rank = 0; rank < [tempArray count]; rank++) {
        ((DEVHero *)tempArray[rank]).heroAttackSpeedRank = rank + 1;
    }
    //rank stats for DPS
    tempArray = [self getSortedArrayForStat:DEVHeroStatDPS];
    for (int rank = 0; rank < [tempArray count]; rank++) {
        ((DEVHero *)tempArray[rank]).heroDPSRank = rank + 1;
    }
}


@end
