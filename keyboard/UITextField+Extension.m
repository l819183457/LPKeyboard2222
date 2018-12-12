//
//  UITextField+Extension.m
//  LPKeyboard
//
//  Created by pill on 2018/12/11.
//  Copyright © 2018 LP. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)
- (NSRange) selectedRange{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}
// 备注：UITextField必须为第一响应者才有效
- (void) setSelectedRange:(NSRange) range
{
    UITextPosition* beginning = self.beginningOfDocument;
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
    
}



@end
