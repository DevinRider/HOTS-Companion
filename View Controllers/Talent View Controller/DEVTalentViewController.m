//
//  DEVTalentViewController.m
//  HeroesAppRoundTwo
//
//  Created by Devin on 8/13/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVTalentViewController.h"
#import "DEVHero.h"
#import "DEVTalent.h"
#import "DEVTalentHeaderCell.h"
#import "DEVTalentInfoCell.h"
#import "DEVLevelSetController.h"
#import "DEVAbility.h"

@interface DEVTalentViewController ()

@property (nonatomic) NSMutableArray *booleanArrayForExpandedSections;

@end

@implementation DEVTalentViewController

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
    self.booleanArrayForExpandedSections = [NSMutableArray new];
    for (int i = 0; i < 7; i++) {
        [self.booleanArrayForExpandedSections addObject:[NSNumber numberWithBool:YES]];
    }
    
    //listen for a change in level
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(levelChanged:) name:@"levelChanged" object:nil];
    
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
    // Return the number of sections.
    return [self.selectedHero.talentArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if([self.booleanArrayForExpandedSections[section] boolValue]) {
        return 1;
    }
    else if (section == 3) {
        if ([self.selectedHero.name isEqualToString:@"Abathur"]) {
            return 2;
        }
        else {
            return 3;
        }
    }
    else {
        return [self.selectedHero.talentArray[section] count] + 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        DEVTalentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DEVTalentHeaderCell"];
        if(!cell) {
            UINib *header = [UINib nibWithNibName:@"DEVTalentHeaderCell" bundle:nil];
            [tableView registerNib:header
            forCellReuseIdentifier:@"DEVTalentHeaderCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"DEVTalentHeaderCell"];
        }
        cell.tierLabel.text = [NSString stringWithFormat:@"Tier %ld", (long)indexPath.section];
        if([self.booleanArrayForExpandedSections[indexPath.section] boolValue]) {
            cell.expansionIndicator.image = [UIImage imageNamed:@"arrow-closed.png"];
        }
        else {
            cell.expansionIndicator.image = [UIImage imageNamed:@"arrow-open.png"];
        }
        return cell;
    }
    
    else {
        DEVTalentInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"talentInfoCell" forIndexPath:indexPath];
        
        if(cell == nil) {
            cell = [[DEVTalentInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:@"talentInfoCell"];
        }
        
        if (indexPath.section == 3) {
            DEVAbility *heroicAbility;
            if ([self.selectedHero.name isEqualToString:@"Abathur"]) {
                heroicAbility = self.selectedHero.abilityArray[3];
            }
            else {
                heroicAbility = self.selectedHero.abilityArray[3+indexPath.row];
            }
            cell.nameLabel.text = heroicAbility.abilityName;
            
            cell.descriptionLabel.text = [self.selectedHero abilityDescription:heroicAbility];
            cell.cooldownLabel.text = [NSString stringWithFormat:@"Cooldown: %ld seconds", (long)heroicAbility.cooldown];
            NSString *abilityIconImagePath = [[NSString alloc] initWithFormat:@"%@.png", heroicAbility.abilityName];
            cell.image.image = [UIImage imageNamed:abilityIconImagePath];
        }
        else {
            DEVTalent *currentTalent = self.selectedHero.talentArray[indexPath.section][indexPath.row-1];
            cell.nameLabel.text = currentTalent.name;
            if(currentTalent.cooldown != nil) {
                cell.cooldownLabel.text = [NSString stringWithFormat:@"Cooldown: %@ seconds", currentTalent.cooldown];
            }
            else {
                cell.cooldownLabel.text = @"";
            }
            cell.descriptionLabel.text = [self.selectedHero talentDescription:currentTalent];
            [cell.descriptionLabel sizeToFit];
            cell.image.image = [UIImage imageNamed:currentTalent.imagePath];
        }
        cell.nameLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:17.0];
        cell.cooldownLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:13.0];
        return cell;
    }
    // Configure the cell...
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        if([self.booleanArrayForExpandedSections[indexPath.section] boolValue]) {
            [self.booleanArrayForExpandedSections replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:NO]];
        }
        else {
            [self.booleanArrayForExpandedSections replaceObjectAtIndex:indexPath.section withObject:[NSNumber numberWithBool:YES]];
        }
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Passing information to other VC's
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DEVLevelSetController *levelController = segue.destinationViewController;
    levelController.currentLevel = self.selectedHero.currentLevel;
}

#pragma mark - Notification Methods

- (void)levelChanged:(NSNotification *)notification
{
    [self.selectedHero setLevel:[[notification.userInfo objectForKey:@"newLevel"] intValue]];
    [self.tableView reloadData];
}

#pragma mark - Methods to deal with cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != 0 && indexPath.section != 3) {
        DEVTalent *talent = self.selectedHero.talentArray[indexPath.section][indexPath.row-1];
        float totalCellHeight;
        
        totalCellHeight += [self heightForText:[self.selectedHero talentDescription:talent]];
        
        totalCellHeight += [self heightForText:[[NSString alloc] initWithFormat:@"Cooldown: %@", talent.cooldown]];
        
        //to account for difference in font sizes, add 40
        //also adds a bit of padding between cells this way
        //add 11 to that to account for the "bar" separating things
        totalCellHeight += 51;
        
        
        return totalCellHeight;
    }
    else if (indexPath.row != 0) {
        DEVAbility *heroicAbility = self.selectedHero.abilityArray[3+indexPath.row];
        float totalCellHeight;
        totalCellHeight += [self heightForText:[self.selectedHero abilityDescription:heroicAbility]];
        
        totalCellHeight += [self heightForText:heroicAbility.abilityName];
        
        totalCellHeight += [self heightForText:[NSString stringWithFormat:@"Cooldown: %i", heroicAbility.cooldown]];
        
        totalCellHeight += 31;
        
        return totalCellHeight;
    }
    return 35;
}

-(CGFloat)heightForText:(NSString *)text
{
    float height;
    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 249, 9999)];
    textView.text = text;
    [textView sizeToFit];
    height = textView.frame.size.height;
    //if the size is rather large, make it a bit bigger to account for differences in font size
    if(height > 43) {
        height *= 1.6;
    }
    else if (height > 70) {
        height *= 1.95;
    }
    return height;
}

@end
