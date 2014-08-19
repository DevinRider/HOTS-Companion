//
//  HeroStatsView.m
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/23/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "HeroStatsView.h"
#import "DEVHero.h"
#import "HeroSelectTableViewController.h"
#import "DEVLevelSetController.h"
#import "DEVHeroCollection.h"

@interface HeroStatsView ()

//labels for stats
@property (weak, nonatomic) IBOutlet UILabel *hitPointLabel;
@property (weak, nonatomic) IBOutlet UILabel *hitPointRegenLabel;
@property (weak, nonatomic) IBOutlet UILabel *energyLabel;
@property (weak, nonatomic) IBOutlet UILabel *energyRegenLabel;
@property (weak, nonatomic) IBOutlet UILabel *attackLabel;
@property (weak, nonatomic) IBOutlet UILabel *attackSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *dpsLabel;
@property (weak, nonatomic) IBOutlet UILabel *rangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

//images for stats


//ranking labels
@property (strong, nonatomic) IBOutlet UILabel *hitPointRankLabel;
@property (strong, nonatomic) IBOutlet UILabel *attackRankLabel;
@property (strong, nonatomic) IBOutlet UILabel *dpsRankLabel;


@end

@implementation HeroStatsView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //listen for level changes
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(levelChanged:) name:@"levelChanged" object:nil];
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"FrizQuadrataFont" size:14.0]];
    
    self.navigationItem.title = [[NSString alloc]initWithFormat:@"%@ Stats",self.selectedHero.name];
    
    self.hitPointRankLabel.text = [[NSString alloc] initWithFormat:@"Rank: %i of %lu", self.selectedHero.heroHPRank, (unsigned long)[[[DEVHeroCollection sharedCollection] allItemsArray] count]];
    self.hitPointRankLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:12.0];
    self.attackRankLabel.text = [[NSString alloc]initWithFormat:@"Rank: %i of %lu", self.selectedHero.heroAttackRank, (unsigned long)[[[DEVHeroCollection sharedCollection] allItemsArray] count]];
    self.attackRankLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:12.0];
    self.dpsRankLabel.text = [[NSString alloc]initWithFormat:@"Rank: %i of %lu", self.selectedHero.heroDPSRank, (unsigned long)[[[DEVHeroCollection sharedCollection] allItemsArray] count]];
    self.dpsRankLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:12.0];
    
    [self updateUI];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateUI
{
    self.hitPointLabel.text = [[NSString alloc] initWithFormat:@"HP: %@", [self.selectedHero getStat:DEVHeroStatHitPoints]];
    self.hitPointRegenLabel.text = [[NSString alloc] initWithFormat:@"HP Regen: %@", [self.selectedHero getStat:DEVHeroStatHitPointRegen]];
    self.energyLabel.text = [[NSString alloc] initWithFormat:@"Energy: %@", [self.selectedHero getStat:DEVHeroStatEnergy]];
    self.energyRegenLabel.text = [[NSString alloc] initWithFormat:@"Energy Regen: %@", [self.selectedHero getStat:DEVHeroStatEnergyRegen]];
    self.attackLabel.text = [[NSString alloc] initWithFormat:@"Attack: %@", [self.selectedHero getStat:DEVHeroStatAttack]];
    self.attackSpeedLabel.text = [[NSString alloc] initWithFormat:@"Attack Speed: %@", [self.selectedHero getStat:DEVHeroStatAttackSpeed]];
    self.dpsLabel.text = [[NSString alloc] initWithFormat:@"DPS: %@", [self.selectedHero getStat:DEVHeroStatDPS]];
    self.rangeLabel.text = [[NSString alloc] initWithFormat:@"Range: %@",[self.selectedHero getStat:DEVHeroStatRange]];
    
    self.levelLabel.text = [[NSString alloc] initWithFormat:@"Current Level: %d", self.selectedHero.currentLevel];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DEVLevelSetController *levelController = segue.destinationViewController;
    levelController.currentLevel = self.selectedHero.currentLevel;
}   

- (void)levelChanged:(NSNotification *)notification
{
    [self.selectedHero setLevel:[[notification.userInfo objectForKey:@"newLevel"] intValue]];
    [self updateUI];
}


//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
