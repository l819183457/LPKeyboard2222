//
//  LPKeyboardView.h
//  LPKeyboard
//
//  Created by pill on 2018/11/28.
//  Copyright © 2018 LP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPKeyboardBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LPKeyboardTypeDefault,                // Default type for the current input method.
    LPKeyboardTypeNumberPad,              // A number pad with locale-appropriate digits (0-9,
} LPKeyboardType;

@protocol LPKeyboardViewDelegate <NSObject>
@required // 必须实现的方法
-(void)keyboardView :(id)target changeKeyboard:(nullable NSString * )str atKeyboard:( NSInteger )type;
-(void)keyboardView :(id)target inputStr:(nonnull NSString *)str atKeyboard:( NSInteger )type ;
-(void)keyboardView:(id)target deleteKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type;
@optional // 可选实现的方法
-(void)keyboardView:(id)target doneKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type;
@end


@interface LPKeyboardView : UIView {
    LPKeyboardType  _keyboardType;
}
@property (nonatomic,weak) id<LPKeyboardViewDelegate>delegate;
@property (nonatomic,assign) LPKeyboardType  keyboardType;

@end

NS_ASSUME_NONNULL_END
