//
//  LPAutoKeyboardTextField.m
//  LPKeyboard
//
//  Created by pill on 2018/12/7.
//  Copyright © 2018 LP. All rights reserved.
//

#import "LPAutoKeyboardTextField.h"

#import "LPKeyboardView.h"
#import "UITextField+Extension.h"

@interface LPAutoKeyboardTextField ()<LPKeyboardViewDelegate>

@end

@implementation LPAutoKeyboardTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        LPKeyboardView * view1 = [[LPKeyboardView alloc]init];
        view1.keyboardType = 1;
        view1.delegate = self;
        self.inputView = view1;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        LPKeyboardView * view1 = [[LPKeyboardView alloc]init];
        view1.keyboardType = 1;
        view1.delegate = self;
        self.inputView = view1;
    }
    return self;
}
-(void)keyboardView:(id)target changeKeyboard:(nullable NSString * )str atKeyboard:( NSInteger )type
{
    
}
-(void)keyboardView:(id)target inputStr:(nonnull NSString *)str atKeyboard:( NSInteger )type
{
   [self insertText:str];
    
}
-(void)keyboardView:(id)target deleteKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type
{
    [self deleteBackward];
    
}
-(void)keyboardView:(id)target doneKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type{
    [self resignFirstResponder];
}

@end
