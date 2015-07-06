//
//  FirstViewController.m
//  PenPalApp2.3
//
//  Created by Computer on 4/12/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "SearchTab.h"
#import "FilterSearchPage.h"

@interface SearchTab ()

@end

@implementation SearchTab

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refresh_search)];
    
    UIBarButtonItem *filterItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filter_search)];
    
    
    //self.navigationController.navigationItem.rightBarButtonItem = filterItem;
    self.navigationItem.leftBarButtonItem = refreshItem;
    self.navigationItem.rightBarButtonItem = filterItem;
    
    self.navigationItem.title = NSLocalizedString(@"Search", nil);
    
    //[[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:NSLocalizedString(@"Search", @"Search")];

    
}

- (IBAction)refresh_search{
    
}

- (IBAction)filter_search{
    
    FilterSearchPage *vc = [[FilterSearchPage alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    vc2.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc2 animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
