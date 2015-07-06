//
//  BOEditProfile.m
//  PenPalApp2.3
//
//  Created by Computer on 6/29/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "BOEditProfile.h"
#import "BirthdatePage.h"

#import "BOEditProfileDetail.h"

@interface BOEditProfile ()

@property (nonatomic, strong) BOEditProfileDetail *detailViewController;
@property (nonatomic, strong) NSString *bDate;

@end

@implementation BOEditProfile

@synthesize bDate = _bDate;

-(void)viewWillAppear:(BOOL)animated{
    
    _bDate = @"Birthdate2";

}

- (void)setup {
    
    _bDate = @"Birthdate";
    
    //self.title = @"Profile";
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
    self.detailViewController = [[BOEditProfileDetail alloc] initWithStyle:UITableViewStyleGrouped];
    
    BOTableViewSection *section1 = [BOTableViewSection sectionWithTitle:@""];
    [section1 addCells:@[
                         
    [BOTextTableViewCell cellWithTitle:@"Username" setting:[BOSetting settingWithDefaultValue:@"" forKey:@"text"] placeholder:@"Username" minimumTextLength:1 maximumTextLength:20 input_id:1 textFieldInputFailedBlock:[self textFieldInputFailedBlock]],

    [BOTextTableViewCell cellWithTitle:@"Name" setting:[BOSetting settingWithDefaultValue:@"" forKey:@"text2"] placeholder:@"Name" minimumTextLength:1 maximumTextLength:20 input_id:2 textFieldInputFailedBlock:[self textFieldInputFailedBlock]],
    
    [BOTextTableViewCellSecure cellWithTitle:@"Password" setting:[BOSetting settingWithDefaultValue:@"" forKey:@"text3"] placeholder:@"Password" minimumTextLength:1 maximumTextLength:20 input_id:7],
    
       [BOTextTableViewCell cellWithTitle:@"Email" setting:[BOSetting settingWithDefaultValue:@"" forKey:@"email"] placeholder:@"Email" minimumTextLength:1 maximumTextLength:20 input_id:2 textFieldInputFailedBlock:[self textFieldInputFailedBlock]],
    
    // button
  [BOButtonTableViewCell cellWithTitle:_bDate didTriggerBlock:[self buttonDidTriggerBlock2]]
    
                         ]];
    
    BOTableViewSection *section2 = [BOTableViewSection sectionWithTitle:@"Section 2"];
    [section2 addCells:@[
      [BOTextTableViewCell cellWithTitle:@"Text setting" setting:[BOSetting settingWithDefaultValue:@"" forKey:@"text"] placeholder:@"Placeholder" minimumTextLength:0 maximumTextLength:20 input_id:4 textFieldInputFailedBlock:[self textFieldInputFailedBlock]],
                         
        [BOChoiceTableViewCell cellWithTitle:@"Choice setting" setting:[BOSetting settingWithDefaultValue:@1 forKey:@"option"] options:@[@"Option 1", @"Option 2", @"Option 3"]],
                         
      
                         
[BODisclosureTableViewCell cellWithTitle:@"Disclosure cell" destinationViewController:self.detailViewController],
                         ]];
    
    BOTableViewSection *section3 = [BOTableViewSection sectionWithTitle:@"Hi"];
    //section3.footerTitle = @"A footer title can be easily set too.";
    [section3 addCells:@[[BOButtonTableViewCell cellWithTitle:@"Button" didTriggerBlock:[self buttonDidTriggerBlock]]
                         ]];
    
    [self addSections:@[section1, section2, section3]];
    
}

- (void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (BOTextFieldInputErrorBlock)textFieldInputFailedBlock {
    __unsafe_unretained typeof(self) weakSelf = self;
    
    return ^(BOTextTableViewCell *cell, BOTextFieldInputError error) {
        NSString *message = error == BOTextFieldInputEmptyError ? @"The text field can't be empty" : @"The text is too short";
        [weakSelf presentAlertControllerWithTitle:@"Error" message:message];
    };
}

- (void (^)(void))buttonDidTriggerBlock2 {
    __unsafe_unretained typeof(self) weakSelf = self;
    
    return ^{
        BirthdatePage *vc = [[BirthdatePage alloc] init];
        UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
        [weakSelf presentViewController:vc2 animated:YES completion:nil];
        
        vc.completionBlock = ^(NSString *country){
            //Your code here
            _bDate = @"t";
            [self setup];
            [BOButtonTableViewCell cellWithTitle:@"test" didTriggerBlock:[self buttonDidTriggerBlock2]];
            
           // [BOTextTableViewCell.detailTextLabel.text setText:@"hi"];
            
            NSLog(@"C:%@", country);
       
            //self.detailTextLabel.text = @"";
            //_countryNameLabel.text = country;
            
        };
    };
}

- (void (^)(void))buttonDidTriggerBlock {
    __unsafe_unretained typeof(self) weakSelf = self;
    
    return ^{
        [weakSelf presentAlertControllerWithTitle:@"Button tapped!" message:nil];
    };
}

-(void)actionBTNBday:(id)sender{
    
    BirthdatePage *vc = [[BirthdatePage alloc] init];
    UINavigationController *vc2 = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:vc2 animated:YES completion:nil];
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

@end
