//
//  UILabel+DictionaryAtributes.h
//  FloatingButton
//
//  Created by Admin on 3/25/16.
//  Copyright © 2016 Techmagic. All rights reserved.
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
