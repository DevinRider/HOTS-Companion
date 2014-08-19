//
//  HeroSelectTableViewController.m
//  HeroesAppRoundTwo
//
//  Created by Devin on 7/23/14.
//  Copyright (c) 2014 Devin Rider. All rights reserved.
//

#import "HeroSelectTableViewController.h"
#import "DEVHero.h"
#import "DEVHeroCollection.h"
#import "DEVHeroDetailViewController.h"

@interface HeroSelectTableViewController ()

@property (strong, nonatomic) IBOutlet UISearchBar *heroSearchBar;
@property (nonatomic, strong) DEVHero *selectedHero;
@property (nonatomic, strong) NSArray *heroesArray;
@property (nonatomic, strong) NSArray *searchResults;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HeroSelectTableViewController
    

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    [super viewWillAppear:animated];
    
    self.heroesArray = [[DEVHeroCollection sharedCollection] allItemsArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
     //self.clearsSelectionOnViewWillAppear = YES;
    
    self.heroSearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [self.searchDisplayController.searchResultsTableView setRowHeight:self.tableView.rowHeight];
    
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.searchResults count];
    }
    else {
        return [self.heroesArray count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEVHero *hero;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        hero = self.searchResults[indexPath.row];
    }
    else {
        hero = self.heroesArray[indexPath.row];
    }
    
    UITableViewCell *cell = (UITableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"HeroSelectCell"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HeroSelectCell"];
    }
    
    cell.textLabel.text = hero.name;
    cell.textLabel.font = [UIFont fontWithName:@"FrizQuadrataFont" size:20];
    cell.detailTextLabel.text = hero.rolesString;
    cell.imageView.image = [UIImage imageNamed:hero.imagePath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchDisplayController.searchResultsTableView) {
        self.selectedHero = self.searchResults[indexPath.row];
    }
    else {
        self.selectedHero = self.heroesArray[indexPath.row];
    }
    [self.delegate heroSelected:self.selectedHero];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DEVHeroDetailViewController *heroDetail = segue.destinationViewController;
    self.delegate = heroDetail;
}

#pragma mark - Search Functions
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"(name contains[cd] %@) OR (universe contains[cd] %@) OR (rolesString contains[cd] %@)", searchText, searchText, searchText];
   self.searchResults = [self.heroesArray filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
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

@end
