//
//  DEVHeroLoreViewController.m
//  HeroesNexus
//
//  Created by Devin on 6/30/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVHeroLoreViewController.h"
#import "DEVHero.h"

@interface DEVHeroLoreViewController ()

@end

@implementation DEVHeroLoreViewController

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
    
    self.tabBarItem.title = @"Lore";
    
    UILabel *heroName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 70)];
    UILabel *heroLore = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, self.view.bounds.size.width, 300)];
    heroName.text = hero.name;
    heroLore.text = hero.lore;
    heroLore.lineBreakMode = NSLineBreakByCharWrapping;
    
    UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 61, 127)];
    picView.image = [UIImage imageNamed:hero.imagePath];
    
    [self.view addSubview:picView];
    [self.view addSubview:heroName];
    [self.view addSubview:heroLore];
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
