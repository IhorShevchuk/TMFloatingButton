//
//  TMFloatingButtonState.m
//  FloatingButton
//
//  Created by Ihor Shevchuk on 3/25/16.
//  Copyright © 2016 Ihor Shevchuk. All rights reserved.
//

#import "TMFloatingButtonState.h"
#import "TMFloatingButton.h"
#import "UILabel+TMDictionaryAtributes.h"

@implementation TMFloatingButtonState

- (instancetype)initWithView:(TMFloatingButtonView *)view andBackgroundColor:(UIColor *)bgColor {
    self = [super init];
    if (self)
    {
        _view = view;
        _bgColor = bgColor;
    }
    
    return self;
}

- (instancetype)initWithView:(TMFloatingButtonView *)view andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button {
    self = [super init];
    if (self)
    {
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        _view = view;
        _view.frame = button.bounds;
        _bgColor = bgColor;
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button {
    self = [self initWithIcon:nil andText:text withAttributes:attributes andBackgroundColor:bgColor forButton:button];
    return self;
}

- (instancetype)initWithIcon:(UIImage *)icon andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button
{
    self = [self initWithIcon:icon andText:nil withAttributes:@{} andBackgroundColor:bgColor forButton:button];
    return self;
}

- (instancetype)initWithIcon:(UIImage *)icon andText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button {
    TMFloatingButtonView *stateView = nil;
    if(text != nil && icon != nil)
    {
        stateView = [[TMFloatingButtonView alloc] initWithIcon:icon andText:text withAttributes:attributes andBackgroundColor:bgColor];
    }
    else if(text != nil)
    {
        stateView = [[TMFloatingButtonView alloc]initWithText:text withAttributes:attributes andBackgroundColor:bgColor];
    }
    else if(icon != nil)
    {
        stateView = [[TMFloatingButtonView alloc]initWithIcon:icon andBackgroundColor:bgColor];
    }
    stateView.userInteractionEnabled = NO;
    self = [self initWithView:stateView andBackgroundColor:bgColor forButton:button];
    return self;
}
@end
