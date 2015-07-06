//
//  BOEditProfileDetail.m
//  PenPalApp2.3
//
//  Created by Computer on 6/29/15.
//  Copyright (c) 2015 Computer. All rights reserved.
//

#import "BOEditProfileDetail.h"

@interface BOEditProfileDetail ()

@end

@implementation BOEditProfileDetail

- (void)setup {
    
    self.title = @"More settings";
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1];
    
    BOTableViewSection *section1 = [BOTableViewSection sectionWithTitle:nil];
    [section1 addCells:@[
      [BOSwitchTableViewCell cellWithTitle:@"Switch setting 3" setting:[BOSetting settingWithDefaultValue:@YES forKey:@"bool_3"]],
      [BOSwitchTableViewCell cellWithTitle:@"Switch setting 4" setting:[BOSetting settingWithDefaultValue:@YES forKey:@"bool_4"]],
      [BOSwitchTableViewCell cellWithTitle:@"Switch setting 5" setting:[BOSetting settingWithDefaultValue:@NO forKey:@"bool_5"]],
                         ]];
    
    [self addSections:@[section1]];
    
}

@end
