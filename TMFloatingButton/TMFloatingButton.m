//
//  FloatingButton.m
//  Hagtap
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Ihor. All rights reserved.
//

#import "TMFloatingButton.h"

@interface UILabel (DictionaryAtributes)
/**
 *  applies attributes to UILabel
 *
 *  @param attributes Dictionary of attributes with keys: NSFontAttributeName, NSForegroundColorAttributeName etc.
 */
-(void)applyAttributes:(NSDictionary*)attributes;
@end
@implementation UILabel (DictionaryAtributes)

-(void)applyAttributes:(NSDictionary *)attributes
{
    NSMutableDictionary *attributesToSet;
    if(attributes)
    {
        attributesToSet = [attributes mutableCopy];
    }
    else
    {
        attributesToSet = [[NSMutableDictionary alloc]init];
    }
    if(![attributesToSet objectForKey:NSFontAttributeName])
    {
        [attributesToSet setObject:[UIFont systemFontOfSize:11] forKey:NSFontAttributeName];
    }
    if(![attributesToSet objectForKey:NSForegroundColorAttributeName])
    {
        [attributesToSet setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];;
    }
    
    if(![attributesToSet objectForKey:NSParagraphStyleAttributeName])
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentCenter;
        [attributesToSet setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];;
    }
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text attributes:attributesToSet];
    
    self.attributedText = attributedString;
    
    self.minimumScaleFactor = 0.5;
    self.numberOfLines = 0;
}

@end

@implementation TMFloatingButtonState

- (id)initWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor {
    self = [super init];
    if (self)
    {
        _view = view;
        _bgColor = bgColor;
    }
    
    return self;
}
- (id)initWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button {
    self = [super init];
    if (self)
    {
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        _view = view;
        [_view setFrame:button.bounds];
        _bgColor = bgColor;
    }
    return self;
}
- (id)initWithText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button {
    self = [self initWithIcon:nil andText:text withAttributes:attributes andBackgroundColor:bgColor forButton:button];
    return self;
}
- (id)initWithIcon:(UIImage *)icon andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button
{
    self = [self initWithIcon:icon andText:nil withAttributes:@{} andBackgroundColor:bgColor forButton:button];
    return self;
}
- (id)initWithIcon:(UIImage *)icon andText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forButton:(TMFloatingButton *)button {
    CGFloat margin = 15;
    UIView *stateView = [[UIView alloc]initWithFrame:button.bounds];
    if(text != nil && icon != nil)
    {
        UIImageView *stateIcon = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, button.frame.size.width - 2 * margin, button.frame.size.height - 2 * margin)];
        stateIcon.image = icon;
        
        CGRect imageFrame = stateIcon.frame;
        imageFrame.origin.y = 9;
        stateIcon.frame = imageFrame;
        
        UILabel *stateLabel;
        stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(stateIcon.frame.origin.x, CGRectGetMaxY(stateIcon.frame) - 1.0, stateIcon.frame.size.width, 10)];
        stateLabel.text = text;
        [stateLabel applyAttributes:attributes];
        
        [stateView addSubview:stateIcon];
        
        [stateView addSubview:stateLabel];
    }
    else if(text != nil)
    {
        margin = 3.0;
        UILabel *stateLabel;
        stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(margin,(stateView.frame.size.height - 40) / 2.0, stateView.frame.size.width - 2.0 * margin, 40)];
        stateLabel.text = text;
        [stateLabel applyAttributes:attributes];
        [stateView addSubview:stateLabel];
    }
    else if(icon != nil)
    {
        margin = 13;
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin, button.frame.size.width - 2 * margin, button.frame.size.height - 2 * margin)];
        iconView.image = icon;
        [stateView addSubview:iconView];
    }
    stateView.userInteractionEnabled = NO;
    self = [self initWithView:stateView andBackgroundColor:bgColor forButton:button];
    return self;
}
@end


@interface TMFloatingButton ()
{
    UIActivityIndicatorView *activityIndicator;
    TMFloatingButtonState *curState;
    NSMutableDictionary *buttonStates;
    //hide & show
    CGRect showFrame;
    CGRect hideFrame;
}

@end

@implementation TMFloatingButton

