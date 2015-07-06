//
//  FilterSearchPage.m
//  PenPalApp2.3
//
//  Created by Computer on 6/3/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "FilterSearchPage.h"
#import "SLCountryPickerViewController.h"
#import "SignupOptions.h"

@interface FilterSearchPage ()

@property (nonatomic, strong) UIButton *searchLabel;

@end

@implementation FilterSearchPage

@synthesize searchLabel = _searchLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *filterOptions = [NSArray arrayWithObjects:@"Posts", @"Users", nil];
    
    UISegmentedControl *segmentfilter = [[UISegmentedControl alloc] initWithItems:filterOptions];
    segmentfilter.frame = CGRectMake(0, 0, self.view.frame.size.width/3, self.navigationController.toolbar.frame.size.height/1.5);
    segmentfilter.selectedSegmentIndex = 0;
    
    [segmentfilter addTarget:self action:@selector(filterSearchOption:) forControlEvents:UIControlEventValueChanged];

    self.navigationItem.titleView = segmentfilter;
    
    //self.navigationItem.title = NSLocalizedString(@"Filter Search", @"Filter");
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton)];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.rightBarButtonItem = saveItem;
    
    // Do any additional setup after loading the view.
    
    
    
    float width = self.view.frame.size.width - 15;
    float height = 38;
    float xPos = 15;
    float yPos = 3;
    
    float buttonWidth =  self.view.frame.size.width;
    float buttonHeight = 28;
    float buttonX = (self.view.frame.size.width - buttonWidth)/2;


    
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    searchTextField.textColor = [UIColor blackColor];
    searchTextField.font = [UIFont systemFontOfSize:17.0];
    searchTextField.placeholder = NSLocalizedString(@"Search Term", nil);
    searchTextField.backgroundColor = [UIColor clearColor];
    searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    searchTextField.keyboardType = UIKeyboardTypeDefault;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
#pragma mark - may need to center do diff screen sizes
    searchTextField.borderStyle = UITextBorderStyleNone;
    searchTextField.tag = 101;
    searchTextField.returnKeyType = UIReturnKeyNext;
    searchTextField.delegate = self;
    

    
    UIButton *countryButton2 = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [countryButton2 setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [countryButton2 setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [countryButton2 setTitle:@"Select Country" forState:UIControlStateNormal];
    [countryButton2 setTag:106];
    [countryButton2 addTarget:self action:@selector(actionCNY:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *regionButton2 = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [regionButton2 setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [regionButton2 setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [regionButton2 setTitle:@"Select Region" forState:UIControlStateNormal];
    [regionButton2 setTag:107];
    [regionButton2 addTarget:self action:@selector(actionBTN:) forControlEvents:UIControlEventTouchUpInside];
    
    
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    mainView.showsVerticalScrollIndicator = NO;
    
    mainView.delegate = self;
    mainView.dataSource = self;
    
    [self.view addSubview:mainView];
    
    
    searchPicker = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    searchPicker.backgroundColor = [UIColor whiteColor];
    
    _searchLabel = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos, buttonWidth, buttonHeight)];
    [_searchLabel setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    //[_searchLabel setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_searchLabel setTitle:@"Search Posts" forState:UIControlStateNormal];
    //_searchLabel.backgroundColor = [UIColor yellowColor];
    [_searchLabel setTag:150];
    [_searchLabel addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];

    
   
    [searchPicker addSubview:_searchLabel];
    [mainView addSubview:searchPicker];
    
}

- (IBAction)cancelButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)saveButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)actionBTN:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:[sender tag]] forKey:@"pageListID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SignupOptions *vc = [[SignupOptions alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];
    
}

- (void)filterSearchOption:(UISegmentedControl *)segment{
    
    if (segment.selectedSegmentIndex == 0) {
        
        [_searchLabel setTitle:@"Search Posts" forState:UIControlStateNormal];
        NSLog(@"0");
    }
    else if(segment.selectedSegmentIndex == 1){
        [_searchLabel setTitle:@"Search Users" forState:UIControlStateNormal];
        NSLog(@"1");
    }

}


-(void)actionCNY:(id)sender{
    SLCountryPickerViewController *vc = [[SLCountryPickerViewController alloc]init];
    vc.completionBlock = ^(NSString *country, NSString *code){
        //_countryNameLabel.text = country;
        //_countryImageView.image = [UIImage imageNamed:code];
        //_countryCodeLabel.text = code;
        
        NSString *text = country;
        
    };
    
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:vc2 animated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 4:
            return 2;
            break;
        default:
            break;
    }
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 40;
    if (section == 1)
        return 20;
    if (section == 2)
        return 20;
    if (section == 3)
        return 20;
    if (section == 4)
        return 40;
    return tableView.sectionHeaderHeight;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    if (section == 1)
        return 1;
    if (section == 2)
        return 1;
    if (section == 4)
        return 250;
    return tableView.sectionFooterHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                //[cell addSubview:usernameTextField];
                break;
            case 1:
                //[cell addSubview:nameTextField];
                break;
            case 2:
                //[cell addSubview:passwordTextField];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                //[cell addSubview:emailTextField];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                //[cell addSubview:birthButton];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                //[cell addSubview: genderButton];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 4) {
        switch (indexPath.row) {
            case 0:
                //[cell  addSubview: countryButton2]; //cell.contentView
                break;
            case 1:
                //[cell addSubview: regionButton2];
                break;
            default:
                break;
                
        }
        
    }
    
#pragma - might make parts a global veriable
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGRect newFrame = CGRectMake(0, self.navigationController.toolbar.frame.size.height, self.view.frame.size.width, self.navigationController.toolbar.frame.size.height - 5);
    
    newFrame.origin.x = 0;
    newFrame.origin.y = mainView.contentOffset.y+(self.navigationController.toolbar.frame.size.height + 21);
    searchPicker.frame = newFrame;

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
