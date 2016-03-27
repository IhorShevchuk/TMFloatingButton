//
//  TMFloatingButtonView.m
//  FloatingButton
//
//  Created by Admin on 3/25/16.
//  Copyright © 2016 Techmagic. All rights reserved.
//

#import "TMFloatingButtonView.h"
#import "UILabel+DictionaryAtributes.h"

typedef enum
{
    TMFloatingButtonViewTypeIcon = 0,
    TMFloatingButtonViewTypeText,
    TMFloatingButtonViewTypeIconWithText,
    TMFloatingButtonViewTypeView
}TMFloatingButtonViewType;

@interface TMFloatingButtonView()
{
    UILabel *textLabel;
    UIImageView *icon;
    UIView *subview;
    TMFloatingButtonViewType type;
}
@end

@implementation TMFloatingButtonView
- (id)initWithView:(UIView *)view andBackgroundColor:(UIColor *)bgColor
{
    self = [super init];
    if(self)
    {
        type = TMFloatingButtonViewTypeView;
        subview = view;
        subview.backgroundColor = bgColor;
        [self addSubview:subview];
    }
    return self;
}

- (id)initWithText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor
{
    self = [super init];
    if(self)
    {
        type = TMFloatingButtonViewTypeText;
        if(textLabel)
        {
            [textLabel removeFromSuperview];
            textLabel = nil;
        }
        textLabel = [[UILabel alloc]init];
        textLabel.text = text;
        [textLabel applyAttributes:attributes];
        [self addSubview:textLabel];
        [self updateFrames];
    }
    return self;
}

- (id)initWithIcon:(UIImage *)image andBackgroundColor:(UIColor *)bgColor
{
    self = [super init];
    if(self)
    {
        type = TMFloatingButtonViewTypeIcon;
        if(icon)
        {
            [icon removeFromSuperview];
            icon = nil;
        }
        
        icon = [[UIImageView alloc]init];
        icon.image = image;
        [self addSubview:icon];
        [self updateFrames];
    }
    return self;
}

- (id)initWithIcon:(UIImage *)image andText:(NSString *)text withAttributes:(NSDictionary *)attributes andBackgroundColor:(UIColor *)bgColor
{
    self = [super init];
    if(self)
    {
        type = TMFloatingButtonViewTypeIconWithText;
        if(icon)
        {
            [icon removeFromSuperview];
            icon = nil;
        }
        
        icon = [[UIImageView alloc]init];
        icon.image = image;
        [self addSubview:icon];
        
        if(textLabel)
        {
            [textLabel removeFromSuperview];
            textLabel = nil;
        }
        textLabel = [[UILabel alloc]init];
        textLabel.text = text;
        [textLabel applyAttributes:attributes];
        [self addSubview:textLabel];
        
        [self updateFrames];
    }
    return self;
}

- (void)updateFrames
{
    switch (type) {
        case TMFloatingButtonViewTypeIcon:
        {
            CGFloat margin = 13;
            icon.frame = CGRectMake(margin, margin, self.frame.size.width - 2 * margin, self.frame.size.height - 2 * margin);
        }
            break;
        case TMFloatingButtonViewTypeText:
        {
            CGFloat margin = 3.0;
            textLabel.frame = CGRectMake(margin,(self.frame.size.height - 40) / 2.0, self.frame.size.width - 2.0 * margin, 40);
        }
            break;
        case TMFloatingButtonViewTypeIconWithText:
        {
            CGFloat margin = 15;
            
            icon.frame = CGRectMake(margin, margin, self.frame.size.width - 2 * margin, self.frame.size.height - 2 * margin);
            CGRect imageFrame = icon.frame;
            imageFrame.origin.y = 9;
            icon.frame = imageFrame;
            textLabel.frame = CGRectMake(icon.frame.origin.x, CGRectGetMaxY(icon.frame) - 1.0, icon.frame.size.width, 10);
        }
        case TMFloatingButtonViewTypeView:
        {
            [subview setFrame:self.bounds];
        }
            break;
        default:
            break;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrames];
}
@end
