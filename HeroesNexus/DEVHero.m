//
//  DEVHero.m
//  HeroesNexus
//
//  Created by Devin on 6/15/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVHero.h"
#import "DEVAbility.h"

@interface DEVHero ()

//base values for stats
@property (nonatomic, readonly) float baseHitPoints;
@property (nonatomic, readonly) float baseHitPointRegen;
@property (nonatomic, readonly) float baseEnergy;
@property (nonatomic, readonly) float baseEnergyRegen;
@property (nonatomic, readonly) float baseAttack;
@property (nonatomic, readonly) float baseAttackSpeed;
@property (nonatomic, readonly) float range;

//stat gain per level
@property (nonatomic, readonly) float hitPointsPerLevel;
@property (nonatomic, readonly) float hitPointRegenPerLevel;
@property (nonatomic, readonly) float energyPerLevel;
@property (nonatomic, readonly) float energyRegenPerLevel;
@property (nonatomic, readonly) float attackPerLevel;
@property (nonatomic, readonly) float attackSpeedPerLevel;

//abilities for the hero
//locations in array are as follows:
//0 - trait
//1 - q ability
//2 - w ability
//3 - e ability
//4 - r1 ability
//5 - r2 ability
//need to decide how to handle abathur's second set of 3 abilities (q2, w2, e2)?
@property (nonatomic, readonly) NSMutableArray *abilityArray;

//number formatter for getting the stats
@property (nonatomic) NSNumberFormatter *formatter;



@end

@implementation DEVHero

