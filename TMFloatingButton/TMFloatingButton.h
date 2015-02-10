//
//  FloatingButton.h
//  Hagtap
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Ihor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMFloatingButtonState : NSObject
/**
 *  State(style) object of TMFloatingButton. State shoud have the same size(bounds) as TMFloatingButton
 *
 *  @param view    Custom view:labels,images combinations
 *  @param bgColor Background color
 *
 *  @return inited TMFloatingButtonState object
 */
- (id)initWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor;
@property (nonatomic, readonly, strong) UIView *view;
@property (nonatomic, readonly, strong) UIColor *bgColor;
@end
/**
 TMFloatingButton's postion on super view
 */
typedef enum {
    FloatingButtonPositionTopLeft,
    FloatingButtonPositionTopRight,
    FloatingButtonPositionBottomLeft,
    FloatingButtonPositionBottomRight
}FloatingButtonPosition;
/**
 TMFloatingButton's hide derection
 */
typedef enum {
    FloatingButtonHideDirectionLeft,
    FloatingButtonHideDirectionRight,
    FloatingButtonHideDirectionUp,
    FloatingButtonHideDirectionDown
}FloatingButtonHideDirection;

//button that can animation hide and change different view stetes
@interface TMFloatingButton : UIButton
/**
 *  init's TMFloatingButton object after this you can apply styles
 *
 *  @param width         Float value width and heigth of Button, Button is square
 *  @param margin        Margin from sides of Superview
 *  @param postion       Position of Button. It can be located in one of four corners
 *  @param hideDirection Direction to hide. Button can be hidden to one of four dirrection
 *  @param superView     UIView where Button will be shown
 *
 *  @return Inited and Added to superView TMFloatingButton object
 */
- (id)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andPosition:(FloatingButtonPosition)postion andHideDirection:(FloatingButtonHideDirection)hideDirection andSuperView:(UIView *)superView;
/**
 *  Set this property to NO if need Square button, or YES to Round Button
 */
@property (assign, nonatomic) BOOL isRounded;
/**
 *  Set this property to NO to HIDE shadow , or YES to SHOW shadow
 */
@property (assign, nonatomic) BOOL showShadow;
/**
 *  Hides Button
 *
 *  @param animated YES - animated and NO - not animated
 */
- (void)hideAnimated:(BOOL)animated;
/**
 *  Shows Button
 *
 *  @param animated YES - animated and NO - not animated
 */
- (void)showAnimated:(BOOL)animated;
/**
 *  Start animate ActivityIndicator on Button. Main staf shoud be doing in other thred. see ex.
 *
 *  @param animate YES - to START animate and NO to STOP
 */
- (void)animateActivityIndicatorStart:(BOOL)animate; //YES to start & NO to stop
/**
 *  Adds state(style) of Button
 *
 *  @param state     FloatingButtonState object
 *  @param stateName State Name to SET this state in other method
 */
- (void)addState:(TMFloatingButtonState *)state forName:(NSString *)stateName;
/**
 *  Sets state with next name
 *
 *  @param name State's name
 */
- (void)setButtonState:(NSString *)name;
//STYLES
/**
 *  Applies FavoritesStyle to Button
 *
 *  @param button Button to set
 */
+ (void)addFavoritesStyleToButton:(TMFloatingButton *)button;
/**
 *  Applies ModeEdit Style to Button
 *
 *  @param button Button to set
 */
+ (void)addModeEditStyleToButton:(TMFloatingButton *)button;
/**
 *  Applies Message Style to Button
 *
 *  @param button Button to set
 */
+ (void)addMessageStyleToButton:(TMFloatingButton *)button;


@end
