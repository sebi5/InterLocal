//
//  SignupPage.h
//  PenPalApp2.3
//
//  Created by Computer on 4/13/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *gV_signup_age;

extern UITextField *nameTextField;
extern UITextField *emailTextField;
extern UITextField *passwordTextField;
extern UITextField *usernameTextField;
extern UITextField *birthTextField;
extern UIButton *genderButton;
extern UIButton *countryButton;
extern UIButton *regionButton;
extern UIButton *birthButton;

@interface SignupPage : UIViewController<UIAlertViewDelegate, UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate>{
    UITableView *mainView;
    
}

- (IBAction)cancelButton;
- (IBAction)submitButton;
//@property(nonatomic,strong)ServerResponse *serverResponse;

@property (strong) UIActivityIndicatorView *mySpinner;

@end
