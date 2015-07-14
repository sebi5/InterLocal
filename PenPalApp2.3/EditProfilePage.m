//
//  EditProfilePage.m
//  PenPalApp2.3
//
//  Created by Computer on 6/4/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "EditProfilePage.h"
#import "SignupOptions.h"
#import "SLCountryPickerViewController.h"
#import "InitView.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface EditProfilePage ()
@property (nonatomic, strong) NSMutableData *responseData;

@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *fullnameField;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *bioField;
@property (nonatomic, strong) UIButton *countryButton2;
@property (nonatomic, strong) UIButton *regionButton2;
@property (nonatomic, strong) UIButton *passwordButton;
@property (nonatomic, strong) UIButton *ageButton;
@property (nonatomic, strong) UIButton *typeButton;
@property (nonatomic, strong) UIButton *loginOut;
@property (nonatomic, strong) UIButton *deleteAcct;
@property (nonatomic, strong) UILabel *userLabel;
@property (nonatomic, strong) UILabel *userLabel2;
@property (nonatomic, strong) UILabel *userLabel3;
@property (nonatomic, strong) UIButton *profPic;


@end

@implementation EditProfilePage
@synthesize responseData = _responseData;

@synthesize usernameField = _usernameField;
@synthesize fullnameField = _fullnameField;
@synthesize emailField = _emailField;
@synthesize bioField = _bioField;
@synthesize countryButton2 = _countryButton2;
@synthesize regionButton2 = _regionButton2;
@synthesize passwordButton = _passwordButton;
@synthesize ageButton = _ageButton;
@synthesize typeButton = _typeButton;
@synthesize loginOut = _loginOut;
@synthesize deleteAcct = _deleteAcct;
@synthesize userLabel = _userLabel;
@synthesize userLabel2 = _userLabel2;
@synthesize userLabel3 = _userLabel3;
@synthesize profPic = _profPic;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    
  
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton)];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButton)];
    
    self.navigationItem.leftBarButtonItem = cancelItem;
    self.navigationItem.rightBarButtonItem = saveItem;
    
    self.navigationItem.title = NSLocalizedString(@"Edit", nil);
    
    
    
    UIView *spn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.toolbar.frame.size.height, self.navigationController.toolbar.frame.size.height)];
    self.mySpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.toolbar.frame.size.height, self.navigationController.toolbar.frame.size.height)];
    self.mySpinner.color = [UIColor blueColor];
    self.mySpinner.hidesWhenStopped = YES;
    [spn addSubview:self.mySpinner];
    self.navigationItem.titleView = spn;
    [self.mySpinner startAnimating];
    
    
    float width = self.view.frame.size.width - 15;
    float height = 40;
    float xPos = 15;
    float yPos = 10;
    
    float buttonWidth =  self.view.frame.size.width;
    float buttonHeight = 28;
    float buttonX = (self.view.frame.size.width - buttonWidth)/2;
    


    
    _userLabel = [[UILabel alloc] initWithFrame: CGRectMake(12, yPos, 110, height)];
    [_userLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [_userLabel setTextColor:[UIColor blackColor]];
    //_userLabel.font = [UIFont systemFontOfSize:16.0];
    _userLabel.textAlignment = NSTextAlignmentLeft;
    //[_userLabel setBackgroundColor:[UIColor yellowColor]];
    [_userLabel setText:@"Username"];
    
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(xPos + 110, yPos, width - 110, height)];
    _usernameField.borderStyle = UITextBorderStyleRoundedRect;
    _usernameField.textColor = [UIColor blackColor];
    _usernameField.font = [UIFont systemFontOfSize:16.0];
    _usernameField.placeholder = NSLocalizedString(@"Username", nil);
    _usernameField.backgroundColor = [UIColor clearColor];
    _usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    _usernameField.keyboardType = UIKeyboardTypeDefault;
    _usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _usernameField.borderStyle = UITextBorderStyleNone;
    _usernameField.tag = 101;
    _usernameField.returnKeyType = UIReturnKeyDone;
    _usernameField.delegate = self;
    
    _userLabel2 = [[UILabel alloc] initWithFrame: CGRectMake(12, yPos, 110, height)];
    [_userLabel2 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [_userLabel2 setTextColor:[UIColor blackColor]];
    //_userLabel2.font = [UIFont systemFontOfSize:16.0];
    _userLabel2.textAlignment = NSTextAlignmentLeft;
    [_userLabel2 setText:@"Name"];
    
    _fullnameField = [[UITextField alloc] initWithFrame:CGRectMake(xPos + 110, yPos, width - 110, height)];
    _fullnameField.borderStyle = UITextBorderStyleRoundedRect;
    _fullnameField.textColor = [UIColor blackColor];
    _fullnameField.font = [UIFont systemFontOfSize:16.0];
    _fullnameField.placeholder = NSLocalizedString(@"Full Name", @"Name");
    _fullnameField.backgroundColor = [UIColor clearColor];
    _fullnameField.autocorrectionType = UITextAutocorrectionTypeNo;
    _fullnameField.keyboardType = UIKeyboardTypeDefault;
    _fullnameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _fullnameField.borderStyle = UITextBorderStyleNone;
    _fullnameField.tag = 102;
    _fullnameField.returnKeyType = UIReturnKeyDone;
    _fullnameField.delegate = self;
    
    _userLabel3 = [[UILabel alloc] initWithFrame: CGRectMake(12, yPos, 110, height)];
    [_userLabel3 setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [_userLabel3 setTextColor:[UIColor blackColor]];
    //_userLabel3.font = [UIFont systemFontOfSize:16.0];
    _userLabel3.textAlignment = NSTextAlignmentLeft;
    [_userLabel3 setText:@"Email"];
    
    _emailField = [[UITextField alloc] initWithFrame:CGRectMake(xPos + 110, yPos, width - 110, height)];
    _emailField.borderStyle = UITextBorderStyleRoundedRect;
    _emailField.textColor = [UIColor blackColor];
    _emailField.font = [UIFont systemFontOfSize:16.0];
    _emailField.placeholder = NSLocalizedString(@"Email Address", @"Email");
    _emailField.backgroundColor = [UIColor clearColor];
    _emailField.autocorrectionType = UITextAutocorrectionTypeNo;
    _emailField.keyboardType = UIKeyboardTypeDefault;
    _emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _emailField.borderStyle = UITextBorderStyleNone;
    _emailField.tag = 103;
    _emailField.returnKeyType = UIReturnKeyDone;
    _emailField.delegate = self;
    
    _bioField = [[UITextField alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
    _bioField.borderStyle = UITextBorderStyleRoundedRect;
    _bioField.textColor = [UIColor blackColor];
    _bioField.font = [UIFont systemFontOfSize:16.0];
    _bioField.placeholder = NSLocalizedString(@"Mini Bio", @"Bio");
    _bioField.backgroundColor = [UIColor clearColor];
    _bioField.autocorrectionType = UITextAutocorrectionTypeNo;
    _bioField.keyboardType = UIKeyboardTypeDefault;
    _bioField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _bioField.borderStyle = UITextBorderStyleNone;
    _bioField.tag = 104;
    _bioField.returnKeyType = UIReturnKeyDone;
    _bioField.delegate = self;
    
    _countryButton2 = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [_countryButton2 setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [_countryButton2 setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_countryButton2 setTitle:@"Select Country" forState:UIControlStateNormal];
    [_countryButton2 setTag:106];
    [_countryButton2 addTarget:self action:@selector(actionCNY:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _regionButton2 = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [_regionButton2 setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [_regionButton2 setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_regionButton2 setTitle:@"Select Region" forState:UIControlStateNormal];
    [_regionButton2 setTag:107];
    [_regionButton2 addTarget:self action:@selector(actionBTN:) forControlEvents:UIControlEventTouchUpInside];
    
    _passwordButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [_passwordButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [_passwordButton setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_passwordButton setTitle:@"Change Password" forState:UIControlStateNormal];
    [_passwordButton setTag:108];
    [_passwordButton addTarget:self action:@selector(changePass) forControlEvents:UIControlEventTouchUpInside];
    
    _typeButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [_typeButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [_typeButton setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_typeButton setTitle:@"Account Type" forState:UIControlStateNormal];
    [_typeButton setTag:109];
    [_typeButton addTarget:self action:@selector(changePass) forControlEvents:UIControlEventTouchUpInside];
    
    _ageButton = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [_ageButton setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [_ageButton setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_ageButton setTitle:@"Birthdate: " forState:UIControlStateNormal]; // if boy blue, girl pink
    [_ageButton setTag:110];
    [_ageButton addTarget:self action:@selector(ageBTN) forControlEvents:UIControlEventTouchUpInside];
    
    _loginOut = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [_loginOut setTitleColor:[UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:1.0] forState: UIControlStateNormal];
    [_loginOut setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_loginOut setTitle:@"Log Out" forState:UIControlStateNormal];
    [_loginOut setTag:111];
    [_loginOut addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
  
    _deleteAcct = [[UIButton alloc] initWithFrame: CGRectMake(buttonX, yPos + 5, buttonWidth, buttonHeight)];
    [_deleteAcct setTitleColor:[UIColor redColor] forState: UIControlStateNormal];
    [_deleteAcct setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_deleteAcct setTitle:@"Delete Profile" forState:UIControlStateNormal]; 
    [_deleteAcct setTag:112];
    [_deleteAcct addTarget:self action:@selector(deleteProf) forControlEvents:UIControlEventTouchUpInside];
    
    _profPic = [[UIButton alloc] initWithFrame: CGRectMake((self.view.frame.size.width - 80)/2, yPos, 80, 80)];
    [_profPic setTitleColor:[UIColor blueColor] forState: UIControlStateNormal];
    [_profPic setTitleColor:[UIColor blueColor] forState: UIControlStateHighlighted];
    [_profPic setTitle:@"" forState:UIControlStateNormal]; // Profile Photo
    [_profPic setTag:113];
    [_profPic addTarget:self action:@selector(uploadPic) forControlEvents:UIControlEventTouchUpInside];
    [[_profPic layer] setBorderWidth:1.0f];
    [[_profPic layer] setBorderColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:0.6].CGColor];
    
  
    UIImage *btnImage = [UIImage imageNamed:@"default.jpg"];
    

    [_profPic setBackgroundImage:btnImage forState:UIControlStateNormal];
    //[_profPic setImage:btnImage forState:UIControlStateNormal];
    
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    mainView.delegate = self;
    mainView.dataSource = self;
    
    [self.view addSubview:mainView];
    
    //NSLog(@"INFO: %@ ||| %@", [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"], [[NSUserDefaults standardUserDefaults] stringForKey:@"user_pass"]);
    
    [self updateInfo];
    

}

-(void)updateInfo {
    self.responseData = [NSMutableData data];
    NSString *post = [NSString stringWithFormat:@"p_chk=key&u_id=%@&u_pass=%@",[[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"], [[NSUserDefaults standardUserDefaults] stringForKey:@"user_pass"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://45.55.157.207/python/getself.py"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
//    [self.mySpinner stopAnimating];
//    self.navigationItem.titleView = nil;
    //self.navigationItem.title = NSLocalizedString(@"Edit", nil);
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
   // NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    // convert to JSON
    NSError *myError = nil;
    NSDictionary *res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    
    NSArray *res_arr = [res objectForKey:@"data"];
    NSDictionary *real_res = [res_arr objectAtIndex:0];
    NSString *code = [real_res objectForKey:@"code"];
    NSString *message = [real_res objectForKey:@"message"];
    NSString *success = [real_res objectForKey:@"success"];
    
    //NSLog(@"DATA: %@", res_arr);
    
    if (![code isEqualToString:@"0"]) {
     
    }
    else{
        [self.view endEditing:YES];
        
        NSString *profile_picture = [real_res objectForKey:@"profile_picture"];
        NSString *user_email = [real_res objectForKey:@"user_email"];
        NSString *fullname = [real_res objectForKey:@"fullname"];
        NSString *birthdate = [real_res objectForKey:@"birthdate"];
        NSString *username = [real_res objectForKey:@"username"];
        NSString *bio = [real_res objectForKey:@"bio"];
        
        NSString *ProfPic = [NSString stringWithFormat:@"http://45.55.157.207/Profile_Photos/%@", profile_picture];
        UIImage *imageUpdate = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ProfPic]]];
        
        
        //[[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
        if (![profile_picture isEqualToString:@""] ) {
             [_profPic setBackgroundImage:imageUpdate forState:UIControlStateNormal];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",username] forKey:@"profile_username"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",fullname] forKey:@"profile_fullname"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",bio] forKey:@"profile_bio"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",user_email] forKey:@"profile_user_email"];
        [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(imageUpdate) forKey:@"profile_user_photo"];
        
        
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        _usernameField.text = username;
        _fullnameField.text = fullname;
        _bioField.text = bio;
        _emailField.text = user_email;
        
        NSString *BOD = [NSString stringWithFormat:@"Birthdate: %@", birthdate];
        [_ageButton setTitle:BOD forState:UIControlStateNormal];
       
        //[_profPic setImage:btnImage forState:UIControlStateNormal];
 
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [mainView reloadData];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
            NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
            
            [self.mySpinner stopAnimating];
            self.navigationItem.titleView = nil;
           // [mainView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            
        });
        
        
        /*
        //NSIndexPath *ppic = [NSIndexPath indexPathForItem:0 inSection:0];
        NSIndexPath *pusername = [NSIndexPath indexPathForItem:1 inSection:0];
        NSIndexPath *pfullname = [NSIndexPath indexPathForItem:1 inSection:1];
        NSIndexPath *pemail = [NSIndexPath indexPathForItem:1 inSection:2];
        //NSIndexPath *pbio = [NSIndexPath indexPathForItem:2 inSection:0];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
        NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];

        //[mainView beginUpdates];
       // [mainView reloadRowsAtIndexPaths:@[ppic] withRowAnimation:UITableViewRowAnimationNone];
       // [mainView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        //[mainView reloadRowsAtIndexPaths:@[pfullname] withRowAnimation:UITableViewRowAnimationNone];
        //[mainView reloadRowsAtIndexPaths:@[pemail] withRowAnimation:UITableViewRowAnimationNone];
       // [mainView reloadRowsAtIndexPaths:@[pbio] withRowAnimation:UITableViewRowAnimationNone];
        //[mainView reloadRowsAtIndexPaths:@[ppic] withRowAnimation:UITableViewRowAnimationNone];
        //[mainView endUpdates];
         */
        
    }
    
}

- (void)reloadRow0Section0 {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:1];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [mainView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
 
}


-(void)viewWillAppear:(BOOL)animated{
    


    
    NSString *profile_username = [[NSUserDefaults standardUserDefaults] stringForKey:@"profile_username"];
    NSString *profile_fullname = [[NSUserDefaults standardUserDefaults] stringForKey:@"profile_fullname"];
    
    NSString *profile_bio = [[NSUserDefaults standardUserDefaults] stringForKey:@"profile_bio"];
    NSString *profile_user_email = [[NSUserDefaults standardUserDefaults] stringForKey:@"profile_user_email"];
    NSData* profile_user_photo = [[NSUserDefaults standardUserDefaults] objectForKey:@"profile_user_photo"];
    
   
    _usernameField.text = profile_username;
     _fullnameField.text = profile_fullname;
    _bioField.text = profile_bio;
    _emailField.text = profile_user_email;
    
    if (! profile_user_photo.length == 0  ) {
        UIImage* prof_image = [UIImage imageWithData:profile_user_photo];
        [_profPic setBackgroundImage:prof_image forState:UIControlStateNormal];
    }
    
    // if no new data don't reload table
   
    
}


- (IBAction)uploadPic{
     /*
UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
imagePicker.delegate = self;
imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
imagePicker.allowsEditing = YES; // NO

[self presentViewController:imagePicker animated:YES completion:nil];
     
     */
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }

}


- (void) useCameraRoll
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        //newMedia = NO;
    }
}


- (void) useCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *) kUTTypeImage, nil];
        imagePicker.allowsEditing = NO;
        
        [self presentViewController:imagePicker animated:YES completion:nil];
        
        //newMedia = YES;
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIView *spn = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.toolbar.frame.size.height, self.navigationController.toolbar.frame.size.height)];
    self.mySpinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.toolbar.frame.size.height, self.navigationController.toolbar.frame.size.height)];
    self.mySpinner.color = [UIColor blueColor];
    self.mySpinner.hidesWhenStopped = YES;
    [spn addSubview:self.mySpinner];
    self.navigationItem.titleView = spn;
    [self.mySpinner startAnimating];
    
    
    
    
    //self.navigationItem.title = NSLocalizedString(@"", nil);
    [self.mySpinner startAnimating];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"Picked Image...");
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
        
        CGFloat fin;
        CGRect imageRect;
        
        if (image.size.width > image.size.height) {
            CGFloat xAdjust = 0-((image.size.width - image.size.height)/2);
            fin = image.size.height;
            imageRect = CGRectMake(xAdjust, 0, image.size.width, image.size.height);
        }
        else{
            CGFloat yAdjust = 0-((image.size.height - image.size.width)/2);
            fin = image.size.width;
            imageRect = CGRectMake(yAdjust, 0, image.size.width, image.size.height);
        }
        
        UIGraphicsBeginImageContext( CGSizeMake(fin,fin) );
        [image drawInRect:imageRect];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //imageView.image = image;
        
        NSLog(@"Picked Image...");
        
        //if (newMedia)
        /*
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:upIMG:contextInfo:),
                                           nil);
        */
        
        /*
         // orientation fix
        if (image.imageOrientation == UIImageOrientationUp) {
            // good
        }
        else{
            UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
            [image drawInRect:(CGRect){0, 0, image.size}];
            UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            image = normalizedImage;
        }
         */
        
        NSData *imageData = UIImageJPEGRepresentation(newImage, 0.5);
        
        if (imageData != nil)
        {
            NSLog(@"Starting...");
            
            NSString *User = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_id"];
            NSString *Pass = [[NSUserDefaults standardUserDefaults] stringForKey:@"user_pass"];
            NSString *Key = @"key";
            
            NSString *urlString = @"http://45.55.157.207/python/upload_profile.py";
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"POST"];
            
            NSString *boundary = @"---------------------------147378098314664998827466414495";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"u_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[User dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"u_pass\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[Pass dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"p_chk\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[Key dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"image\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imageData]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            // setting the body of the post to the reqeust
            [request setHTTPBody:body];
            // now lets make the connection to the web
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            
            NSLog(@"Out: %@", returnString);
            
          
            [self updateInfo];
            
        }
        

        
        
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image upIMG:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
    }else{
        
    //

        
        
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logoutButton{
    
   // NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
   // [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        
   //[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"logginout"];
    
    /*
    NSDictionary * dict = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (id key in dict) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }*/
    
   // [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"loggedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
   // AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
   // InitView *vc = [[InitView alloc] init];
   // UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
   // [appDelegate.window setRootViewController:vc2];
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
    
}



- (IBAction)changePass{
    
   
}

- (IBAction)deleteProf{
    UIAlertView *alt = [[UIAlertView alloc]
                        initWithTitle: @"Are you sure you want to delete your account?"
                        message: nil
                        delegate: nil
                        cancelButtonTitle:@"Cancel"
                        otherButtonTitles:@"Yes", nil];
    [alt show];
    
}

- (IBAction)ageBTN{
    UIAlertView *age = [[UIAlertView alloc]
                          initWithTitle: @"This can not be changed."
                          message: nil
                          delegate: nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [age show];
    
}

- (IBAction)saveButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButton{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actionBTN:(id)sender{
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:[sender tag]] forKey:@"pageListID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SignupOptions *vc = [[SignupOptions alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];
    
}


-(void)actionCNY:(id)sender{
    SLCountryPickerViewController *vc = [[SLCountryPickerViewController alloc]init];
    vc.completionBlock = ^(NSString *country, NSString *code){
        [_countryButton2 setTitle:country forState:UIControlStateNormal];
        //_countryImageView.image = [UIImage imageNamed:code];
        //_countryCodeLabel.text = code;
        
        NSString *text = country;
        
    };
    
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:vc2 animated:YES completion:nil];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 3:
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
        return 22;
    if (section == 1)
        return 20;
    if (section == 2)
        return 20;
    if (section == 3)
        return 20;
    //if (section == 4)
    //   return 40;
    return 20; //tableView.sectionHeaderHeight
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return 1;
    if (section == 1)
        return 1;
    if (section == 2)
        return 1;
    if (section == 7)
        return 200;
    return 1; // tableView.sectionFooterHeight
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 100;
    }
    // tableView.rowHeight +
    return 60.0f;
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
            {
                [cell addSubview:_profPic];
                break;
            }
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                [cell addSubview:_userLabel];
                [cell addSubview:_usernameField];
                break;
            }
            case 1:
            {
                [cell addSubview:_userLabel2];
                [cell addSubview:_fullnameField];
                break;
            }
            case 2:
            {
                [cell addSubview:_userLabel3];
                [cell addSubview:_emailField];
                break;
            }
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                [cell addSubview:_bioField];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                [cell addSubview:_countryButton2];
                break;
            case 1:
                [cell addSubview:_regionButton2];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 4) {
        switch (indexPath.row) {
            case 0:
                [cell addSubview:_passwordButton];
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 5) {
        switch (indexPath.row) {
            case 0:
                [cell  addSubview: _typeButton]; //cell.contentView
                break;
            default:
                break;
                
        }
        
    }
    
    if (indexPath.section == 6) {
        switch (indexPath.row) {
            case 0:
                [cell  addSubview: _ageButton]; //cell.contentView
                break;
            default:
                break;
                
        }
        
    }
    
    if (indexPath.section == 7) {
        switch (indexPath.row) {
            case 0:
                [cell  addSubview: _loginOut]; //cell.contentView
                break;
            default:
                break;
                
        }
        
    }
#pragma - might make parts a global veriable
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    mainView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger) section
{
    if (section == 0) {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = NSLocalizedString(@"Profile Pic", @"Photo");
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        
        return lbl;
    }
    if (section == 1) {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = NSLocalizedString(@"User Info", @"Info");
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        return lbl;
    }
    if (section == 2) {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = NSLocalizedString(@"Bio", @"Bio");
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        return lbl;
    }
    if (section == 3) {
        UILabel *lbl = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        lbl.textAlignment = NSTextAlignmentCenter;
        lbl.text = NSLocalizedString(@"Current Location", @"Location");
        [lbl setFont:[UIFont fontWithName:@"Helvetica" size:17]];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        return lbl;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger) section
{
    if (section == 7) {

        return _deleteAcct;
    }
    return 0;
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
