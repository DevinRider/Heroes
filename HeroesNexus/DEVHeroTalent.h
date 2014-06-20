//
//  DEVHeroTalent.h
//  HeroesNexus
//
//  Created by Devin on 6/18/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DEVHeroTalent : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *description;

@property (nonatomic, readonly) int baseDamage;
@property (nonatomic, readonly) int damagePerLevel;

- (instancetype)initTalent:(NSArray *)talentArray
                  withName:(NSString *)name;

@end
