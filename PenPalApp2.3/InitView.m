//
//  InitView.m
//  PenPalApp2.3
//
//  Created by Computer on 4/12/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "InitView.h"
#import "LoginPage.h"
#import "SignupPage.h"

@interface InitView ()

@end

@implementation InitView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = [UIColor grayColor];
    
    float buttonY = self.view.frame.size.height * .75;
    float buttonWidth = self.view.frame.size.width - 20; // 300
    float buttonHeight = 50;
    float buttonX = (self.view.frame.size.width - buttonWidth)/2;
    
    //[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, buttonY, buttonWidth, buttonHeight)];
    [loginButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [loginButton setTitleColor:[UIColor grayColor] forState: UIControlStateHighlighted];
    [loginButton setBackgroundColor:[UIColor whiteColor]];
    
    CALayer *btnLayer = [loginButton layer];
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:3.0f];
    
    [loginButton setTitle:@"Log In" forState:UIControlStateNormal];
    [loginButton setTag:0];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [loginButton addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: loginButton];
    
    
    UIButton *signupButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, buttonY + 65, buttonWidth, buttonHeight)];
    [signupButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [signupButton setTitleColor:[UIColor grayColor] forState: UIControlStateHighlighted];
    [signupButton setBackgroundColor:[UIColor whiteColor]];
    
    CALayer *btnLayer2 = [signupButton layer];
    [btnLayer2 setMasksToBounds:YES];
    [btnLayer2 setCornerRadius:3.0f];
    
    [signupButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signupButton setTag:1];
    signupButton.titleLabel.font = [UIFont systemFontOfSize:19];
    [signupButton addTarget:self action:@selector(signIn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: signupButton];
    
    //UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width,44)];
    //navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   // navBar.topItem.title = @"PenPal";
    //[self.view addSubview:navBar];
    
    
    self.navigationItem.title = NSLocalizedString(@"PenPal", nil);
    
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logIn{
    
    LoginPage *vc = [[LoginPage alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];
    
   // NSMutableArray *viewControllers2 = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
   // [viewControllers2 replaceObjectAtIndex:0 withObject:vc];
    //[viewControllers2 removeObject:self];
   // vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
   // [self.navigationController setViewControllers:viewControllers2 animated:YES];
    

    
}

- (IBAction)signIn{
    
    SignupPage *vc = [[SignupPage alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];

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
