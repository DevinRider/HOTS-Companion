//
//  DEVTalentCollection.m
//  HeroesAppRoundTwo
//
//  Created by Devin on 8/12/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVTalentCollection.h"

@interface DEVTalentCollection ()

@property (nonatomic) NSDictionary *privateTalentCollection;

@end

@implementation DEVTalentCollection

+ (instancetype)sharedCollection
{
    static DEVTalentCollection *talentCollection;
    if(!talentCollection) {
        talentCollection = [[self alloc] initPrivate];
    }
    return talentCollection;
}

- (instancetype)initPrivate
{
    self = [super init];
    
    NSString *pathForTalentPList = [[NSBundle mainBundle] pathForResource:@"Talents List" ofType:@"plist"];
    
    self.privateTalentCollection = [[NSDictionary alloc]initWithContentsOfFile:pathForTalentPList];
    
    return self;
}

- (DEVTalent *)getTalentWithStringName:(NSString *)name
{
    NSDictionary *talentDictionary = self.privateTalentCollection[name];
    
    if(talentDictionary == nil) {
        NSLog(@"Talent: \"%@\" not found...", name);
        return nil;
    }
    
    DEVTalent *returningTalent = [DEVTalent alloc];
    
    if ([name rangeOfString:@"("].location != NSNotFound) {
        NSString *regExpression = @"\\(.*\\)";
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExpression options:NSRegularExpressionCaseInsensitive error:nil];
        
        name = [regex stringByReplacingMatchesInString:name options:0 range:NSMakeRange(0, [name length]) withTemplate:@""];
    }
    returningTalent.name = name;
    returningTalent.imagePath = talentDictionary[@"imagePath"];
    returningTalent.description = talentDictionary[@"description"];
    returningTalent.cooldown = talentDictionary[@"cooldown"];
    returningTalent.firstBaseDamage = talentDictionary[@"firstBaseDamage"];
    returningTalent.firstDamagePerLevel = talentDictionary[@"firstDamagePerLevel"];
    returningTalent.secondBaseDamage = talentDictionary[@"secondBaseDamage"];
    returningTalent.secondDamagePerLevel = talentDictionary[@"secondDamagePerLevel"];

    
    return returningTalent;
}

@end