- (instancetype)initWithDictionary:(NSDictionary *)heroDict
                     withAbilities:(NSArray *)abilDict
{
    self = [super init];
    NSArray *tempAbilityArray = [[NSArray alloc] initWithArray:abilDict];
    _abilityArray = [[NSMutableArray alloc] init];
    
    _formatter = [[NSNumberFormatter alloc] init];
    [_formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [_formatter setUsesSignificantDigits:YES];
    [_formatter setMinimumSignificantDigits:1];
    
    if(self){
        //load in the info
        _name = heroDict[@"name"];
        _imagePath = [heroDict[@"name"] stringByAppendingString:@"_tile.png"];
        _lore = heroDict[@"lore"];
        _universe = heroDict[@"universe"];
        _title = heroDict[@"title"];
        _roles = heroDict[@"roles"];
        
        //load in the stats
        _baseHitPoints = [heroDict[@"baseHP"] floatValue];
        _baseHitPointRegen = [heroDict[@"baseHPRegen"] floatValue];
        _baseEnergy = [heroDict[@"baseEnergy"] floatValue];
        _baseEnergyRegen = [heroDict[@"baseEnergyRegen"] floatValue];
        _baseAttack = [heroDict[@"baseAttack"] floatValue];
        _baseAttackSpeed = [heroDict[@"baseAttackSpeed"] floatValue];
        _range = [heroDict[@"range"] floatValue];
        _hitPointsPerLevel = [heroDict[@"hitPointsPerLevel"] floatValue];
        _hitPointRegenPerLevel = [heroDict[@"hitPointRegenPerLevel"] floatValue];
        _energyPerLevel = [heroDict[@"energyPerLevel"] floatValue];
        _energyRegenPerLevel = [heroDict[@"energyRegenPerLevel"] floatValue];
        _attackPerLevel = [heroDict[@"attackPerLevel"] floatValue];
        _attackSpeedPerLevel = [heroDict[@"attackSpeedPerLevel"] floatValue];
        
        //load in the abilities
        for(NSDictionary *ability in tempAbilityArray) {
            [_abilityArray addObject:[[DEVAbility alloc] initAbility:ability]];
        }
        
        //set current level to 0
        _currentLevel = 0;
    }
    return self;
}

- (instancetype)init
{
    [NSException raise:@"No Stats"
                format:@"Heroes must be implemented with stats, use initWithDictionary..."];
    return nil;
}

- (void)setLevel:(int)level
{
    _currentLevel = level;
    NSLog(@"Level set to: %i", _currentLevel);
}

#pragma mark - Methods for retrieving stat data based on current level

- (NSString *)getStat:(DEVHeroStat)stat
{
    NSString *returnString = [NSString alloc];
    
    float statValue = 0;
    
    if(_currentLevel == 0 && stat != DEVHeroStatRange && stat != DEVHeroStatDPS){
        float statValuePerLevel = 0;
        switch (stat) {
            case DEVHeroStatHitPoints:
                statValue = _baseHitPoints;
                statValuePerLevel = _hitPointsPerLevel;
                break;
            case DEVHeroStatEnergy:
                statValue = _baseEnergy;
                statValuePerLevel = _energyPerLevel;
                break;
            case DEVHeroStatAttack:
                statValue = _baseAttack;
                statValuePerLevel = _attackPerLevel;
                break;
            case DEVHeroStatAttackSpeed:
                statValue = _baseAttackSpeed;
                statValuePerLevel = _attackSpeedPerLevel;
                break;
            case DEVHeroStatEnergyRegen:
                statValue = _baseEnergyRegen;
                statValuePerLevel = _energyRegenPerLevel;
                break;
            case DEVHeroStatHitPointRegen:
                statValue = _baseHitPointRegen;
                statValuePerLevel = _hitPointRegenPerLevel;
                break;
        }
        returnString = [returnString initWithFormat:@"%@ + %@ per level",
         [_formatter stringFromNumber:[NSNumber numberWithInt:statValue]],
         [_formatter stringFromNumber:[NSNumber numberWithFloat:statValuePerLevel]]];
        
    }
    else{
        switch (stat) {
            case DEVHeroStatHitPoints:
                statValue = _baseHitPoints + (_currentLevel * _hitPointsPerLevel);
                break;
            case DEVHeroStatEnergy:
                statValue = _baseEnergy + (_currentLevel * _energyPerLevel);
                break;
            case DEVHeroStatAttack:
                statValue = _baseAttack + (_currentLevel * _attackPerLevel);
                break;
            case DEVHeroStatAttackSpeed:
                statValue = _baseAttackSpeed + (_currentLevel * _attackSpeedPerLevel);
                break;
            case DEVHeroStatEnergyRegen:
                statValue = _baseEnergyRegen + (_currentLevel * _energyRegenPerLevel);
                break;
            case DEVHeroStatHitPointRegen:
                statValue = _baseHitPointRegen + (_currentLevel * _hitPointRegenPerLevel);
                break;
            case DEVHeroStatRange:
                statValue = _range;
                break;
            case DEVHeroStatDPS:
                statValue = (_baseAttack + (_currentLevel * _attackPerLevel)) * (_baseAttackSpeed + (_currentLevel * _attackSpeedPerLevel));
                break;
        }
        returnString = [returnString initWithFormat:@"%@", [_formatter stringFromNumber:[NSNumber numberWithFloat:statValue]]];
    }

    return returnString;
}

- (NSString *)abilityDescription:(DEVHeroAbility)abil
{
    NSString *returnString = [[NSString alloc] init];
    DEVAbility *ability = [DEVAbility alloc];
    
    switch (abil) {
        case DEVHeroAbilityTrait:
            ability = _abilityArray[0];
            break;
        case DEVHeroAbilityQ:
            ability = _abilityArray[1];
            break;
        case DEVHeroAbilityW:
            ability = _abilityArray[2];
            break;
        case DEVHeroAbilityE:
            ability = _abilityArray[3];
            break;
        case DEVHeroAbilityROne:
            ability = _abilityArray[4];
            break;
        case DEVHeroAbilityRTwo:
            ability = _abilityArray[5];
            break;
    }
    returnString = ability.abilityDescription;
    //if the string contains "###", then replace ### with the actual damage values
    if([ability.abilityDescription rangeOfString:@"###"].location != NSNotFound){
        NSString *statValue;
        if(_currentLevel != 0){
            statValue = [NSString stringWithFormat:@"%i", (ability.firstBaseDamage + (_currentLevel * ability.firstDamagePerLevel))];
        }
        else{
            statValue = [NSString stringWithFormat:@"(%i + %i per level)", ability.firstBaseDamage, ability.firstDamagePerLevel];
        }
        returnString = [returnString stringByReplacingOccurrencesOfString:@"###" withString:statValue];
    }
    
    //if the string contains "$$$", then replace $$$ with the actual (second) damage values
    if([ability.abilityDescription rangeOfString:@"$$$"].location != NSNotFound){
        NSString *statValue;
        if(_currentLevel != 0){
            statValue = [NSString stringWithFormat:@"%i", (ability.secondBaseDamage + (_currentLevel * ability.secondDamagePerLevel))];
        }
        else{
            statValue = [NSString stringWithFormat:@"(%i + %i per level)", ability.secondBaseDamage, ability.secondDamagePerLevel];
        }
        returnString = [returnString stringByReplacingOccurrencesOfString:@"$$$" withString:statValue];
    }
    
    //if it contains "@@@" then replace @@@ with the actual (third) damage values
    if([ability.abilityDescription rangeOfString:@"@@@"].location != NSNotFound){
        NSString *statValue;
        if(_currentLevel != 0){
            statValue = [NSString stringWithFormat:@"%i", (ability.thirdBaseDamage + (_currentLevel * ability.thirdDamagePerLevel))];
        }
        else{
            statValue = [NSString stringWithFormat:@"(%i + %i per level)", ability.thirdBaseDamage, ability.thirdDamagePerLevel];
        }
        returnString = [returnString stringByReplacingOccurrencesOfString:@"@@@" withString:statValue];
    }
    return returnString;
}

@end
