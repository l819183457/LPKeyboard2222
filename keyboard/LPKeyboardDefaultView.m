//
//  LPKeyboardDefaultView.m
//  LPKeyboard
//
//  Created by pill on 2018/11/29.
//  Copyright © 2018 LP. All rights reserved.
//

#import "LPKeyboardDefaultView.h"


@interface LPKeyboardDefaultView ()
@property (nonatomic,strong) NSMutableArray * keyboardArray;
@property (nonatomic,strong) NSMutableArray * keyboardFisrtBtnArray;

@property (nonatomic,strong) NSMutableArray * keyboardsSecondBtnArray;
@property (nonatomic,strong) NSMutableArray * keyboardsThirdBtnArray;


@property (nonatomic,strong) UIButton * upCapitalBtn;
@property (nonatomic,strong) UIButton * deleteBtn;
@property (nonatomic,strong) UIButton * changeNumBtn;
@property (nonatomic,strong) UIButton * spaceBtn;
@property (nonatomic,strong) UIButton * goBtn;

@end

@implementation LPKeyboardDefaultView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = self.bgColor;
         _keyboardArray = [NSMutableArray arrayWithArray:@[@"q",@"w",@"e",@"r",@"t",@"y",@"u",@"i",@"o",@"p",@"a",@"s",@"d",@"f",@"g",@"h",@"j",@"k",@"l",@"z",@"x",@"c",@"v",@"b",@"n",@"m",@[@"1",@"2"]]];
        [self buildBtn];
    }
    return self;
}
-(void)buildDefaultData {;
   
}
-(void)buildBtn {
    _keyboardFisrtBtnArray = [NSMutableArray array];
    _keyboardsSecondBtnArray = [NSMutableArray array];
    _keyboardsThirdBtnArray = [NSMutableArray array];
    for (int i = 0; i<10; i++) {
        UIButton * btn = [self createBtn:_keyboardArray[i] addTarget:self action:@selector(clickBtn:)];
        [self addSubview:btn];
        [_keyboardFisrtBtnArray addObject:btn];
    }
    
    for (int i = 10; i<19; i++) {
        UIButton * btn = [self createBtn:_keyboardArray[i] addTarget:self action:@selector(clickBtn:)];
        [self addSubview:btn];
        [_keyboardsSecondBtnArray addObject:btn];
    }
    for (int i = 19; i<26; i++) {
        UIButton * btn = [self createBtn:_keyboardArray[i] addTarget:self action:@selector(clickBtn:)];
        [self addSubview:btn];
        [_keyboardsThirdBtnArray addObject:btn];
    }
    //大写按钮
    _upCapitalBtn = [self createBtnImage:@"keyborad_delete" addTarget:self action:@selector(clickCapital:)];
    [self addSubview:_upCapitalBtn];
    
    //删除
    _deleteBtn = [self createBtnImage:@"keyborad_delete" addTarget:self action:@selector(clickDeleteBtn)];
    [self addSubview:_deleteBtn];
    
    //切换输入法
    _changeNumBtn = [self createBtn:@"123" addTarget:self action:@selector(clickChangeBtn)];
    [self addSubview:_changeNumBtn];
    
    _spaceBtn = [self createBtn:@"space" addTarget:self action:@selector(clickSpaceBtn)];
    [self addSubview:_spaceBtn];
    
    _goBtn = [self createBtn:@"done" addTarget:self action:@selector(clickDoneBtn)];
    [self addSubview:_goBtn];
    
    
}

-(void)clickBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:inputStr:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self inputStr:sender.currentTitle atKeyboard:self.type];
    }
}
-(void)clickChangeBtn {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:changeKeyboard:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self changeKeyboard:@"" atKeyboard:self.type];
    }
}
-(void)clickSpaceBtn {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:inputStr:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self inputStr:@" " atKeyboard:self.type];
    }
}
-(void) clickDeleteBtn {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:deleteKeyboard:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self deleteKeyboard:@"" atKeyboard:self.type];
    }
}
-(void)clickDoneBtn {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:doneKeyboard:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self doneKeyboard:@"" atKeyboard:self.type];
    }
}
-(void)clickCapital:(UIButton *)sender {
    sender.selected = !sender.selected;
    BOOL isDa = NO;
    if (sender.selected) {
        isDa = YES;
    }else {
        isDa = NO;
    }
    for (UIButton * btn in _keyboardFisrtBtnArray) {
        if(isDa) {
            [btn setTitle:btn.currentTitle.uppercaseString forState:UIControlStateNormal];
        }else {
            [btn setTitle:btn.currentTitle.lowercaseString forState:UIControlStateNormal];
        }
    }
    for (UIButton * btn in _keyboardsSecondBtnArray) {
        if(isDa) {
            [btn setTitle:btn.currentTitle.uppercaseString forState:UIControlStateNormal];
        }else {
            [btn setTitle:btn.currentTitle.lowercaseString forState:UIControlStateNormal];
        }
    }
    for (UIButton * btn in _keyboardsThirdBtnArray) {
        if(isDa) {
            [btn setTitle:btn.currentTitle.uppercaseString forState:UIControlStateNormal];
        }else {
            [btn setTitle:btn.currentTitle.lowercaseString forState:UIControlStateNormal];
        }
    }
    
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat padding = 15;
    CGFloat scale = 54./67.;
    CGFloat height = (self.bounds.size.height - padding * 4)/4.;
    CGFloat width = height * scale;
    CGFloat H = 0;
    CGFloat btn_padding = (self.bounds.size.width - width * 10)/10.;
    for (int i = 0 ; i<_keyboardFisrtBtnArray.count; i++ ) {
        UIButton * btn = _keyboardFisrtBtnArray[i];
        btn.frame  = CGRectMake(btn_padding/2. + (width + btn_padding) * i, (padding /3.) * 2, width, height);
    }
    H = height + 1.5 * padding;
    for (int i = 0 ; i<_keyboardsSecondBtnArray.count; i++ ) {
        UIButton * btn2 = _keyboardsSecondBtnArray[i];
        btn2.frame  = CGRectMake(btn_padding + width/2. + (width + btn_padding) * i, H, width, height);
    }
    H = H +  padding + height;
    for (int i = 0 ; i<_keyboardsThirdBtnArray.count; i++ ) {
        UIButton * btn2 = _keyboardsThirdBtnArray[i];
        btn2.frame  = CGRectMake(2 * btn_padding + width *1.5 + (width + btn_padding) * i, H, width, height);
    }
    _upCapitalBtn.frame = CGRectMake(btn_padding/2., H, height, height);
    _deleteBtn.frame = CGRectMake(self.bounds.size.width - btn_padding/2. - height, H, height, height);
    H = H +  padding + height;
    CGFloat bottom_w = (self.bounds.size.width - 3 *btn_padding )/4.;
    _changeNumBtn.frame = CGRectMake(btn_padding/2., H, bottom_w, height);
    _spaceBtn.frame = CGRectMake(btn_padding*1.5 + bottom_w, H, bottom_w *2, height);
    _goBtn.frame = CGRectMake(self.bounds.size.width - btn_padding/2. - bottom_w, H, bottom_w, height);
}








@end
