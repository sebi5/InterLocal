//
//  BOTextTableViewCellSecure.m
//  Bohr
//
//  Created by David Román Aguirre on 5/6/15.
//  Copyright (c) 2015 David Roman. All rights reserved.
//

#import "BOTextTableViewCellSecure.h"
//#import "BOTextTableViewCell.h"
#import "BOTableViewCell+Subclass.h"

@implementation BOTextTableViewCellSecure

+ (instancetype)cellWithTitle:(NSString *)title setting:(BOSetting *)setting placeholder:(NSString *)placeholder minimumTextLength:(NSInteger)minimumTextLength maximumTextLength:(NSInteger)maximumTextLength input_id:(NSInteger)input_id  {
    BOTextTableViewCellSecure *cell = [super cellWithTitle:title setting:setting];
    cell.textField.placeholder = placeholder;
    cell.minimumTextLength = minimumTextLength;
    cell.maximumTextLength = maximumTextLength;
    cell.input_id = input_id;
    //cell.textFieldInputFailedBlock = textFieldInputFailedBlock;
    return cell;
}

- (void)setup {
    self.textField = [UITextField new];
    self.textField.delegate = self;
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.secureTextEntry = true;
    //self.textField.backgroundColor = [UIColor blueColor];
    [self.textField setContentVerticalAlignment:UIControlContentVerticalAlignmentFill];
    [self.contentView addSubview:self.textField];
    
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.textField.superview attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.textLabel attribute:NSLayoutAttributeRight multiplier:1 constant:15];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.textField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.textField.superview attribute:NSLayoutAttributeRightMargin multiplier:1 constant:0];
    
    NSLayoutConstraint *height =[NSLayoutConstraint
                                 constraintWithItem:self.textField
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:0
                                 toItem:self.textField.superview
                                 attribute:NSLayoutAttributeHeight
                                 multiplier:0.40
                                 constant:0];
    
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textField.superview addConstraints:@[centerYConstraint, height, leftConstraint, rightConstraint]];
}

- (void)updateAppearance {
    self.textField.textColor = self.secondaryColor;
    self.textField.tintColor = self.secondaryColor;
    
    if (self.secondaryFont) {
        self.textField.font = self.secondaryFont;
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSFontAttributeName : self.secondaryFont}];
    }
}

- (void)settingValueDidChange {
    self.textField.text = self.setting.value;
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= self.maximumTextLength;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    /*
    if (self.minimumTextLength > 0 && [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0) {
        if (self.textFieldInputFailedBlock) self.textFieldInputFailedBlock(self, BOTextFieldInputEmptyError);
    } else if (textField.text.length < self.minimumTextLength) {
        if (self.textFieldInputFailedBlock) self.textFieldInputFailedBlock(self, BOTextFieldInputTooShortError);
    } else {
        self.setting.value = textField.text;
        [textField endEditing:YES];
    }
    */
    [textField endEditing:YES];
    return YES;
}
 

@end
