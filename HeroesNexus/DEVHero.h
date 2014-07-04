//
//  DEVHero.h
//  HeroesNexus
//
//  Created by Devin on 6/15/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DEVAbility;

@interface DEVHero : NSObject

//information properties
@property (nonatomic, strong) NSString *name;
@property (nonatomic, readonly) NSString *lore;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSArray *roles;
@property (nonatomic, readonly) NSString *universe;
@property (nonatomic, readonly) NSString *imagePath;

@property (nonatomic) int currentLevel;

typedef enum DEVHeroStat{
    DEVHeroStatHitPoints,
    DEVHeroStatHitPointRegen,
    DEVHeroStatEnergy,
    DEVHeroStatEnergyRegen,
    DEVHeroStatAttack,
    DEVHeroStatAttackSpeed,
    DEVHeroStatRange,
    DEVHeroStatDPS
} DEVHeroStat;

typedef enum DEVHeroAbility{
    DEVHeroAbilityQ,
    DEVHeroAbilityW,
    DEVHeroAbilityE,
    DEVHeroAbilityTrait,
    DEVHeroAbilityROne,
    DEVHeroAbilityRTwo
} DEVHeroAbility;


//the designated initializer, a hero needs to be filled with stats on initialization
- (instancetype)initWithDictionary:(NSDictionary *)heroDict
                     withAbilities:(NSArray *)abilDict;

//this will throw an exception, use the above init
- (instancetype)init;

- (void)setLevel:(int)level;

- (NSString *)abilityDescription:(DEVHeroAbility)ability;

- (NSString *)getStat:(DEVHeroStat)stat;

@end