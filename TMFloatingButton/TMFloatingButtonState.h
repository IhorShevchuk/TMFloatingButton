//
//  TMFloatingButtonState.h
//  FloatingButton
//
//  Created by Ihor Shevchuk on 3/25/16.
//  Copyright © 2016 Ihor Shevchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TMFloatingButtonView.h"

@class TMFloatingButton;

@interface TMFloatingButtonState : NSObject
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param view    Custom view:labels,images combinations
 *  @param bgColor Background color
 *  @param button  The TMFloatingButton object for that state is being created
 *
 *  @return inited TMFloatingButtonState object
 */
- (instancetype)initWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param text    Text for state
 *  @param bgColor Background color
 *  @param button  The TMFloatingButton object for that state is being created
 *
 *  @return inited TMFloatingButtonState object
 */
- (instancetype)initWithText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param icon    Icon that will be in center on the button
 *  @param bgColor Background color
 *  @param button  The TMFloatingButton object for that state is being created
 *
 *  @return inited TMFloatingButtonState object
 */
- (instancetype)initWithIcon:(UIImage *)icon andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param icon    Icon that will be in center on the button
 *  @param text    Text for state will be located under icon
 *  @param bgColor Background color
 *  @param button  The TMFloatingButton object for that state is being created
 *
 *  @return inited TMFloatingButtonState object
 */
- (instancetype)initWithIcon:(UIImage *)icon andText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;

@property (nonatomic, readonly, strong) TMFloatingButtonView *view;
@property (nonatomic, readonly, strong) UIColor *bgColor;
@end
