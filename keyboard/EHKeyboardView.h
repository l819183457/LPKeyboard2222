//
//  EHKeyboardView.h
//  ceshi
//
//  Created by pill on 2018/10/16.
//  Copyright © 2018年 LP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EHKeyboardViewDelegate <NSObject>

-(void)getKeyboardNum:(NSString *)num;
-(void)keyBoardDelete;
-(void)keyBoardHidden;

@end



@interface EHKeyboardView : UIView


@property (nonatomic,weak) id<EHKeyboardViewDelegate>keyboardDelegate;

@end

NS_ASSUME_NONNULL_END
