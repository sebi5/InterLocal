//
//  SignupPage.m
//  PenPalApp2.3
//
//  Created by Computer on 4/13/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "SignupPage.h"
#import "SignupOptions.h"
#import "BirthdatePage.h"
#import "SLCountryPickerViewController.h"
#import "AppDelegate.h"
#import "MainView.h"

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

NSString *gV_signup_age = @"";

UITextField *nameTextField = nil;
UITextField *emailTextField = nil;
UITextField *passwordTextField = nil;
UITextField *usernameTextField = nil;
UITextField *birthTextField = nil;
UIButton *genderButton = nil;
UIButton *countryButton = nil;
UIButton *regionButton = nil;
UIButton *birthButton = nil;

@interface SignupPage ()
@property (nonatomic, strong) NSMutableData *responseData;
@end

@implementation SignupPage
@synthesize responseData = _responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
    float width = self.view.frame.size.width - 15;
    float height = 38;
    float xPos = 15;
    float yPos = 3;
    
    float buttonWidth =  self.view.frame.size.width;
    float buttonHeight = 28;
    float buttonX = (self.view.frame.size.width - buttonWidth)/2;

 
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    usernameTextField.textColor = [UIColor blackColor];
    usernameTextField.font = [UIFont systemFontOfSize:17.0];
    usernameTextField.placeholder = NSLocalizedString(@"Username", nil);
    usernameTextField.backgroundColor = [UIColor clearColor];
    usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    usernameTextField.autocapitalizationType = false;
    usernameTextField.keyboardType = UIKeyboardTypeDefault;
    usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    usernameTextField.tag = 100;
    usernameTextField.borderStyle = UITextBorderStyleNone;
    usernameTextField.returnKeyType = UIReturnKeyNext;
    usernameTextField.delegate = self;


    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.textColor = [UIColor blackColor];
    nameTextField.font = [UIFont systemFontOfSize:17.0];
    nameTextField.placeholder = NSLocalizedString(@"Name", nil);
    nameTextField.backgroundColor = [UIColor clearColor];
    nameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    nameTextField.keyboardType = UIKeyboardTypeDefault;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
#pragma mark - may need to center do diff screen sizes
    nameTextField.borderStyle = UITextBorderStyleNone;
    nameTextField.tag = 101;
    nameTextField.returnKeyType = UIReturnKeyNext;
    nameTextField.delegate = self;
    

    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    passwordTextField.textColor = [UIColor blackColor];
    passwordTextField.font = [UIFont systemFontOfSize:17.0];
    passwordTextField.placeholder = NSLocalizedString(@"Password", nil);
    passwordTextField.backgroundColor = [UIColor clearColor];
    passwordTextField.keyboardType = UIKeyboardTypeDefault;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.secureTextEntry = true;
    passwordTextField.tag = 102;
    passwordTextField.borderStyle = UITextBorderStyleNone;
    passwordTextField.returnKeyType = UIReturnKeyNext;
    passwordTextField.delegate = self;
    

    emailTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    emailTextField.borderStyle = UITextBorderStyleRoundedRect;
    emailTextField.textColor = [UIColor blackColor];
    emailTextField.font = [UIFont systemFontOfSize:17.0];
    emailTextField.placeholder = NSLocalizedString(@"Email", @"E-mail");
    emailTextField.backgroundColor = [UIColor clearColor];
    emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    emailTextField.autocapitalizationType = false;
    emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    emailTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    emailTextField.borderStyle = UITextBorderStyleNone;
    emailTextField.tag = 103;
    emailTextField.returnKeyType = UIReturnKeyNext;
    emailTextField.delegate = self;
    
    
