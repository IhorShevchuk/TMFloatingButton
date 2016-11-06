//
//  FloatingButton.m
//  Hagtap
//
//  Created by Admin on 12/9/14.
//  Copyright (c) 2014 Ihor. All rights reserved.
//

#import "TMFloatingButton.h"

const CGFloat kLongTouchTime = 1.0f;
const CGFloat kDraggingSizeCoeficient = 0.15;//15%

@interface TMFloatingButton ()
{
    UIActivityIndicatorView *activityIndicator;
    TMFloatingButtonState *curState;
    NSMutableDictionary *buttonStates;
    //hide & show
    CGRect showFrame;
    //dragging
    NSTimer *draggingTimer;
    NSDate *time;
    CGPoint startM;
    BOOL canBeDragged;
}

@end

@implementation TMFloatingButton

- (instancetype)initWithSuperView:(UIView *)superView
{
    self = [self initWithWidth:kTMFloatingButtonDefaultSize withMargin:kTMFloatingButtonDefaultMargin andPosition:FloatingButtonPositionBottomRight andHideDirection:FloatingButtonHideDirectionDown andSuperView:superView];
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andSuperView:(UIView *)superView
{
    self = [self initWithWidth:width withMargin:margin andPosition:FloatingButtonPositionBottomRight andHideDirection:FloatingButtonHideDirectionDown andSuperView:superView];
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andPosition:(FloatingButtonPosition)postion postionandSuperView:(UIView *)superView
{
    self = [self initWithWidth:width withMargin:margin andPosition:postion andHideDirection:FloatingButtonHideDirectionDown andSuperView:superView];
    return self;
}

- (instancetype)initWithWidth:(CGFloat)width withMargin:(CGFloat)margin andPosition:(FloatingButtonPosition)postion andHideDirection:(FloatingButtonHideDirection)hideDirection andSuperView:(UIView *)superView {
    self = [super init];
    
    if (self)
    {
        _size = width;
        _margin = margin;
        _position = postion;
        _hideDirection = hideDirection;
        showFrame = CGRectZero;
        _isRounded = YES;
        _showShadow = YES;
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
        canBeDragged = NO;
    }
    return self;
}

- (void)dealloc
{
    [draggingTimer invalidate];
    draggingTimer = nil;
}

- (void)setIsRounded:(BOOL)isRounded
{
    if (isRounded)
    {
        self.layer.cornerRadius = self.bounds.size.width / 2.0;
    }
    else
    {
        self.layer.cornerRadius = 0.0;
    }
    _isRounded = isRounded;
}

- (void)setShowShadow:(BOOL)showShadow
{
    if (showShadow)
    {
        (self.layer).shadowColor = [UIColor blackColor].CGColor;
        (self.layer).shadowOpacity = 0.7;
        (self.layer).shadowRadius = 3.0;
        (self.layer).shadowOffset = CGSizeMake(1.0, 1.0);
    }
    else {
        (self.layer).shadowColor = [UIColor clearColor].CGColor;
        (self.layer).shadowOpacity = 0.0;
        (self.layer).shadowRadius = 0.0;
        (self.layer).shadowOffset = CGSizeMake(0.0, 0.0);
    }
    _showShadow = showShadow;
    
}

- (void)hideAnimated:(BOOL)animated {
    if (!self.superview)
    {
        return;
    }
    
    CGRect hideFrame = [self hideFrameForHideDirection:_hideDirection];
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
    else
    {
        [activityIndicator stopAnimating];
        [self addSubview:curState.view];
    }
}
#pragma mark Frame updates
- (void)layoutSubviews
{
    [self updateFrameWithPosition:_position];
    [self updateCornerRadius];
    [self updateShadowFrame];
    (curState.view).frame = self.bounds;
    [super layoutSubviews];
}

- (void)updateShadowFrame
{
    self.showShadow = _showShadow;
}

- (void)updateCornerRadius
{
    self.isRounded = _isRounded;
}

- (void)updateFrameWithPosition:(FloatingButtonPosition)postion
{
    
    activityIndicator.center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    
    if(!CGRectEqualToRect(showFrame,CGRectZero))
    {
        if(CGRectEqualToRect(showFrame,self.frame))
        {
            return;
        }
        
        self.frame = showFrame;
        return;
    }
    
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
    showFrame = self.frame;
}

-(CGRect)hideFrameForHideDirection:(FloatingButtonHideDirection)hideDirection
{
    //calculate hided frame
    CGRect hideFrame = self.frame;
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
    return hideFrame;
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
#pragma mark - DRAGGING

- (void)startDragging
{
    canBeDragged = YES;
    [UIView animateWithDuration:0.3 animations:^
    {
        self.transform = CGAffineTransformMakeScale(1 + kDraggingSizeCoeficient, 1 + kDraggingSizeCoeficient);
        showFrame = self.frame;
    } completion:^(BOOL finished)
    {
    
    }];
}

- (void)endDragging
{
    canBeDragged = NO;
    [UIView animateWithDuration:0.3 animations:^
    {
         self.transform = CGAffineTransformIdentity;
         showFrame = self.frame;
    }
    completion:^(BOOL finished)
    {
        [self moveButtonToBorderIfNeeded];
    }];
}

- (void)moveButtonToBorderIfNeeded
{
    CGRect currentFrame = self.frame;
    if(currentFrame.origin.x < 0 || currentFrame.origin.y < 0 || CGRectGetMaxX(currentFrame) > self.superview.frame.size.width || CGRectGetMaxY(currentFrame) > self.superview.frame.size.height)
    {
        
        CGRect newBoundsFrame = currentFrame;
        if(newBoundsFrame.origin.x < 0)
        {
            newBoundsFrame.origin.x = 0;
        }
        
        if(newBoundsFrame.origin.y < 0)
        {
            newBoundsFrame.origin.y = 0;
        }
        
        if(CGRectGetMaxX(newBoundsFrame) > self.superview.frame.size.width)
        {
            newBoundsFrame.origin.x = self.superview.frame.size.width - newBoundsFrame.size.width;
        }
        
        if(CGRectGetMaxY(newBoundsFrame) > self.superview.frame.size.height)
        {
            newBoundsFrame.origin.y = self.superview.frame.size.height - newBoundsFrame.size.height;
        }
        
        [UIView animateWithDuration:0.1 animations:^
         {
             showFrame = newBoundsFrame;
             self.frame = newBoundsFrame;
         }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    canBeDragged = NO;
    startM = self.center;
    time = [NSDate date];
    
    [draggingTimer invalidate];
    draggingTimer = nil;
    draggingTimer = [NSTimer scheduledTimerWithTimeInterval:kLongTouchTime
                                                     target:self
                                                   selector:@selector(startDragging)
                                                   userInfo:nil
                                                    repeats:NO];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if([NSDate date].timeIntervalSince1970 - time.timeIntervalSince1970 <= kLongTouchTime)
    {
        [super touchesEnded:touches withEvent:event];
        [draggingTimer invalidate];
        draggingTimer = nil;
        return;
    }
    
    [self setHighlighted:NO];
    [self endDragging];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    if([NSDate date].timeIntervalSince1970 - time.timeIntervalSince1970 > kLongTouchTime)
    {
        if(!canBeDragged)
        {
            return;
        }
        
        UITouch *touch = [event.allTouches anyObject];
        CGPoint touchLocation = [touch locationInView:self.superview];
        NSLog(@"Delta xd:%f yd:%f",(touchLocation.x - startM.x),(touchLocation.y - startM.y));
        CGPoint newCenter = CGPointMake(self.center.x + (touchLocation.x - startM.x), self.center.y + (touchLocation.y - startM.y));
        startM = touchLocation;
        self.center = newCenter;
        NSLog(@"NewCenter:x:%f y:%f",self.center.x,self.center.y);
        showFrame = self.frame;
    }
}

#pragma mark - STATES MANAGEMENT
- (void)addState:(TMFloatingButtonState *)state forName:(NSString *)stateName {
    if (state && stateName)
    {
        buttonStates[stateName] = state;
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
    TMFloatingButtonState *stateToSet = buttonStates[name];
    if (![stateToSet isEqual:curState] && stateToSet != nil)
    {
        [curState.view removeFromSuperview];
        curState = stateToSet;
        if (curState.view)
        {
            (curState.view).frame = self.bounds;
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
