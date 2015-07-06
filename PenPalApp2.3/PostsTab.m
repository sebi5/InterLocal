//
//  FirstViewController.m
//  PenPalApp2.3
//
//  Created by Computer on 4/12/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "PostsTab.h"


@interface PostsTab ()

@end

@implementation PostsTab

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = NSLocalizedString(@"Posts", nil);
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(refresh_search)];
    
    UIBarButtonItem *editItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(addButton)];
    
    self.navigationItem.leftBarButtonItem = refreshItem;
    self.navigationItem.rightBarButtonItem = editItem;
    
    float yPos = (self.view.frame.size.height - 28)/2;
    float buttonWidth =  self.view.frame.size.width;
    float buttonHeight = 28;
    float buttonX = (self.view.frame.size.width - buttonWidth)/2;
    
    
    UIButton *postBTN = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos, buttonWidth, buttonHeight)];
    [postBTN setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [postBTN setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [postBTN setTitle:@"Here is where users can make posts" forState:UIControlStateNormal];
    [postBTN setTag:100];
    [postBTN addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postBTN];
    
}

- (IBAction)addButton{

}

- (IBAction)refresh_search{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
