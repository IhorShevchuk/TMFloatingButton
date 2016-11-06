//
//  TMFloatingButtonView.h
//  FloatingButton
//
//  Created by Admin on 3/25/16.
//  Copyright © 2016 Techmagic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMFloatingButtonView : UIView
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param view    Custom view:labels,images combinations
 *  @param bgColor Background color
 *
 *  @return inited TMFloatingButtonView object
 */
- (instancetype)initWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor NS_DESIGNATED_INITIALIZER;
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param text    Text for state
 *  @param bgColor Background color
 *
 *  @return inited TMFloatingButtonView object
 */
- (instancetype)initWithText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor NS_DESIGNATED_INITIALIZER;
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param icon    Icon that will be in center on the button
 *  @param bgColor Background color
 *
 *  @return inited TMFloatingButtonView object
 */
- (instancetype)initWithIcon:(UIImage *)icon andBackgroundColor:(UIColor *)bgColor NS_DESIGNATED_INITIALIZER;
/**
 *  State(style) object of TMFloatingButton.
 *
 *  @param icon    Icon that will be in center on the button
 *  @param text    Text for state will be located under icon
 *  @param bgColor Background color
 *
 *  @return inited TMFloatingButtonView object
 */
- (instancetype)initWithIcon:(UIImage *)icon andText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor NS_DESIGNATED_INITIALIZER;
@end
