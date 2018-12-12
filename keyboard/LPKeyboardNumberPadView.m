//
//  LPKeyboardNumberPadView.m
//  LPKeyboard
//
//  Created by pill on 2018/11/29.
//  Copyright © 2018 LP. All rights reserved.
//

#import "LPKeyboardNumberPadView.h"

@interface LPKeyboardNumberPadView ()
@property (nonatomic,strong) NSMutableArray * keyboardArray;
@property (nonatomic,strong) NSMutableArray * keyboardBtnArray;
@property (nonatomic,strong) NSMutableArray * keyboardLineArray;

@end


@implementation LPKeyboardNumberPadView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        _keyboardArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"]];
        _keyboardBtnArray = [NSMutableArray array];
        _keyboardLineArray = [NSMutableArray array];
        [self buildBtn];
    }
    return self;
}
-(void)buildBtn {
    for (int i = 0; i<_keyboardArray.count; i++) {
        UIButton * btn = [self createBtn:_keyboardArray[i] addTarget:self action:@selector(clickBtn:)];
        btn.layer.cornerRadius = 0;
        [_keyboardBtnArray addObject:btn];
        [self addSubview:btn];
        
    }
    if (_keyboardBtnArray.count > 1) {
        [_keyboardBtnArray insertObject:[self getHiddenBtn] atIndex:_keyboardBtnArray.count -1];
        [_keyboardBtnArray addObject:[self getDeleteBtn]];
    }
    for(NSUInteger i = 0;i < (2+ _keyboardBtnArray.count / 3);i++) {
        UIImageView * line = [[UIImageView alloc]init];
        line.backgroundColor =LPUIColorFromRGB(0xc7c7c7);
        [self addSubview:line];
        [_keyboardLineArray addObject:line];
    }
}
-(UIButton *)getHiddenBtn {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"ABC" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickABC) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self keyboardImageWithColor:[UIColor whiteColor] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[self keyboardImageWithColor:LPUIColorFromRGB(0xd1d5db) size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}

-(UIButton *)getDeleteBtn {
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"keyborad_delete"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[self keyboardImageWithColor:[UIColor whiteColor] size:CGSizeMake(100, 100)] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[self keyboardImageWithColor:LPUIColorFromRGB(0xd1d5db) size:CGSizeMake(100, 100)] forState:UIControlStateNormal];
    [self addSubview:btn];
    return btn;
}
-(void)clickDelete {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:deleteKeyboard:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self deleteKeyboard:@"" atKeyboard:self.type];
    }
}
-(void)clickHidden {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:changeKeyboard:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self changeKeyboard:@"" atKeyboard:self.type];
    }
}
-(void)clickABC {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:changeKeyboard:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self changeKeyboard:@"" atKeyboard:self.type];
    }
}
-(void)clickBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(keyboardBaseView:inputStr:atKeyboard:)]) {
        [self.delegate keyboardBaseView:self inputStr:sender.currentTitle atKeyboard:self.type];
    }
}


-(void)layoutSubviews  {
    
    [super layoutSubviews];
    CGFloat height = self.bounds.size.height /4.;
    CGFloat width = self.bounds.size.width /3.;
    self.frame = CGRectMake(0, 0 , LP_Width, (_keyboardBtnArray.count / 3) * height );
    for (int i = 0; i < _keyboardBtnArray.count / 3; i++) {
        for (int j = 0; j < 3; j++) {
            UIButton * btn = _keyboardBtnArray[i * 3 + j];
            btn.frame = CGRectMake( width * j , height * i, width, height);
        }
    }
    if (_keyboardLineArray.count >2) {
        
        for (int i = 0; i < _keyboardLineArray.count; i++) {
            UIImageView * line =   _keyboardLineArray[i];
            if (i < 2) {
                line.frame = CGRectMake(width * (i+1),  0, LP_Line_05, (_keyboardBtnArray.count / 3) * height);
            }else {
                line.frame = CGRectMake(0, height * (i - 2),LP_Width , LP_Line_05);
            }
        }
    }
    
}
@end
