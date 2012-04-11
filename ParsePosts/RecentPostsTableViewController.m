//
//  RecentPostsTableViewController.m
//  ParseTest
//
//  Created by David Rodriguez on 4/11/12.
//  Copyright (c) 2012 Forge42. All rights reserved.
//

#import "RecentPostsTableViewController.h"
#import <Parse/Parse.h>

@interface RecentPostsTableViewController ()

@end

@implementation RecentPostsTableViewController
@synthesize posts;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self setPosts:[NSArray array]]; // setup the empty posts array
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
    [self loadTableData:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadTableData:) name:@"loadParseTableData" object:nil];
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

- (void)dealloc {
    
    [self setPosts:nil];
    
    [super dealloc];
}

- (void)loadTableData:(NSNotification *)notification {
    PFQuery *query = [PFQuery queryWithClassName:@"posts"];
    NSError *error = nil;
    
    [query orderByDescending:@"createdAt"];
    
    NSArray *objects = [query findObjects:&error];
    
    [self setPosts:objects];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [posts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PostCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    PFUser *user = (PFUser *)[[posts objectAtIndex:indexPath.row] objectForKey:@"user"];
    
    [user fetchIfNeeded];
    cell.textLabel.text = [user username];
    cell.detailTextLabel.text = [[posts objectAtIndex:indexPath.row] objectForKey:@"comment"];
    
    return cell;
}

@end
