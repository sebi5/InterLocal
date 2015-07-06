//
//  MainView.m
//  PenPalApp2.3
//
//  Created by Computer on 4/12/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "MainView.h"
#import "InitView.h"

#import "SearchTab.h"
#import "MessagesTab.h"
#import "PostsTab.h"
#import "ProfileTab.h"
#import "BOEditProfile.h"

@import Foundation;

@interface MainView ()

@end

@implementation MainView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SearchTab *VC1 = [[SearchTab alloc] init];
    VC1.title = NSLocalizedString(@"Search", @"Search");
    UINavigationController *VC1Navigation = [[UINavigationController alloc]initWithRootViewController:VC1];
    
    MessagesTab *VC2 = [[MessagesTab alloc] init];
    VC2.title = NSLocalizedString(@"Messages", @"Messages");
    UINavigationController *VC2Navigation = [[UINavigationController alloc] initWithRootViewController:VC2];
    
    PostsTab *VC3 = [[PostsTab alloc] init];
    VC3.title = NSLocalizedString(@"Posts", @"Posts");
    UINavigationController *VC3Navigation = [[UINavigationController alloc] initWithRootViewController:VC3];
    
    //BOEditProfile *VC3 = [[BOEditProfile alloc] init];
    //VC3.title = NSLocalizedString(@"Posts", @"Posts");
    //UINavigationController *VC3Navigation = [[UINavigationController alloc] initWithRootViewController:VC3];
    
    ProfileTab *VC4 = [[ProfileTab alloc] init];
    VC4.title = NSLocalizedString(@"Profile", @"Profile");
    UINavigationController *VC4Navigation = [[UINavigationController alloc] initWithRootViewController:VC4];
    
    
    NSArray* controllers = [NSArray arrayWithObjects:VC1Navigation, VC2Navigation, VC3Navigation, VC4Navigation, nil];
    self.viewControllers = controllers;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    

    


    
}

-(void)viewWillAppear:(BOOL)animated {



    
}

/*
 
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
*/

@end
