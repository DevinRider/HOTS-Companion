//
//  DEVLevelSetController.m
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/29/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "DEVLevelSetController.h"
#import "DEVHero.h"
#import "DEVLevelCell.h"

@interface DEVLevelSetController ()

@end

@implementation DEVLevelSetController

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //This returns the number of potential levels
    //30 levels + the 0th level
    return 31;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEVLevelCell *cell = (DEVLevelCell *)[tableView dequeueReusableCellWithIdentifier:@"LevelCell"];
    
    if(indexPath.row == 0) {
        cell.levelLabel.text = [[NSString alloc] initWithFormat: @"Level N"];
    }
    else {
        cell.levelLabel.text = [[NSString alloc] initWithFormat: @"Level %d", indexPath.row];
    }
    
    if(indexPath.row == self.currentLevel) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    //remove checkmark (occurred when cells were reused)
    if(indexPath.row != self.currentLevel) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *newLevelDictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:indexPath.row] forKey:@"newLevel"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"levelChanged" object:self userInfo:newLevelDictionary];
    [self.navigationController popViewControllerAnimated: YES];
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
