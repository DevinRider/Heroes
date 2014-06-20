//
//  DEVHeroTalent.m
//  HeroesNexus
//
//  Created by Devin on 6/18/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVHeroTalent.h"

@implementation DEVHeroTalent

- (instancetype)initTalent:(NSArray *)talentArray
                  withName:(NSString *)name
{
    self = [super init];
    
    _name = name;
    _description = talentArray[0];
    
    if([talentArray count] > 1) {
        _baseDamage = [talentArray[1] integerValue];
        _damagePerLevel = [talentArray[2] integerValue];
    }
    
    return self;
}

@end
