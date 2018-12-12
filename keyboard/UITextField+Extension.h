//
//  UITextField+Extension.h
//  LPKeyboard
//
//  Created by pill on 2018/12/11.
//  Copyright © 2018 LP. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Extension)
- (NSRange) selectedRange;  //获取光标的位置

- (void) setSelectedRange:(NSRange) range;  //设置光标位置
@end

NS_ASSUME_NONNULL_END
