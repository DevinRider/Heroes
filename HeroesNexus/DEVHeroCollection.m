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

@property (nonatomic)NSMutableDictionary *privateHeroesCollection;

@end

@implementation DEVHeroCollection

+ (instancetype)heroCollection
{
    static DEVHeroCollection *heroCollection;
    if(!heroCollection){
        heroCollection = [[self alloc] initPrivate];
    }
    return heroCollection;
}

//this method will populate the collection with all heroes from heroList.plist
- (instancetype)initPrivate
{
    self = [super init];
    _privateHeroesCollection = [[NSMutableDictionary alloc] init];
    NSString *plistHeroPath = [[NSBundle mainBundle] pathForResource:@"Hero List" ofType:@"plist"];
    NSArray *heroDict = [[NSArray alloc] initWithContentsOfFile:plistHeroPath];
    
    NSString *plistAbilPath = [[NSBundle mainBundle] pathForResource:@"Ability List" ofType:@"plist"];
    NSDictionary *abilDict = [[NSDictionary alloc] initWithContentsOfFile:plistAbilPath];
    
    if(self){
        //fill the dict with heroes
        for(NSDictionary *oneHero in heroDict){
            NSArray *oneHerosAbilities = abilDict[oneHero[@"name"]];
            
            DEVHero *hero = [[DEVHero alloc] initWithDictionary:oneHero
                                                  withAbilities:oneHerosAbilities];
            
           [_privateHeroesCollection setObject:hero forKey:hero.name];
        }
    }
    return self;
}
- (NSDictionary *)allItems
{
    return [self.privateHeroesCollection copy];
}

@end
