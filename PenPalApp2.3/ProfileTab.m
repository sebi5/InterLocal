//
//  FirstViewController.m
//  PenPalApp2.3
//
//  Created by Computer on 4/12/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "ProfileTab.h"
#import "InitView.h"
#import "MainView.h"
#import "AppDelegate.h"
#import "EditProfilePage.h"

@interface ProfileTab ()

@property (nonatomic, strong) UIButton *loginOut;

@end

@implementation ProfileTab

@synthesize loginOut = _loginOut;

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    self.navigationItem.title = NSLocalizedString(@"Profile", nil);
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButton)];
    

    self.navigationItem.rightBarButtonItem = editItem;
    
 
    float yPos = (self.view.frame.size.height - 28)/2;
    float buttonWidth =  self.view.frame.size.width;
    float buttonHeight = 28;
    float buttonX = (self.view.frame.size.width - buttonWidth)/2;
    
    

    
    _loginOut = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos, buttonWidth, buttonHeight)];
    [_loginOut setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [_loginOut setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_loginOut setTitle:@"Log Out" forState:UIControlStateNormal];
    [_loginOut setTag:111];
    [_loginOut addTarget:self action:@selector(logoutButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginOut];
    
    //[self.view  addSubview: _loginOut];
    
}

- (IBAction)logoutButton{
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    InitView *vc = [[InitView alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [appDelegate.window setRootViewController:vc2];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    

    
}

-(void)viewWillAppear:(BOOL)animated {
    

    
}

- (IBAction)editButton{
    
    EditProfilePage *vc = [[EditProfilePage alloc] init];
    //UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    
   // [(UINavigationController *)self.tabBarController.selectedViewController pushViewController:vc animated:YES];
    //[self.navigationController pushViewController:vc animated:YES];
    
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
