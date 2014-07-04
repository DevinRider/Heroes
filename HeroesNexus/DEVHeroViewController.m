//
//  DEVHeroViewController.m
//  HeroesNexus
//
//  Created by Devin on 7/1/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

//need to add in a navigation controller and a tab controller at the bottom, really all that this class will handle


#import "DEVHeroViewController.h"
#import "DEVHeroLoreViewController.h"
#import "DEVHeroStatsViewController.h"

@interface DEVHeroViewController ()

@property DEVHero *hero;

@end

@implementation DEVHeroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithHero: (DEVHero *)hero
{
    self = [super init];
    if(self) {
         _hero = hero;
        DEVHeroLoreViewController *heroLore = [[DEVHeroLoreViewController alloc] initWithHero:_hero];
        DEVHeroStatsViewController *heroStats = [[DEVHeroStatsViewController alloc] initWithHero:hero];
        
        UITabBarController *heroTabBarController = [[UITabBarController alloc] init];
        heroTabBarController.viewControllers = @[heroLore,heroStats];
        
        self.view.window.rootViewController = heroTabBarController;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    la.text = @"BLAH";
    [self.view addSubview:la];
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
