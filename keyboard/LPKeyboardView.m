//
//  LPKeyboardView.m
//  LPKeyboard
//
//  Created by pill on 2018/11/28.
//  Copyright © 2018 LP. All rights reserved.
//

#import "LPKeyboardView.h"
#import "LPKeyboardDefaultView.h"
#import "LPKeyboardNumberPadView.h"


@interface LPKeyboardView ()<LPKeyboardBaseViewDelegate>
@property (nonatomic,strong) UIView * contentView;
@property (nonatomic,strong) NSMutableArray * keyboardArray;

@property (nonatomic,strong) LPKeyboardBaseView * tempView;
@property (nonatomic,strong) LPKeyboardDefaultView * keyboardDefaultView;
@property (nonatomic,strong) LPKeyboardNumberPadView * keyboardNumberPadView;


@end

@implementation LPKeyboardView
@synthesize keyboardType = _keyboardType;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _contentView = [[UIView alloc]init];
      
        self.frame =  CGRectMake(0, 0,LP_Line_05, 300);
        self.contentView.backgroundColor = [UIColor redColor];
        [self addSubview:_contentView];
        [self layoutSubviews];
        self.keyboardType = LPKeyboardTypeDefault;
    }
    return self;
}
-(void)buildData {
    
}

-(void)buildDefaultData {;
    _keyboardArray = [NSMutableArray arrayWithArray:@[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m"]];
    
}
-(void)buildNumberPadData {;
    _keyboardArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]];
    
}

- (void)setKeyboardType:(LPKeyboardType)keyboardType {
    if(_keyboardDefaultView ) {
        [_keyboardDefaultView removeFromSuperview];
        _keyboardDefaultView = nil;
    }
    if(_keyboardNumberPadView ) {
        [_keyboardNumberPadView removeFromSuperview];
        _keyboardNumberPadView = nil;
    }
    if(keyboardType == LPKeyboardTypeDefault) {
        _keyboardType = keyboardType;
        _keyboardDefaultView = [[LPKeyboardDefaultView alloc ]init];
        _keyboardDefaultView.delegate = self;
        _keyboardNumberPadView.type = LPKeyboardTypeDefault;
        [_contentView addSubview:_keyboardDefaultView];
       

    }else if(keyboardType == LPKeyboardTypeNumberPad) {
        _keyboardType = keyboardType;
        _keyboardNumberPadView = [[LPKeyboardNumberPadView alloc ]init];
        _keyboardNumberPadView.type = LPKeyboardTypeNumberPad;
        _keyboardNumberPadView.delegate  = self;
        [_contentView addSubview:_keyboardNumberPadView];
        
    }
    [self layoutSubviews];
  
}
-(void)keyboardBaseView:(id)target changeKeyboard:(nullable NSString * )str atKeyboard:( NSInteger )type
{
    if(type == LPKeyboardTypeDefault) {
        self.keyboardType = LPKeyboardTypeNumberPad;
    }else {
        self.keyboardType = LPKeyboardTypeDefault;
    }
}
-(void)keyboardBaseView:(id)target inputStr:(nonnull NSString *)str atKeyboard:( NSInteger )type
{
    if ([_delegate respondsToSelector:@selector(keyboardView:inputStr:atKeyboard:)]) {
        [_delegate keyboardView:self inputStr:str atKeyboard:_keyboardType];
    }
}
-(void)keyboardBaseView:(id)target deleteKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type
{
    if ([_delegate respondsToSelector:@selector(keyboardView:deleteKeyboard:atKeyboard:)]) {
        [_delegate keyboardView:self deleteKeyboard:str atKeyboard:_keyboardType];
    }
}
-(void)keyboardBaseView:(id)target doneKeyboard:(nullable NSString *)str atKeyboard:( NSInteger )type{
    if ([_delegate respondsToSelector:@selector(keyboardView:doneKeyboard:atKeyboard:)]) {
        [_delegate keyboardView:self doneKeyboard:str atKeyboard:_keyboardType];
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat scale = 1.75;
    CGFloat height =  LP_Width/scale;
    
    _contentView.frame = CGRectMake(0, 0, LP_Width, height);
    _keyboardNumberPadView.frame = _contentView.bounds;
    _keyboardDefaultView.frame =_contentView.bounds;
}


@end
