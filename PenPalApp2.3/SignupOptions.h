//
//  SignupOptions.h
//  PenPalApp2.3
//
//  Created by Computer on 4/13/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSUInteger gV_region;
extern NSString *gV_region_list;
extern NSString *gV_city_list;
extern NSArray *gV_regions;


@interface SignupOptions : UIViewController<UITableViewDelegate,UITableViewDataSource>{
     UITableView *mainView;
 
}


- (IBAction)cancelButton;

@property (nonatomic, copy) void (^completionBlock)(NSString *data);
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@property(nonatomic, readonly) NSString *localizedTitle;

@end
