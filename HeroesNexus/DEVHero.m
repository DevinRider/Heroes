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
//consider replacing with an array
@property (nonatomic, readonly) DEVAbility *qAbility;
@property (nonatomic, readonly) DEVAbility *wAbility;
@property (nonatomic, readonly) DEVAbility *eAbility;
@property (nonatomic, readonly) DEVAbility *rAbilityOne;
@property (nonatomic, readonly) DEVAbility *rAbilityTwo;
@property (nonatomic, readonly) DEVAbility *trait;


//number formatter for getting the stats
@property (nonatomic) NSNumberFormatter *formatter;



@end

@implementation DEVHero

- (instancetype)initWithDictionary:(NSDictionary *)heroDict
                     withAbilities:(NSDictionary *)abilDict
{
    self = [super init];
    _formatter = [[NSNumberFormatter alloc] init];
    [_formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [_formatter setUsesSignificantDigits:YES];
    [_formatter setMinimumSignificantDigits:1];
    
    if(self){
        //load in the info
        _name = heroDict[@"name"];
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
        _qAbility = [[DEVAbility alloc] initAbility:abilDict[@"q"]];
        _wAbility = [[DEVAbility alloc] initAbility:abilDict[@"w"]];
        _eAbility = [[DEVAbility alloc] initAbility:abilDict[@"e"]];
        _trait = [[DEVAbility alloc] initAbility:abilDict[@"trait"]];
        _rAbilityOne = [[DEVAbility alloc]initAbility:abilDict[@"r"][0]];
        _rAbilityTwo = [[DEVAbility alloc]initAbility:abilDict[@"r"][1]];
        
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
        case DEVHeroAbilityQ:
            ability = _qAbility;
            break;
        case DEVHeroAbilityW:
            ability = _wAbility;
            break;
        case DEVHeroAbilityE:
            ability = _eAbility;
            break;
        case DEVHeroAbilityTrait:
            ability = _trait;
            break;
        case DEVHeroAbilityROne:
            ability = _rAbilityOne;
            break;
        case DEVHeroAbilityRTwo:
            ability = _rAbilityTwo;
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
