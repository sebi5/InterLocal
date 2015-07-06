//
//  BirthdatePage.h
//  PenPalApp2.3
//
//  Created by Computer on 5/13/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *gV_bday;

@interface BirthdatePage : UIViewController <UIAlertViewDelegate>{
    UITableView *mainView;
    UIDatePicker *birthdate;
}

@property (nonatomic, copy) void (^completionBlock)(NSString *country);
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
