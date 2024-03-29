//
//  TMTableViewController.m
//  FloatingButton
//
//  Created by Ihor Shevchuk on 2/10/15.
//  Copyright © 2015 Ihor Shevchuk. All rights reserved.
//

#import "TMTableViewController.h"
@import TMFloatingButton;

@interface TMTableViewController ()
{
    //ADD TO FAVORITES STYLE
    TMFloatingButton *floatingButton;
    BOOL added;
    //MODE EDIT STYLE
    TMFloatingButton *floatingModeEditButton;
    //NEW MESSAGE BUTTON
    TMFloatingButton *floatingNewMessageButton;
}
@end

@implementation TMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    added = NO;
    
    [self createAddToFavoritesButton];
    [self createModeEditButton];
    //[self createNewMessageButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - NewMessageButton
- (void)createNewMessageButton
{
    floatingNewMessageButton = [[TMFloatingButton alloc]initWithWidth:kTMFloatingButtonDefaultSize
                                                           withMargin:kTMFloatingButtonDefaultMargin
                                                          andPosition:FloatingButtonPositionBottomRight
                                                     andHideDirection:FloatingButtonHideDirectionDown
                                                         andSuperView:self.navigationController.view];
    
    [TMFloatingButton addMessageStyleToButton:floatingNewMessageButton];
    
    [floatingNewMessageButton addTarget:self action:@selector(newMessageButtonAction) forControlEvents:UIControlEventTouchUpInside];
    floatingNewMessageButton.canBeMoved = YES;
}
- (void)newMessageButtonAction
{
    //Some actions
}
#pragma mark - ModeEditButton
- (void)createModeEditButton
{
    floatingModeEditButton = [[TMFloatingButton alloc]initWithWidth:kTMFloatingButtonDefaultSize
                                                         withMargin:kTMFloatingButtonDefaultMargin
                                                        andPosition:FloatingButtonPositionBottomLeft
                                                   andHideDirection:FloatingButtonHideDirectionDown
                                                       andSuperView:self.navigationController.view];
    
    [floatingModeEditButton addStateWithText:@"Custom text"
                              withAttributes:@{
                                               NSForegroundColorAttributeName:[UIColor colorWithRed:1.000 green:0.227 blue:0.000 alpha:1.000],
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:9]}
                          andBackgroundColor:[UIColor colorWithRed:0.792 green:0.615 blue:0.149 alpha:1.000]
                                     forName:@"CustomStateText"
                               applyRightNow:YES];
    [floatingModeEditButton addTarget:self action:@selector(modeEditAction) forControlEvents:UIControlEventTouchUpInside];
    floatingModeEditButton.canBeMoved = YES;
}
- (void)modeEditAction
{
    //Some actions
}
#pragma mark - AddToFavoritesButton
- (void)createAddToFavoritesButton {
    floatingButton = [[TMFloatingButton alloc]initWithSuperView:self.navigationController.view];
    
    [TMFloatingButton addFavoritesStyleToButton:floatingButton];
    
    [floatingButton addTarget:self action:@selector(addToFavoritesAction) forControlEvents:UIControlEventTouchUpInside];
    [floatingButton setButtonState:@"notSaved"];
}
- (void)addToFavoritesAction
{
    [floatingButton animateActivityIndicatorStart:YES];
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        typeof(self) strongSelf = weakSelf;
        if(strongSelf)
        {
            strongSelf->added = !strongSelf->added;
            if(strongSelf->added)
            {
                [strongSelf->floatingButton setButtonState:@"saved"];
            }
            else
            {
                [strongSelf->floatingButton setButtonState:@"notSaved"];
            }
            [strongSelf->floatingButton animateActivityIndicatorStart:NO];
        }
    });
}
#pragma mark  UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [floatingButton hideAnimated:YES];
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [floatingButton showAnimated:YES];
}
@end
