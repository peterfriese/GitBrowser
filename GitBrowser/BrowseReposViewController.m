//
//  BrowseReposViewController.m
//  GitBrowser
//
//  Created by Peter Friese on 20.03.12.
//  Copyright (c) 2012 peterfriese.de. All rights reserved.
//

#import "BrowseReposViewController.h"
#import "GithubRepo.h"

@interface BrowseReposViewController ()
{
    RKObjectMapping *objectMapping;
    NSArray *repos;
}
@end

@implementation BrowseReposViewController

- (RKObjectMapping *)mapping
{
    if (objectMapping == nil) {
        // define mapping from JSON data structure to object structure
        objectMapping = [RKObjectMapping mappingForClass:[GithubRepo class]];
        [objectMapping mapKeyPath:@"url" toAttribute:@"url"];
        [objectMapping mapKeyPath:@"name" toAttribute:@"name"];
        [objectMapping mapKeyPath:@"description" toAttribute:@"description"];
        [objectMapping mapKeyPath:@"private" toAttribute:@"private"];
        [objectMapping mapKeyPath:@"open_issues" toAttribute:@"open_issues"];
    }
    return objectMapping;    
}

- (void)fetchData
{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"/users/peterfriese/repos" 
                                                  objectMapping:[self mapping] 
                                                       delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects
{
    repos = objects;
    [self.tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader*)objectLoader didFailWithError:(NSError*)error;
{
    NSLog(@"Encountered an error: %@", error);
}

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
    [self fetchData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [repos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    GithubRepo *repo = (GithubRepo *)[repos objectAtIndex:[indexPath row]];
    cell.textLabel.text = repo.name;
    cell.detailTextLabel.text = repo.open_issues;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
