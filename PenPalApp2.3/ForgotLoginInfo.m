//
//  ForgotLoginInfo.m
//  PenPalApp2.3
//
//  Created by Computer on 4/13/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "ForgotLoginInfo.h"

UITextField *forgotTextField = nil;
UILabel *forgotLabel = nil;

@interface ForgotLoginInfo ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation ForgotLoginInfo
@synthesize responseData = _responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];

    
    float width = self.view.frame.size.width - 15;
    float height = 38;
    float xPos = 10;
    float yPos = 4;
    
    float labelWidth = self.view.frame.size.width;
    float labelHeight = 28;
    float buttonX = (self.view.frame.size.width - labelWidth)/2;
    
    forgotTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    forgotTextField.borderStyle = UITextBorderStyleRoundedRect;
    forgotTextField.textColor = [UIColor blackColor];
    forgotTextField.font = [UIFont systemFontOfSize:17.0];
    forgotTextField.placeholder = @"We will email you a password reset link";
    forgotTextField.backgroundColor = [UIColor clearColor];
    forgotTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    forgotTextField.keyboardType = UIKeyboardTypeDefault;
    forgotTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    forgotTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    forgotTextField.borderStyle = UITextBorderStyleNone;
#pragma mark - may need to center do diff screen sizes
    forgotTextField.tag = 0;
    forgotTextField.delegate = self;
    
    
    
    //[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0]
    
    forgotLabel = [[UILabel alloc] initWithFrame: CGRectMake(buttonX, yPos + 15, labelWidth, labelHeight)];
    [forgotLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    [forgotLabel setTextColor:[UIColor blackColor]];
    forgotLabel.textAlignment = NSTextAlignmentCenter;
#pragma mark - translate ; " your email "
    [forgotLabel setText:@"Enter your profile email address"];
    
    
    
    
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    mainView.delegate = self;
    mainView.dataSource = self;
    
    [self.view addSubview:mainView];
    
 
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    
    UIBarButtonItem *submitItem = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self action:@selector(submitButton)];
    
  
    
    self.view.backgroundColor = [UIColor grayColor];
    

    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.rightBarButtonItem = submitItem;
    
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
    
    
    [self.mySpinner stopAnimating];
    self.navigationItem.titleView = nil;
    
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
        
        UIAlertView *error = [[UIAlertView alloc]
                                  initWithTitle: message
                                  message: nil
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [error show];

    }
    else{
        
        UIAlertView *resetSent = [[UIAlertView alloc]
                                  initWithTitle: @"Please check your email for your password reset link"
                                  message: nil
                                  delegate: nil
                                  cancelButtonTitle:@"Done"
                                  otherButtonTitles:nil];
        [resetSent show];
        [self.view endEditing:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}


-(IBAction)submitButton{
    
    UIView *spn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.toolbar.frame.size.height, self.navigationController.toolbar.frame.size.height)];
    self.mySpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.toolbar.frame.size.height, self.navigationController.toolbar.frame.size.height)];
    self.mySpinner.color = [UIColor blueColor];
    self.mySpinner.hidesWhenStopped = YES;
    [spn addSubview:self.mySpinner];
    self.navigationItem.titleView = spn;
    [self.mySpinner startAnimating];
    
    // alert if error
    
    //if good, post to db
    
    forgotTextField.text = forgotTextField.text;
    
    self.responseData = [NSMutableData data];
    NSString *post = [NSString stringWithFormat:@"p_chk=key&email=%@",forgotTextField.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding]; // NSASCIIStringEncoding NSUTF8StringEncoding
    //NSURLRequest NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.157.207/python/forgot_login.py"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 60;
    return tableView.sectionHeaderHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    

    
    
    switch (indexPath.row) {
        case 0:
            [cell addSubview:forgotTextField];
            break;
        default:
            break;
    }

    
#pragma - might make parts a global veriable
    
    [mainView addSubview:forgotLabel];
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}



-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //[self dismissViewControllerAnimated:YES completion:nil];
    //[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    
    
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
