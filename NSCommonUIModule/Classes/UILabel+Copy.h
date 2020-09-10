//
//  UILabel+Copy.h
//  BiGuiYuan
//
//  Created by 华惠金服 on 2017/12/21.
//  Copyright © 2017年 Mr_zhaohy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@interface UILabel(Copy)
@property (nonatomic,assign) BOOL isCopyable;
-(instancetype)initWithFrame:(CGRect)frame textColor:(UIColor*)textColor text:(NSString*)text font:(UIFont*)font alignment:(NSTextAlignment)alignment adjustsFont:(BOOL)adjustsFont;
+(instancetype)initWithFrame:(CGRect)frame textColor:(UIColor*)textColor fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment numberLines:(CGFloat)numberLines;
@end
