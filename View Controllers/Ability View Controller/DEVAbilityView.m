//
//  DEVAbilityView.m
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/28/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVAbilityView.h"
#import "DEVAbility.h"
#import "DEVHero.h"
#import "DEVSingleHeroAbilityCell.h"
#import "DEVLevelSetController.h"

@interface DEVAbilityView ()

@property BOOL abathurAbilitiesFormat;

@end

@implementation DEVAbilityView

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
    self.abathurAbilitiesFormat = false;
    
    //listen for a change in level
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(levelChanged:) name:@"levelChanged" object:nil];
    
    //Abathur is a princess and needs to have his very own format for abilities
    //he has no standard E move, one R move and a second set of Q,W,E moves for when he is attached to someone with his Q move
    //what a great guy.
    if([self.selectedHero.name isEqualToString:@"Abathur"]) {
        self.abathurAbilitiesFormat = true;
    }
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"FrizQuadrataFont" size:15.0]];
    
    self.navigationItem.title = [[NSString alloc]initWithFormat:@"%@ Abilities",self.selectedHero.name];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.abathurAbilitiesFormat) {
        return [self.selectedHero.abilityArray count];
    }
    else {
        return [self.selectedHero.abilityArray count] - 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if(section == 4 && !self.abathurAbilitiesFormat) {
        return 2;
    }
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(self.abathurAbilitiesFormat) {
        switch (section) {
            case 0:
                return @"Trait";
                break;
            case 1:
                return @"Q";
                break;
            case 2:
                return @"W";
                break;
            case 3:
                return @"R";
                break;
            case 4:
                return @"Q";
                break;
            case 5:
                return @"W";
                break;
            case 6:
                return @"E";
                break;
        }
    }
    else {
        switch (section) {
            case 0:
                return @"Trait";
                break;
            case 1:
                return @"Q";
                break;
            case 2:
                return @"W";
                break;
            case 3:
                return @"E";
                break;
            case 4:
                return @"R";
                break;
        }
    }
    return @"Null";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEVSingleHeroAbilityCell *cell = (DEVSingleHeroAbilityCell *)[tableView dequeueReusableCellWithIdentifier:@"SingleAbilityCell"];
    
    if(cell == nil) {
        cell = [[DEVSingleHeroAbilityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SingleAbilityCell"];
    }
    
    DEVAbility *ability = self.selectedHero.abilityArray[indexPath.section + indexPath.row];
    
    cell.nameLabel.text = ability.abilityName;
    cell.costLabel.text = [[NSString alloc] initWithFormat:@"Cost: %li", (long)ability.cost];
    
    cell.typeLabel.text = [[NSString alloc] initWithFormat:@"Type: %@", ability.abilityType];
    cell.cooldownLabel.text = [[NSString alloc] initWithFormat:@"Cooldown: %li seconds", (long)ability.cooldown];
    
    cell.descriptionLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:14];
    cell.descriptionLabel.text = [self.selectedHero abilityDescription:ability];
    [cell.descriptionLabel sizeToFit];
    
    NSString *abilityIconImagePath = [[NSString alloc] initWithFormat:@"%@.png", ability.abilityName];
    cell.abilityIconImage.image = [UIImage imageNamed:abilityIconImagePath];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEVAbility *ability = self.selectedHero.abilityArray[indexPath.section + indexPath.row];
    float totalCellHeight;
    
    totalCellHeight += [self heightForText:[self.selectedHero abilityDescription:ability]];
    totalCellHeight += [self heightForText:[[NSString alloc] initWithFormat:@"Cost: %d", ability.cost]];
    totalCellHeight += [self heightForText:[[NSString alloc] initWithFormat:@"Type: %@", ability.abilityType]];
    totalCellHeight += [self heightForText:[[NSString alloc] initWithFormat:@"Cooldown: %d seconds", ability.cooldown]];
    //to account for difference in font sizes, add 40
    //also adds a bit of padding between cells this way
    //add 11 to that to account for the "bar" separating things
    totalCellHeight += 51;
    
    if(self.abathurAbilitiesFormat && indexPath.row + indexPath.section == 2) {
        totalCellHeight += 30;
    }
    
    return totalCellHeight;
}

-(CGFloat)heightForText:(NSString *)text
{
    float height;
    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 226, 9999)];
    textView.text = text;
    [textView sizeToFit];
    height = textView.frame.size.height;
    //if the size is rather large, make it a bit bigger to account for differences in font size
    if(height > 70) {
        height *= 1.35;
    }
    return height;
}

- (void)levelChanged:(NSNotification *)notification
{
    [self.selectedHero setLevel:[[notification.userInfo objectForKey:@"newLevel"] intValue]];
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DEVLevelSetController *levelController = segue.destinationViewController;
    levelController.currentLevel = self.selectedHero.currentLevel;
}

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
