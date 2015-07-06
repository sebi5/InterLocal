//
//  EditProfilePage.h
//  PenPalApp2.3
//
//  Created by Computer on 6/4/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface EditProfilePage : UIViewController<UIImagePickerControllerDelegate, UIAlertViewDelegate, UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate, UINavigationControllerDelegate>{
    
    UITableView *mainView;
    UIImageView *imageView;
}

@property (strong) UIActivityIndicatorView *mySpinner;

@end
