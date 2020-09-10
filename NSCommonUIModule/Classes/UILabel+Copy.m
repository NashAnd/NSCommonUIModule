//
//  UILabel+Copy.m
//  BiGuiYuan
//
//  Created by 华惠金服 on 2017/12/21.
//  Copyright © 2017年 Mr_zhaohy. All rights reserved.
//

#import "UILabel+Copy.h"
@implementation UILabel(Copy)
+(instancetype)initWithFrame:(CGRect)frame textColor:(UIColor*)textColor fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment numberLines:(CGFloat)numberLines{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textAlignment = alignment;
    label.numberOfLines = numberLines;
    return label;
}

-(instancetype)initWithFrame:(CGRect)frame textColor:(UIColor*)textColor text:(NSString*)text font:(UIFont*)font alignment:(NSTextAlignment)alignment adjustsFont:(BOOL)adjustsFont{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = textColor;
        self.text = text?:@"";
        self.font = font?:[UIFont systemFontOfSize:15];
        self.textAlignment = alignment;
        self.adjustsFontSizeToFitWidth = adjustsFont;
    }
    return self;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:g];
}

//  处理手势相应事件
- (void)handleTap:(UIGestureRecognizer *)g {
    [self becomeFirstResponder];
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    
}

//  复制时执行的方法
- (void)copyText:(id)sender {
    //  通用的粘贴板
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    
    //  有些时候只想取UILabel的text中的一部分
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        
        //  因为有时候 label 中设置的是attributedText
        //  而 UIPasteboard 的string只能接受 NSString 类型
        //  所以要做相应的判断
        if (self.text) {
            pBoard.string = self.text;
        } else {
            pBoard.string = self.attributedText.string;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

- (void)setIsCopyable:(BOOL)number {
    objc_setAssociatedObject(self, @selector(isCopyable), [NSNumber numberWithBool:number], OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}

- (BOOL)isCopyable {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

@end
