//
//  DEVAbility.h
//  HeroesNexus
//
//  Created by Devin on 6/17/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

//This class will hold a single ability for a hero

#import <Foundation/Foundation.h>

@interface DEVAbility : NSObject

@property (nonatomic, readonly) int cost;
@property (nonatomic, readonly) int cooldown;
@property (nonatomic, readonly) int firstBaseDamage;
@property (nonatomic, readonly) int firstDamagePerLevel;
@property (nonatomic, readonly) int secondBaseDamage;
@property (nonatomic, readonly) int secondDamagePerLevel;
@property (nonatomic, readonly) int thirdBaseDamage;
@property (nonatomic, readonly) int thirdDamagePerLevel;

@property (nonatomic, readonly) NSString *abilityDescription;
@property (nonatomic, readonly) NSString *abilityType;
@property (nonatomic, readonly) NSString *abilityName;


- (instancetype)initAbility:(NSDictionary *)abilityDict;

- (float)abilityDPS;

@end
