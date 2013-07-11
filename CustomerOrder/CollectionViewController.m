//
//  CollectionViewController.m
//  CustomerOrder
//
//  Created by ios on 13-6-14.
//  Copyright (c) 2013年 hxhd. All rights reserved.
//

#import "CollectionViewController.h"
#import "DetailDisplayCell.h"
#import "DetailViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DetailDisplayCell *cell = (DetailDisplayCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[DetailDisplayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.leftImgView.image = [UIImage imageNamed:@"2.jpg"];
    cell.title.text = @"华信咖啡厅";
    cell.gradeImgView.image = [UIImage imageNamed:@"ShopStar20@2x.png"];
    cell.average.text = @"81";
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detail = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detail animated:YES];
    [detail release];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f;

}

@end
