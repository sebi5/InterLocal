//
//  LoginPage.m
//  PenPalApp2.3
//
//  Created by Computer on 4/12/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "LoginPage.h"
#import "ForgotLoginInfo.h"
#import "MainView.h"
#import "InitView.h"
#import "AppDelegate.h"


UITextField *loginNameTextField = nil;
UITextField *loginPasswordTextField = nil;
UIButton *forgotButton = nil;
UILabel *loginErrorLable = nil;

@interface LoginPage ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation LoginPage
@synthesize responseData = _responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    float width = self.view.frame.size.width - 15;
    float height = 38;
    float xPos = 14;
    float yPos = 4;
    
    float buttonWidth = self.view.frame.size.width;
    float buttonHeight = 28;
    float buttonX = (self.view.frame.size.width - buttonWidth)/2;
    
    loginNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    loginNameTextField.borderStyle = UITextBorderStyleRoundedRect;
    loginNameTextField.textColor = [UIColor blackColor];
    loginNameTextField.font = [UIFont systemFontOfSize:17.0];
    loginNameTextField.placeholder = @"Username or email";
    loginNameTextField.backgroundColor = [UIColor clearColor];
    loginNameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    loginNameTextField.keyboardType = UIKeyboardTypeDefault;
    loginNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    loginNameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    loginNameTextField.borderStyle = UITextBorderStyleNone;
    loginNameTextField.returnKeyType = UIReturnKeyNext;
