//
//  DEVHeroDetailViewController.m
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/23/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVHeroDetailViewController.h"
#import "DEVHero.h"
#import "HeroStatsView.h"
#import "DEVAbilityView.h"
#import "DEVTalentViewController.h"

@interface DEVHeroDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *roleImage;

@end

@implementation DEVHeroDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameLabel.text = self.selectedHero.name;
    self.nameLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:22];
    self.titleLabel.text = self.selectedHero.title;
    self.titleLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:15];
    self.roleLabel.text = self.selectedHero.rolesString;
    self.roleLabel.font =[UIFont fontWithName:@"FrizQuadrataFont" size:15];
    self.heroImage.image = [UIImage imageNamed:self.selectedHero.imagePath];
    self.loreLabel.text = [NSString stringWithFormat:@"\t%@",self.selectedHero.lore];
    [self.loreLabel sizeToFit];
    
    if([self.selectedHero.rolesString rangeOfString:@"Warrior"].location != NSNotFound) {
        self.roleImage.image = [UIImage imageNamed:@"warrior.png"];
    }
    else if([self.selectedHero.rolesString rangeOfString:@"Support"].location != NSNotFound) {
        self.roleImage.image = [UIImage imageNamed:@"support.png"];
    }
    else if([self.selectedHero.rolesString rangeOfString:@"Assassin"].location != NSNotFound) {
        self.roleImage.image = [UIImage imageNamed:@"assassin.png"];
    }
    else if([self.selectedHero.rolesString rangeOfString:@"Specialist"].location != NSNotFound) {
        self.roleImage.image = [UIImage imageNamed:@"specialist.png"];
    }
    
    if([self.selectedHero.universe isEqualToString:@"Warcraft"]) {
        self.universeImage.image = [UIImage imageNamed:@"Warcraft.png"];
    }
    else if([self.selectedHero.universe isEqualToString:@"Starcraft"]) {
        self.universeImage.image = [UIImage imageNamed:@"Starcraft.png"];
    }
    else if([self.selectedHero.universe isEqualToString:@"Diablo"]) {
        self.universeImage.image = [UIImage imageNamed:@"Diablo.png"];
    }

    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HeroSelectTableViewDelegate Methods

- (void)heroSelected:(DEVHero *)selectedHero
{
    self.selectedHero = selectedHero;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[HeroStatsView class]])
    {
        HeroStatsView *statsView = segue.destinationViewController;
        
        statsView.selectedHero = self.selectedHero;
    }
    else if([segue.destinationViewController isKindOfClass:[DEVAbilityView class]])
    {
        DEVAbilityView *abilityView = segue.destinationViewController;
        
        abilityView.selectedHero = self.selectedHero;
    }
    else if([segue.destinationViewController isKindOfClass:[DEVTalentViewController class]])
    {
        DEVTalentViewController *talentView = segue.destinationViewController;
        
        talentView.selectedHero = self.selectedHero;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row + indexPath.section == 0) {
        return 154;
    }
    else if(indexPath.section == 0 && indexPath.row == 1) {
       return 10 + (1.15 * [self heightForText:self.selectedHero.lore]);
    }
    return 44;
}

-(CGFloat)heightForText:(NSString *)text
{
    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 226, 9999)];
    textView.text = text;
    [textView sizeToFit];
    return 20 + textView.frame.size.height;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BLAH forIndexPath:indexPath];
    
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