- (id)initWithSuperView:(UIView *)superView
{
    self = [self initWithWidth:ButtonDefaultSize withMargin:ButtonDefaultMargin andPosition:FloatingButtonPositionBottomRight andHideDirection:FloatingButtonHideDirectionDown andSuperView:superView];
    return self;
}
- (id)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andSuperView:(UIView *)superView
{
    self = [self initWithWidth:width withMargin:margin andPosition:FloatingButtonPositionBottomRight andHideDirection:FloatingButtonHideDirectionDown andSuperView:superView];
    return self;
}
- (id)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andPosition:(FloatingButtonPosition)postion postionandSuperView:(UIView *)superView
{
    self = [self initWithWidth:width withMargin:margin andPosition:postion andHideDirection:FloatingButtonHideDirectionDown andSuperView:superView];
    return self;
}
- (id)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andPosition:(FloatingButtonPosition)postion andHideDirection:(FloatingButtonHideDirection)hideDirection andSuperView:(UIView *)superView {
    self = [super init];
    
    if (self)
    {
        _size = width;
        _margin = margin;
        _position = postion;
        _hideDirection = hideDirection;
        [self updateFrameWithPosition:_position andHideDirection:_hideDirection];
        //rounded
        _isRounded = NO;
        [self setIsRounded:YES];
        _showShadow = NO;
        [self setShowShadow:YES];
        
        
        //init activity indicator
        activityIndicator  = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.hidesWhenStopped = YES;
        [self addSubview:activityIndicator];
        activityIndicator.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
        //states
        curState = nil;
        if (buttonStates == nil)
        {
            buttonStates = [[NSMutableDictionary alloc]init];
        }
        
        [self setBackgroundImage:[UIImage imageNamed:@"selectorImage"] forState:UIControlStateHighlighted];
        
        [self addAsSubviewToView:superView];
    }
    return self;
}
- (void)setIsRounded:(BOOL)isRounded {
    if (_isRounded != isRounded)
    {
        if (isRounded)
        {
            self.layer.cornerRadius = self.bounds.size.width / 2.0;
        }
        else {
            self.layer.cornerRadius = 0.0;
        }
        _isRounded = isRounded;
    }
}
- (void)setShowShadow:(BOOL)showShadow {
    if (_showShadow != showShadow)
    {
        if (showShadow)
        {
            [self.layer setShadowColor:[UIColor blackColor].CGColor];
            [self.layer setShadowOpacity:0.7];
            [self.layer setShadowRadius:3.0];
            [self.layer setShadowOffset:CGSizeMake(1.0, 1.0)];
        }
        else {
            [self.layer setShadowColor:[UIColor clearColor].CGColor];
            [self.layer setShadowOpacity:0.0];
            [self.layer setShadowRadius:0.0];
            [self.layer setShadowOffset:CGSizeMake(0.0, 0.0)];
        }
        // self.clipsToBounds = YES;
        _showShadow = showShadow;
    }
}
- (void)hideAnimated:(BOOL)animated {
    if (!self.superview)
    {
        return;
    }
    
    
    if (animated)
    {
        [UIView animateWithDuration:0.5 animations: ^(void) {
            self.frame = hideFrame;
        } completion: ^(BOOL finished)
         {}];
    }
    else {
        self.frame = hideFrame;
    }
}
- (void)showAnimated:(BOOL)animated {
    if (!self.superview)
    {
        return;
    }
    
    if (animated)
    {
        [UIView animateWithDuration:0.5 animations: ^(void) {
            self.frame = showFrame;
        } completion: ^(BOOL finished)
         {}];
    }
    else {
        self.frame = showFrame;
    }
}
- (BOOL)addAsSubviewToView:(UIView *)superView {
    if (superView == nil)
    {
        NSLog(@"WARNING!: superview is nil!");
        return NO;
    }
    [superView addSubview:self];
    [superView bringSubviewToFront:self];
    return YES;
}
- (void)animateActivityIndicatorStart:(BOOL)animate {
    if (animate)
    {
        [curState.view removeFromSuperview];
        [activityIndicator startAnimating];
    }
    else {
        [activityIndicator stopAnimating];
        [self addSubview:curState.view];
    }
}
#pragma mark Frame updates
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrameWithPosition:_position andHideDirection:_hideDirection];
}
- (void)updateFrameWithPosition:(FloatingButtonPosition)postion andHideDirection:(FloatingButtonHideDirection)hideDirection
{
    //set frame that depends on 'postion'
    CGRect frameForButton;
    switch (postion) {
        case FloatingButtonPositionTopLeft:
            frameForButton = CGRectMake(_margin, _margin, _size, _size);
            break;
            
        case FloatingButtonPositionTopRight:
            frameForButton = CGRectMake(self.superview.frame.size.width - _size - _margin, _margin, _size, _size);
            break;
            
        case FloatingButtonPositionBottomLeft:
            frameForButton = CGRectMake(_margin, self.superview.frame.size.height - _size - _margin, _size, _size);
            break;
            
        case FloatingButtonPositionBottomRight:
            frameForButton = CGRectMake(self.superview.frame.size.width - _size - _margin, self.superview.frame.size.height - _size - _margin, _size, _size);
            break;
            
        default:
            break;
    }
    self.frame = frameForButton;
    //calculate hided frame
    hideFrame = self.frame;
    showFrame = self.frame;
    switch (hideDirection) {
        case FloatingButtonHideDirectionLeft:
            hideFrame.origin.x = -showFrame.size.width;
            break;
            
        case FloatingButtonHideDirectionRight:
            
            hideFrame.origin.x = self.superview.frame.size.width;
            break;
            
        case FloatingButtonHideDirectionUp:
            hideFrame.origin.y = -showFrame.size.height;
            break;
            
        case FloatingButtonHideDirectionDown:
            hideFrame.origin.y = self.superview.frame.size.height;
            break;
            
        default:
            break;
    }
    
    activityIndicator.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
}
-(void)setSize:(CGFloat)size
{
    [self layoutSubviews];
}
-(void)setMargin:(CGFloat)margin
{
    [self layoutSubviews];
}
-(void)setPosition:(FloatingButtonPosition)position
{
    [self layoutSubviews];
}
-(void)setHideDirection:(FloatingButtonHideDirection)hideDirection
{
    [self layoutSubviews];
}
#pragma mark - STATES MANAGEMENT
- (void)addState:(TMFloatingButtonState *)state forName:(NSString *)stateName {
    if (state && stateName)
    {
        [buttonStates setObject:state forKey:stateName];
    }
}
- (void)addStateWithIcon:(UIImage *)icon andText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forName:(NSString *)stateName applyRightNow:(BOOL)applyNow
{
    TMFloatingButtonState *newState =  [[TMFloatingButtonState alloc]initWithIcon:icon andText:text withAttributes:attributes andBackgroundColor:bgColor forButton:self];
    [self addState:newState forName:stateName];
    if(applyNow)
    {
        [self setButtonState:stateName];
    }
}
- (void)addStateWithText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor forName:(NSString *)stateName applyRightNow:(BOOL)applyNow
{
    TMFloatingButtonState *newState =  [[TMFloatingButtonState alloc]initWithText:text withAttributes:attributes andBackgroundColor:bgColor forButton:self];
    [self addState:newState forName:stateName];
    if(applyNow)
    {
        [self setButtonState:stateName];
    }
}
- (void)addStateWithIcon:(UIImage *)icon andBackgroundColor:(UIColor *)bgColor forName:(NSString *)stateName applyRightNow:(BOOL)applyNow
{
    TMFloatingButtonState *newState =  [[TMFloatingButtonState alloc]initWithIcon:icon andBackgroundColor:bgColor forButton:self];
    [self addState:newState forName:stateName];
    if(applyNow)
    {
        [self setButtonState:stateName];
    }
}
- (void)addStateWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor forName:(NSString *)stateName applyRightNow:(BOOL)applyNow
{
    TMFloatingButtonState *newState =  [[TMFloatingButtonState alloc]initWithView:view andBackgroundColor:bgColor forButton:self];
    [self addState:newState forName:stateName];
    if(applyNow)
    {
        [self setButtonState:stateName];
    }
}
- (void)addAndApplyState:(TMFloatingButtonState *)state forName:(NSString *)stateName
{
    [self addState:state forName:stateName];
    [self setButtonState:stateName];
}
- (void)setButtonState:(NSString *)name {
    TMFloatingButtonState *stateToSet = [buttonStates objectForKey:name];
    if (![stateToSet isEqual:curState] && stateToSet != nil)
    {
        [curState.view removeFromSuperview];
        curState = stateToSet;
        if (curState.view)
        {
            [self addSubview:curState.view];
        }
        if (curState.bgColor)
        {
            self.backgroundColor = curState.bgColor;
        }
    }
}
#pragma mark - styles
+ (void)addFavoritesStyleToButton:(TMFloatingButton *)button {
    //NOT SAVED
    [button addStateWithIcon:[UIImage imageNamed:@"white-star"] andBackgroundColor:[UIColor colorWithRed:0.662 green:0.088 blue:0.719 alpha:0.800] forName:@"notSaved" applyRightNow:NO];
    //SAVED
    [button addStateWithIcon:[UIImage imageNamed:@"checkmark-white"] andText:NSLocalizedString(@"Saved", @"Saved") withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} andBackgroundColor:[UIColor colorWithRed:0.101 green:0.510 blue:0.133 alpha:0.800] forName:@"saved" applyRightNow:NO];
}
+ (void)addModeEditStyleToButton:(TMFloatingButton *)button {
    [button addStateWithIcon:[UIImage imageNamed:@"white-mode-edit"]  andBackgroundColor:[UIColor colorWithRed:0.792 green:0.169 blue:0.149 alpha:1.000] forName:@"statickStyle" applyRightNow:YES];
}
+ (void)addMessageStyleToButton:(TMFloatingButton *)button {
    [button addStateWithIcon:[UIImage imageNamed:@"message_grey"] andBackgroundColor:[UIColor whiteColor] forName:@"staticStyle" applyRightNow:YES];
}
@end