#pragma mark - may need to center do diff screen sizes
    loginNameTextField.tag = 200;
    loginNameTextField.delegate = self;
    
    loginPasswordTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    loginPasswordTextField.borderStyle = UITextBorderStyleRoundedRect;
    loginPasswordTextField.textColor = [UIColor blackColor];
    loginPasswordTextField.font = [UIFont systemFontOfSize:17.0];
    loginPasswordTextField.placeholder = @"Password";
    loginPasswordTextField.backgroundColor = [UIColor clearColor];
    loginPasswordTextField.keyboardType = UIKeyboardTypeDefault;
    loginPasswordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    loginPasswordTextField.borderStyle = UITextBorderStyleNone;
    loginPasswordTextField.secureTextEntry = true;
    loginPasswordTextField.returnKeyType = UIReturnKeyDone;
    loginPasswordTextField.tag = 201;
    loginPasswordTextField.delegate = self;
    
    
    forgotButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 160, buttonWidth, buttonHeight)];
    [forgotButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    forgotButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [forgotButton setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [forgotButton setTitle:@"Forgot Password Information?" forState:UIControlStateNormal];
    [forgotButton setTag:203];
    [forgotButton addTarget:self action:@selector(forgotLoginInfo) forControlEvents:UIControlEventTouchUpInside];
    
    //section text as a label
    loginErrorLable = [[UILabel alloc] initWithFrame: CGRectMake(10, 15, self.view.frame.size.width, 30)];
    loginErrorLable.textAlignment = NSTextAlignmentCenter;
    //loginErrorLable.text = NSLocalizedString(@"Error", @"Error");
    [loginErrorLable setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [loginErrorLable setBackgroundColor:[UIColor clearColor]];
    
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    mainView.delegate = self;
    mainView.dataSource = self;
    
    [self.view addSubview:mainView];
    
    
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    
    UIBarButtonItem *loginItem = [[UIBarButtonItem alloc] initWithTitle:@"Log In" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    
    self.view.backgroundColor = [UIColor grayColor];
    
    
    
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.rightBarButtonItem = loginItem;
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction) forgotLoginInfo{
    
    ForgotLoginInfo *vc = [[ForgotLoginInfo alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    //NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    //NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"connectionDidFinishLoading");
    //NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    //NSLog(@"Dict: %@", res);
    
    NSArray *res_arr = [res objectForKey:@"data"];
    NSDictionary *real_res = [res_arr objectAtIndex:0];
    NSString *code = [real_res objectForKey:@"code"];
    NSString *message = [real_res objectForKey:@"message"];
    NSString *success = [real_res objectForKey:@"success"];
    
    if (![code isEqualToString:@"0"]) {
        [loginErrorLable setTextColor:[UIColor redColor]];
        loginErrorLable.text = NSLocalizedString(message, @"Error");
        
        CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
        [shake setDuration:0.1];
        [shake setRepeatCount:2];
        [shake setAutoreverses:YES];
        [shake setFromValue:[NSValue valueWithCGPoint:CGPointMake(loginPasswordTextField.center.x - 5,loginPasswordTextField.center.y)]];
        [shake setToValue:[NSValue valueWithCGPoint:CGPointMake(loginPasswordTextField.center.x + 5, loginPasswordTextField.center.y)]];
        
        UIColor *fromColor = [UIColor colorWithRed:249/255.0 green:40/255.0 blue:40/255.0 alpha:0.8];
        UIColor *toColor = [UIColor colorWithRed:252/255.0 green:59/255.0 blue:59/255.0 alpha:0.4];
        CABasicAnimation *colorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        colorAnimation.duration = 0.6;
        colorAnimation.fromValue = (id)fromColor.CGColor;
        colorAnimation.toValue = (id)toColor.CGColor;
        
        [loginPasswordTextField.layer addAnimation:colorAnimation forKey:@"backgroundColor"];
        [loginPasswordTextField.layer addAnimation:shake forKey:@"position"];
    }
    else{
        
        [self.view endEditing:YES];
        
        NSString *user_id = [real_res objectForKey:@"user_id"];
        NSString *user_pass = [real_res objectForKey:@"password"];
        NSLog(@"User_ID: %@, User_Pass: %@",user_id, user_pass);
        
        [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
        [[NSUserDefaults standardUserDefaults] setObject:user_pass forKey:@"user_pass"];
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"loggedIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        NSMutableArray *viewControllers2 = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        [viewControllers2 removeObjectAtIndex:0];
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        [self.navigationController setViewControllers:viewControllers2 animated:NO];
        
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        MainView *vc = [[MainView alloc] init];
        [appDelegate.window setRootViewController:vc];
        

        //[[UIApplication sharedApplication].keyWindow setRootViewController: vc];
  
     
        
    }
    
}


- (IBAction)login{
    // might need this
    
    
    loginNameTextField.text = loginNameTextField.text;
    loginPasswordTextField.text = loginPasswordTextField.text;
    
    
    self.responseData = [NSMutableData data];
    NSString *post = [NSString stringWithFormat:@"p_chk=key&user=%@&password=%@",loginNameTextField.text,loginPasswordTextField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding]; // NSASCIIStringEncoding NSUTF8StringEncoding
    //NSURLRequest NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.157.207/python/login.py"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //else
    
    
    // post data to db, if login info is good
    
    
    
    // [[[self presentingViewController] presentingViewController] dismissViewControllerAnimated:NO completion:nil];
    // [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    // Return the number of rows in the section.
    
    return 2;
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    switch (indexPath.row) {
        case 0:
            [cell addSubview:loginNameTextField];
            break;
        case 1:
            [cell addSubview:loginPasswordTextField];
            break;
        default:
            break;
    }
    
    
    
    
#pragma - might make parts a global veriable
    
    [tableView addSubview:forgotButton];
    
    
    //cell.textLabel.text = [parts objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    if (section == 0) {
        
        return loginErrorLable;
    }
    
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 50;
    
    return tableView.sectionHeaderHeight;
}

-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma -mark textFiledDelegates
-(BOOL)checkLoginInfo:(NSString*)username
{       //__block BOOL doexist=NO;
    
    return false;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    
    
    UITextField *txtfld=(UITextField*)[mainView viewWithTag:textField.tag+1];
    
    switch (textField.tag) {
        case 200:
        {   if(textField.text.length>0)
            
        {
            
            [txtfld becomeFirstResponder];
            
        }
        else
        {
            
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Username Required" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alert show];
            [textField becomeFirstResponder];
            
        }
            
            
        }
            break;
        case 201:
        {
            if(textField.text.length>0)
                
            {
                //data.name=textField.text;
                [self login];
                
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Password Required" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [textField becomeFirstResponder];
            }
            
        }
            break;
        default:
            break;
    }
    
    //[AppDelegate saveObjectToUserDefault:data withKey:@"userData"];
    
    return YES;
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    mainView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

/*
 - (BOOL) textFieldShouldReturn:(UITextField *)textField
 {
 [textField resignFirstResponder];
 return YES;
 }*/

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
