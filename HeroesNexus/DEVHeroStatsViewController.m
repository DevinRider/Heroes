//
//  DEVHeroStatsViewController.m
//  HeroesNexus
//
//  Created by Devin on 7/1/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVHeroStatsViewController.h"
#import "DEVHero.h"

@interface DEVHeroStatsViewController ()

@end

@implementation DEVHeroStatsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithHero:(DEVHero *)hero
{
    self = [super init];
    
    self.tabBarItem.title = @"Stats";
    
    //value for the height of each UILabel
    int labelHeight = 35;
    
    UILabel *heroName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, labelHeight)];
    UILabel *heroHP = [[UILabel alloc] initWithFrame:CGRectMake(0, labelHeight, self.view.bounds.size.width, labelHeight)];
    UILabel *heroHPRegen = [[UILabel alloc] initWithFrame:CGRectMake(0, labelHeight * 2, self.view.bounds.size.width, labelHeight)];
    UILabel *heroEnergy = [[UILabel alloc] initWithFrame:CGRectMake(0, labelHeight * 3 , self.view.bounds.size.width, labelHeight)];
    UILabel *heroEnergyRegen = [[UILabel alloc] initWithFrame:CGRectMake(0, labelHeight * 4, self.view.bounds.size.width, labelHeight)];
    UILabel *heroAttack = [[UILabel alloc] initWithFrame:CGRectMake(0, labelHeight * 5, self.view.bounds.size.width, labelHeight)];
    UILabel *heroRange = [[UILabel alloc] initWithFrame:CGRectMake(0, labelHeight * 6, self.view.bounds.size.width, labelHeight)];
    
    heroName.text = hero.name;
    heroHP.text = [NSString stringWithFormat:@"HP: %@", [hero getStat:DEVHeroStatHitPoints]];
    heroHPRegen.text = [NSString stringWithFormat:@"HP Regen: %@", [hero getStat:DEVHeroStatHitPointRegen]];
    heroEnergy.text = [NSString stringWithFormat:@"Energy: %@", [hero getStat:DEVHeroStatEnergy]];
    heroEnergyRegen.text = [NSString stringWithFormat:@"Energy Regen: %@", [hero getStat:DEVHeroStatEnergyRegen]];
    heroAttack.text = [NSString stringWithFormat:@"Attack: %@", [hero getStat:DEVHeroStatAttack]];
    heroRange.text = [NSString stringWithFormat:@"Range: %@", [hero getStat:DEVHeroStatRange]];
    
    [self.view addSubview:heroName];
    [self.view addSubview:heroHP];
    [self.view addSubview:heroHPRegen];
    [self.view addSubview:heroEnergy];
    [self.view addSubview:heroEnergyRegen];
    [self.view addSubview:heroAttack];
    [self.view addSubview:heroRange];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
