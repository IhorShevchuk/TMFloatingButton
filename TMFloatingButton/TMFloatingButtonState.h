//
//  TMFloatingButtonState.h
//  FloatingButton
//
//  Created by Admin on 3/25/16.
//  Copyright © 2016 Techmagic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TMFloatingButtonView.h"

@class TMFloatingButton;
//@class TMFloatingButtonView;
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
- (id)initWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param text    Text for state
 *  @param bgColor Background color
 *  @param button  The TMFloatingButton object for that state is being created
 *
 *  @return inited TMFloatingButtonState object
 */
- (id)initWithText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param icon    Icon that will be in center on the button
 *  @param bgColor Background color
 *  @param button  The TMFloatingButton object for that state is being created
 *
 *  @return inited TMFloatingButtonState object
 */
- (id)initWithIcon:(UIImage *)icon andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;
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
- (id)initWithIcon:(UIImage *)icon andText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;

@property (nonatomic, readonly, strong) TMFloatingButtonView *view;
@property (nonatomic, readonly, strong) UIColor *bgColor;
@end