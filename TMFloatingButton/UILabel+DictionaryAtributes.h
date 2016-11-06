//
//  UILabel+DictionaryAtributes.h
//  FloatingButton
//
//  Created by Ihor Shevchuk on 3/25/16.
//  Copyright © 2016 Ihor Shevchuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (DictionaryAtributes)
/**
 *  applies attributes to UILabel
 *
 *  @param attributes Dictionary of attributes with keys: NSFontAttributeName, NSForegroundColorAttributeName etc.
 */
-(void)applyAttributes:(NSDictionary*)attributes;
@end
