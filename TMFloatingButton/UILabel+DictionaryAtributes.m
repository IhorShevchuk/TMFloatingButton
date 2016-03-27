//
//  UILabel+DictionaryAtributes.m
//  FloatingButton
//
//  Created by Admin on 3/25/16.
//  Copyright © 2016 Techmagic. All rights reserved.
//

#import "UILabel+DictionaryAtributes.h"

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