/*
    birthTextField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    birthTextField.borderStyle = UITextBorderStyleRoundedRect;
    birthTextField.textColor = [UIColor blackColor];
    birthTextField.font = [UIFont systemFontOfSize:17.0];
    birthTextField.placeholder = NSLocalizedString(@"Birthday 01-31-1999", @"birthdate");
#pragma mark - may need to auto add / and pad 0's for 1-9.
    birthTextField.backgroundColor = [UIColor clearColor];
    birthTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    birthTextField.keyboardType = UIKeyboardTypeNumberPad;
    birthTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    birthTextField.borderStyle = UITextBorderStyleNone;
    birthTextField.tag = 104;
    birthTextField.delegate = self;
*/
    
    birthButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [birthButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [birthButton setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [birthButton setTitle:@"Select Brithdate" forState:UIControlStateNormal];
    [birthButton setTag:104];
    [birthButton addTarget:self action:@selector(actionBTNBday:) forControlEvents:UIControlEventTouchUpInside];
    
    
    genderButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [genderButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [genderButton setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [genderButton setTitle:NSLocalizedString(@"Select Gender", @"Gender") forState:UIControlStateNormal];
    [genderButton setTag:105];
    [genderButton addTarget:self action:@selector(actionBTN:) forControlEvents:UIControlEventTouchUpInside];
    
    
    countryButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [countryButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [countryButton setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [countryButton setTitle:@"Select Country" forState:UIControlStateNormal];
    [countryButton setTag:106];
    [countryButton addTarget:self action:@selector(actionCNY:) forControlEvents:UIControlEventTouchUpInside];
    
    
    regionButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [regionButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [regionButton setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [regionButton setTitle:@"Select Region" forState:UIControlStateNormal];
    [regionButton setTag:107];
    [regionButton addTarget:self action:@selector(actionBTN:) forControlEvents:UIControlEventTouchUpInside];
    
    
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    mainView.delegate = self;
    mainView.dataSource = self;
    
    [self.view addSubview:mainView];
    
    
    
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    
    UIBarButtonItem *submitItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Up" style:UIBarButtonItemStylePlain target:self action:@selector(submitButton)];
    

    
    self.view.backgroundColor = [UIColor grayColor];
    

    
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.rightBarButtonItem = submitItem;
    
    
    

}

-(void)viewWillAppear:(BOOL)animated{
    
#pragma - make like th rest, store in user defaults 
    if (![gV_bday isEqualToString:@""] && gV_bday) {
        [birthButton setTitle:gV_bday forState:UIControlStateNormal];
    }
    
    // set button with user data
    NSString* Gender_text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Gender_text"];
    if (![Gender_text length] == 0) {[genderButton setTitle:Gender_text forState:UIControlStateNormal];}
    
    NSString* Country_text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Country_text"];
    if (![Country_text length] == 0) {[countryButton setTitle:Country_text forState:UIControlStateNormal];}

    NSString* Region_text = [[NSUserDefaults standardUserDefaults] stringForKey:@"Region_text"];
    if (![Region_text length] == 0) {[regionButton setTitle:Region_text forState:UIControlStateNormal];}
    else{[regionButton setTitle:@"Select Region" forState:UIControlStateNormal];}
    
}

-(void)viewDidAppear:(BOOL)animated{
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
        return 20;
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
            [cell addSubview:usernameTextField];
            break;
        case 1:
            [cell addSubview:nameTextField];
            break;
        case 2:
            [cell addSubview:passwordTextField];
            break;
        default:
            break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [cell addSubview:emailTextField];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                [cell addSubview:birthButton];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                [cell addSubview: genderButton];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 4) {
        switch (indexPath.row) {
        case 0:
            [cell  addSubview: countryButton]; //cell.contentView
            break;
        case 1:
            [cell addSubview: regionButton];
            break;
        default:
            break;
        
        }
       
    }
   
#pragma - might make parts a global veriable

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    mainView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
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
        
    }

    

    
}



- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}

- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

- (IBAction)submitButton{
    
    
    // if data is good, proceed. Store user info as ints for fast upload & security
    NSString *Gender = [[NSUserDefaults standardUserDefaults] stringForKey:@"Gender"];
    NSString *Country = [[NSUserDefaults standardUserDefaults] stringForKey:@"Country"];
    // will add a 1 to everyone if the region list gets updated
    NSString *Region = [[NSUserDefaults standardUserDefaults] stringForKey:@"Region"];
    
    nameTextField.text = nameTextField.text;
    emailTextField.text = emailTextField.text;
    passwordTextField.text = passwordTextField.text;
    usernameTextField.text = usernameTextField.text;
    birthTextField.text = birthTextField.text;
    
    
    NSString *IP = [self getIPAddress:true];
    
    self.responseData = [NSMutableData data];
    NSString *post = [NSString stringWithFormat:@"p_chk=key&device=1&username=%@&fullname=%@&user_email=%@&country=%@&region=%@&password=%@&gender=%@&birthdate=%@&IP=%@",usernameTextField.text,nameTextField.text,emailTextField.text,Country,Region,passwordTextField.text,Gender,gV_bday,IP];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding]; // NSASCIIStringEncoding NSUTF8StringEncoding
    //NSURLRequest NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.157.207/python/signup.py"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];

    NSLog(@"Submitted Data: %@", post);
    

}


-(void)actionBTN:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:[sender tag]] forKey:@"pageListID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SignupOptions *vc = [[SignupOptions alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];
    
}

-(void)actionBTNBday:(id)sender{
    
    BirthdatePage *vc = [[BirthdatePage alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];

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

NSMutableString *filteredPhoneStringFromStringWithFilter(NSString *string, NSString *filter)
{
    NSUInteger onOriginal = 0, onFilter = 0, onOutput = 0;
    char outputString[([filter length])];
    BOOL done = NO;
    
    while(onFilter < [filter length] && !done)
    {
        char filterChar = [filter characterAtIndex:onFilter];
        char originalChar = onOriginal >= string.length ? '\0' : [string characterAtIndex:onOriginal];
        switch (filterChar) {
            case '#':
                if(originalChar=='\0')
                {
                    // We have no more input numbers for the filter.  We're done.
                    done = YES;
                    break;
                }
                if(isdigit(originalChar))
                {
                    outputString[onOutput] = originalChar;
                    onOriginal++;
                    onFilter++;
                    onOutput++;
                }
                else
                {
                    onOriginal++;
                }
                break;
            default:
                // Any other character will automatically be inserted for the user as they type (spaces, - etc..) or deleted as they delete if there are more numbers to come.
                outputString[onOutput] = filterChar;
                onOutput++;
                onFilter++;
                if(originalChar == filterChar)
                    onOriginal++;
                break;
        }
    }
    outputString[onOutput] = '\0'; // Cap the output string
    return [NSMutableString stringWithUTF8String:outputString];
}

/*

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *filter = nil;
    
    switch(textField.tag) {
        case 104:
        {
            filter = @"##-##-####";
        }
        default:
            break;
    }
            
    if(!filter) return YES; // No filter provided, allow anything
    
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if(range.length == 1 && // Only do for single deletes
       string.length < range.length &&
       [[textField.text substringWithRange:range] rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"0123456789"]].location == NSNotFound)
    {
        // Something was deleted.  Delete past the previous number
        NSInteger location = changedString.length-1;
        if(location > 0)
        {
            for(; location > 0; location--)
            {
                if(isdigit([changedString characterAtIndex:location]))
                {
                    break;
                }
            }
            changedString = [changedString substringToIndex:location];
        }
    }
    
    textField.text = filteredPhoneStringFromStringWithFilter(changedString, filter);
    gV_signup_age = textField.text;
     //NSLog(@"txt: %@", textField.text);
    
    return NO;
}
*/


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    if (section == 0) {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = NSLocalizedString(@"User Information", @"Username");
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        
        return lbl;
    }
    if (section == 1) {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = NSLocalizedString(@"Email Address", @"Email");
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        return lbl;
    }
    if (section == 2) {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = NSLocalizedString(@"Birthdate", @"Born");
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        return lbl;
    }
    if (section == 3) {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = NSLocalizedString(@"Gender", @"Male / Female");
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        return lbl;
    }
    if (section == 4) {
    UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(10, 15, self.view.frame.size.width, 30)];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.text = NSLocalizedString(@"Current Location", @"Location");
    [lbl setFont:[UIFont fontWithName:@"Helvetica" size:18]];
    [lbl setTextColor:[UIColor grayColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    
    return lbl;
    }
    
    return 0;
}
/*
-(BOOL)checkUserNameExist:(NSString*)username
{       __block BOOL doexist=NO;

  
    dispatch_queue_t myQueue = dispatch_queue_create("CheckUserNameExistQue",NULL);
    
    dispatch_async(myQueue, ^{
        
        
        
        
        // GetAll Countries
        
        self.serverResponse=[[ServerAPI sharedInstance]checkUserNameExist:username];
        
        
        NSLog(@"********** Server response: %@", self.serverResponse.responseString);;
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"********** Server msisdn: %@", self.serverResponse.responseString);
            
            
            
            if (self.serverResponse.success)
                
            {
                NSData *data = [self.serverResponse.responseString dataUsingEncoding:NSUTF8StringEncoding];
                NSError *localError = nil;
                NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
                
                if (localError != nil) {
                    NSLog(@"%@", [localError userInfo]);
                }
                NSDictionary* responseDic = (NSDictionary *)parsedObject;
                NSLog(@"operatorDic : %@",responseDic);
                
                doexist=YES;
            }
            else
            {
            }
            
            
        });
        
    });
    return doexist ;

}
*/


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    
    UITextField *txtfld=(UITextField*)[mainView viewWithTag:textField.tag+1];
    
    switch (textField.tag) {
        case 100:
        {   if(textField.text.length>0)
            
        {
            NSIndexPath *newIndex =[NSIndexPath indexPathForRow:0 inSection:1];
            [mainView scrollToRowAtIndexPath:newIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
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
        case 101:
        {
            if(textField.text.length>0)
            {
              
            
                NSIndexPath *newIndex =[NSIndexPath indexPathForRow:1 inSection:0];
                [mainView scrollToRowAtIndexPath:newIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                [txtfld becomeFirstResponder];
                
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Name Required" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [textField becomeFirstResponder];
            }
            
        }
        break;
        case 102:
        {
            if(textField.text.length>7)
            {
              
                NSIndexPath *newIndex =[NSIndexPath indexPathForRow:0 inSection:3];
                [mainView scrollToRowAtIndexPath:newIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                [txtfld becomeFirstResponder];
                
            }
            else
            {
                
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Password Required" message:@"Password must be at least 8 characters long." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [textField becomeFirstResponder];
            }
        }
        break;
        case 103:
        {
            if(textField.text.length>0)
            {
                //data.email=textField.text;
                NSIndexPath *newIndex =[NSIndexPath indexPathForRow:0 inSection:4];
                [mainView scrollToRowAtIndexPath:newIndex atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                [txtfld becomeFirstResponder];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Email Required" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [textField becomeFirstResponder];
            }
        }
        break;
        case 104:
        {
            if(textField.text.length>0)
            {
               
                [textField resignFirstResponder];
            }
            else
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Date Of Birth Required" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
                [textField becomeFirstResponder];
            }
        }
        break;
      
        default:
            break;
    }
    

    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    /*
    switch (textField.tag) {
        case 100:
        {
        if(textField.text.length>0){
            BOOL doUserNameExist=[self checkUserNameExist:textField.text];
            
            if (!doUserNameExist) {
                    textField.backgroundColor = [UIColor colorWithRed:252/255.0 green:59/255.0 blue:59/255.0 alpha:0.4];
            }
           
        }
        }
        break;
        case 103:
        {
            if(textField.text.length>0){
                BOOL doUserNameExist=[self checkEmailExist:textField.text];
                
                if (!doUserNameExist) {
                    textField.backgroundColor = [UIColor colorWithRed:252/255.0 green:59/255.0 blue:59/255.0 alpha:0.4];
                }
            }
        }
        break;
            
        default:
            break;
    }*/
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.backgroundColor = [UIColor clearColor];
}

#define MAXLENGTH 30

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    /*
    switch(textField.tag) {
        case 104:
        {
            filter = @"##-##-####";
        }
        default:
            break;
    }*/
    
    //if(!filter) return YES; // No filter provided, allow anything
    
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    return newLength <= MAXLENGTH;
}

// sagar

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
