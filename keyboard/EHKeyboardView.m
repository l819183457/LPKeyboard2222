//
//  EHKeyboardView.m
//  ceshi
//
//  Created by pill on 2018/10/16.
//  Copyright © 2018年 LP. All rights reserved.
//

#import "EHKeyboardView.h"

#define  _height   MAX([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)

#define  _width   MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)
#define line_05  1.f/[UIScreen mainScreen].scale


//色值转换RGB
#define LPUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define  tag 70000

@interface EHKeyboardView ()
{
    NSMutableArray * numArray;
    NSMutableArray * imageArray;
    CGFloat safeBottom;
}
@property (nonatomic,strong) UIView * toobarView;
@property (nonatomic,strong) UILabel * toobarLabel;
@end


@implementation EHKeyboardView
- (instancetype)init
{
    self = [super init];
    if (self) {
        if (@available(iOS 11.0, *)) {
            safeBottom = [UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom;
        } else {
            safeBottom = 0;
        }
        self.backgroundColor = LPUIColorFromRGB(0xd1d5db);
        [self buildUI];
    }
    return self;
}
-(void)buildUI {
    
    self.toobarView = [[UIView alloc]init];
    [self addSubview:self.toobarView];
    
    _toobarLabel = [[UILabel alloc]init];
    _toobarLabel.text = @"安全键盘";
    _toobarLabel.textColor = [UIColor blackColor];
    _toobarLabel.textAlignment = NSTextAlignmentCenter;
    [self.toobarView addSubview:_toobarLabel];
    
    
    NSMutableArray * arr =[NSMutableArray arrayWithArray: @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]];
    numArray = [NSMutableArray array];
    NSInteger length =  arr.count;
    for (NSUInteger i = 0; i < length; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSUInteger index = [self getRandom: arr.count ];
        [btn setTitle:arr[index] forState:UIControlStateNormal];
        [arr removeObjectAtIndex:index];
        [btn setBackgroundImage:[self keyboardImageWithColor:[UIColor whiteColor] size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[self keyboardImageWithColor:LPUIColorFromRGB(0xd1d5db) size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:btn];
        [numArray addObject:btn];
    }
    if (numArray.count > 1) {
        [numArray insertObject:[self getHiddenBtn] atIndex:numArray.count -1];
        [numArray addObject:[self getDeleteBtn]];
    }
    imageArray = [NSMutableArray array];

    for(NSUInteger i = 0;i < (2+ numArray.count / 3);i++) {
        UIImageView * line = [[UIImageView alloc]init];
        line.backgroundColor =LPUIColorFromRGB(0xc7c7c7);
        [self addSubview:line];
        [imageArray addObject:line];
    }
    
    [self layoutSubviews];
}

-(UIButton *)getHiddenBtn {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"收起" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"keyborad_hidden"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickHidden) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[self keyboardImageWithColor:[UIColor whiteColor] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[self keyboardImageWithColor:LPUIColorFromRGB(0xd1d5db) size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}

-(UIButton *)getDeleteBtn {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:@"删除" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"keyborad_delete"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[self keyboardImageWithColor:[UIColor whiteColor] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[self keyboardImageWithColor:LPUIColorFromRGB(0xd1d5db) size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}
-(void)clickBtn:(UIButton *)sender {
    NSLog(@"%@",sender.currentTitle);
    if([_keyboardDelegate respondsToSelector:@selector(getKeyboardNum:)])
    {
        [_keyboardDelegate getKeyboardNum:sender.currentTitle];
    }
}
-(void)clickHidden {
    if([_keyboardDelegate respondsToSelector:@selector(keyBoardHidden)])
    {
        [_keyboardDelegate keyBoardHidden];
    }
}
-(void)clickDelete {
    if([_keyboardDelegate respondsToSelector:@selector(keyBoardDelete)])
    {
        [_keyboardDelegate keyBoardDelete];
    }
}
-(NSUInteger)getRandom:(NSUInteger)fromIndex {
    return  arc4random() % fromIndex ;
}
-(void)layoutSubviews  {
    
    [super layoutSubviews];
    
    self.toobarView.frame = CGRectMake(0, 0, _width, 40);
    self.toobarLabel.frame = self.toobarView.bounds;
    CGFloat w = _width/3;
    CGFloat h = w * 0.4;
    self.frame = CGRectMake(0, 0 , _width, (numArray.count / 3) * h+safeBottom +40 );
    for (int i = 0; i < numArray.count / 3; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton * btn = numArray[i * 3 + j];
            btn.frame = CGRectMake( w * j ,40 + h * i, w, h);
        }
    }
    if (imageArray.count >2) {
        
        for (int i = 0; i < imageArray.count; i++) {
          UIImageView * line =   imageArray[i];
            if (i < 2) {
                line.frame = CGRectMake(w * (i+1), 40 + 0, line_05, (numArray.count / 3) * h);
            }else {
               line.frame = CGRectMake(0,40 + h * (i - 2),_width , line_05);
            }
        }
    }
    
}




#pragma mark - tool
- (UIImage *)keyboardImageWithColor:(UIColor *)color  size:(CGSize)size{
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

@end
