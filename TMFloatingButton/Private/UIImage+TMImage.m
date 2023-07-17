//
//  UIImage+TMImage.m
//
//
//  Created by Ihor Shevchuk on 17.07.2023.
//

#import "UIImage+TMImage.h"
#import "resource_bundle_accessor.h"

@implementation UIImage (TMImage)
+ (UIImage *_Nullable)tmImageNamed:(NSString *)name
{
    return [UIImage imageNamed:name
                      inBundle:TMFloatingButton_TMFloatingButton_SWIFTPM_MODULE_BUNDLE()
             withConfiguration:nil];
}
@end
