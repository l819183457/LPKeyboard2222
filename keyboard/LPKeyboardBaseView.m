//
//  LPKeyboardBaseView.m
//  LPKeyboard
//
//  Created by pill on 2018/11/29.
//  Copyright © 2018 LP. All rights reserved.
//

#import "LPKeyboardBaseView.h"

@implementation LPKeyboardBaseView


#pragma mark - tool
-(UIColor *)bgColor {
    return [self keyboardColorWithHexString:@"0xd1d5db"];
}

- (UIImage *)keyboardImageWithColor:(UIColor *)color  size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f,size.width ,size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (UIColor *) keyboardColorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}





-(UIButton *)createBtn:(NSString *)title addTarget:target  action:(SEL)action {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:20];
    btn.backgroundColor = [UIColor redColor];
    [btn setBackgroundImage:[self keyboardImageWithColor:[UIColor whiteColor] size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    btn.layer.cornerRadius =4;
    btn.layer.masksToBounds =YES;

    
    [btn setBackgroundImage:[self keyboardImageWithColor:LPUIColorFromRGB(0xd1d5db) size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(UIButton *)createBtnImage:(NSString *)imageName addTarget:target  action:(SEL)action {
    return  [self createBtnImage:imageName selectImage:nil addTarget:target action:action];
}
-(UIButton *)createBtnImage:(NSString *)imageName selectImage:(nonnull UIImage *)selectImage addTarget:target  action:(SEL)action {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    if (selectImage) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    }
    btn.layer.cornerRadius =2;
        btn.layer.masksToBounds =YES;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[self keyboardImageWithColor:[UIColor whiteColor] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[self keyboardImageWithColor:LPUIColorFromRGB(0xd1d5db) size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    return btn;
}
@end
