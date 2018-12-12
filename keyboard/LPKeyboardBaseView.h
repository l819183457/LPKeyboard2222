//
//  LPKeyboardBaseView.h
//  LPKeyboard
//
//  Created by pill on 2018/11/29.
//  Copyright © 2018 LP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//色值转换RGB
#define LPUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define  LP_Height   MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)
#define  LP_Width   MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define  LP_Line_05  1.f/[UIScreen mainScreen].scale



@protocol LPKeyboardBaseViewDelegate <NSObject>
@required // 必须实现的方法
-(void)keyboardBaseView:(id)target changeKeyboard:(nullable NSString * )str atKeyboard:( NSInteger )type;
-(void)keyboardBaseView:(id)target inputStr:(nonnull NSString *)str atKeyboard:( NSInteger )type ;
-(void)keyboardBaseView:(id)target deleteKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type;
@optional // 可选实现的方法
-(void)keyboardBaseView:(id)target doneKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type;
@end



@interface LPKeyboardBaseView : UIView

@property (nonatomic,weak)id<LPKeyboardBaseViewDelegate>delegate;

@property (nonatomic,assign) NSInteger type;



- (UIImage *)keyboardImageWithColor:(UIColor *)color  size:(CGSize)size;

- (UIColor *) keyboardColorWithHexString: (NSString *)color;

-(UIButton *)createBtn:(NSString *)title addTarget:target  action:(SEL)action ;
-(UIButton *)createBtnImage:(NSString *)imageName addTarget:target  action:(SEL)action;
-(UIButton *)createBtnImage:(NSString *)imageName selectImage:(UIImage *)selectImage addTarget:target  action:(SEL)action;





@property (nonatomic,strong) UIColor * bgColor;

@end

NS_ASSUME_NONNULL_END
