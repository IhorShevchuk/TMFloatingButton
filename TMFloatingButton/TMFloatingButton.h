//
//  FloatingButton.h
//  Hagtap
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Ihor. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ButtonDefaultSize 60
#define ButtonDefaultMargin 15
@class TMFloatingButton;
@interface TMFloatingButtonState : NSObject
/**
 *  State(style) object of TMFloatingButton. State shoud have the same size(bounds) as TMFloatingButton
 *
 *  @param view    Custom view:labels,images combinations
 *  @param bgColor Background color
 *
 *  @return inited TMFloatingButtonState object
 */
- (id)initWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor DEPRECATED_ATTRIBUTE;
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
 *  init's TMFloatingButton object after this you can apply styles
 *
 *  @param superView UIView where Button will be shown
 *
 *  @return Inited and Added to superView TMFloatingButton object
 */
- (id)initWithSuperView:(UIView *)superView;
/**
 *  init's TMFloatingButton object after this you can apply styles
 *
 *  @param width     Float value width and heigth of Button, Button is square
 *  @param margin    Margin from sides of Superview
 *  @param superView UIView where Button will be shown
 *
 *  @return Inited and Added to superView TMFloatingButton object
 */
- (id)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andSuperView:(UIView *)superView;
/**
 *  init's TMFloatingButton object after this you can apply styles
 *
 *  @param width     Float value width and heigth of Button, Button is square
 *  @param margin    Margin from sides of Superview
 *  @param postion   Position of Button. It can be located in one of four corners
 *  @param superView UIView where Button will be shown
 *
 *  @return Inited and Added to superView TMFloatingButton object
 */
- (id)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andPosition:(FloatingButtonPosition)postion postionandSuperView:(UIView *)superView;

/**
 *  Set this property to NO if need Square button, or YES to Round Button
 */
@property (assign, nonatomic) BOOL isRounded;
/**
 *  Set this property to NO to HIDE shadow , or YES to SHOW shadow
 */
@property (assign, nonatomic) BOOL showShadow;
/**
 *  Size of the button it is square thats why we use one value
 */

//TODO: Change Frame when next properties changed
@property (assign, nonatomic) CGFloat size;
/**
 *  Margin from sides of Superview
 */
@property (assign, nonatomic) CGFloat margin;
/**
 *  Position of Button. It can be located in one of four corners
 */
@property (assign, nonatomic) FloatingButtonHideDirection hideDirection;
/**
 *  Direction to hide. Button can be hidden to one of four dirrection
 */
@property (assign, nonatomic) FloatingButtonPosition position;

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
#pragma mark - STATES MANAGEMENT
- (void)addState:(TMFloatingButtonState *)state forName:(NSString *)stateName;

/**
 *  Creates TMFloatingButtonState object and applies if need
 *
 *  @param icon       Icon that will be in center on the button
 *  @param text       Text for state will be located under icon
 *  @param attributes Text attributes(ex. font size,color et.)
 *  @param bgColor    Background color
 *  @param stateName  State Name to SET this state in other method
 *  @param applyNow   YES if apply state immediatly or NO to not
 */
- (void)addStateWithIcon:(UIImage *)icon andText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forName:(NSString *)stateName applyRightNow:(BOOL)applyNow;
/**
 *  Creates TMFloatingButtonState object and applies if need
 *
 *  @param text       Text for state
 *  @param attributes Text attributes(ex. font size,color et.)
 *  @param bgColor    Background color
 *  @param stateName  State Name to SET this state in other method
 *  @param applyNow   YES if apply state immediatly or NO to not
 */
- (void)addStateWithText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forName:(NSString *)stateName applyRightNow:(BOOL)applyNow;
/**
 *  Creates TMFloatingButtonState object and applies if need
 *
 *  @param icon      Icon that will be in center on the button
 *  @param bgColor   Background color
 *  @param stateName State Name to SET this state in other method
 *  @param applyNow  YES if apply state immediatly or NO to not
 */
- (void)addStateWithIcon:(UIImage *)icon andBackgroundColor:(UIColor *)bgColor forName:(NSString *)stateName applyRightNow:(BOOL)applyNow;
/**
 *  Creates TMFloatingButtonState object and applies if need
 *
 *  @param view      Custom view:labels,images combinations
 *  @param bgColor   Background color
 *  @param stateName State Name to SET this state in other method
 *  @param applyNow  YES if apply state immediatly or NO to not
 */
- (void)addStateWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor forName:(NSString *)stateName applyRightNow:(BOOL)applyNow;
/**
 *  Adds state(style) of Button and apply it immediately
 *
 *  @param state     FloatingButtonState object
 *  @param stateName State Name to SET this state in other method
 */
- (void)addAndApplyState:(TMFloatingButtonState *)state forName:(NSString *)stateName;
/**
 *  Sets state with next name
 *
 *  @param name State's name
 */
- (void)setButtonState:(NSString *)name;

//- (id)initWithIcon:(UIImage *)icon andText:(NSString *)text andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button;
#pragma mark - STYLES
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