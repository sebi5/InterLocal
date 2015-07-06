//
//  BOTextTableViewCellSecure.h
//  Bohr
//
//  Created by David Román Aguirre on 5/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTableViewCell.h"
//#import "BOTextTableViewCell.h"

/*
typedef NS_ENUM(NSInteger, BOTextFieldInputError) {
    BOTextFieldInputEmptyError,
    BOTextFieldInputTooShortError
};
 */

@class BOTextTableViewCellSecure;
//typedef void(^BOTextFieldInputErrorBlock)(BOTextTableViewCellSecure *cell, BOTextFieldInputError error);

@interface BOTextTableViewCellSecure : BOTableViewCell <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic) NSInteger minimumTextLength;
@property (nonatomic) NSInteger maximumTextLength;
@property (nonatomic) NSInteger input_id;

//@property (nonatomic, copy) BOTextFieldInputErrorBlock textFieldInputFailedBlock;

+ (instancetype)cellWithTitle:(NSString *)title setting:(BOSetting *)setting placeholder:(NSString *)placeholder minimumTextLength:(NSInteger)minimumTextLength maximumTextLength:(NSInteger)maximumTextLength input_id:(NSInteger)input_id;

@end
