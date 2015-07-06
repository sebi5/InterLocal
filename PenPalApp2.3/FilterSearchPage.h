//
//  FilterSearchPage.h
//  PenPalApp2.3
//
//  Created by Computer on 6/3/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterSearchPage : UIViewController<UIAlertViewDelegate, UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,NSURLConnectionDelegate>{
    UITableView *mainView;
    UIView *searchPicker;
}

@end
