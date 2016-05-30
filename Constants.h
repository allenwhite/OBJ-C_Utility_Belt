//
//  Constants.h
//  Finna
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Constants : NSObject

+ (void)showAlert:(NSString *)title withMessage:(NSString *)message;
+(void)showAlert:(NSString *)title withMessage:(NSString *)message fromController:(UIViewController *)vc;
+(void)fixSeparators:(UITableViewCell *)cell;

// 2015-07-03 21:26:22.124185
+(NSString*)prettyTime:(NSString *)time;

// Sat, 25 Jul 2015 06:21:29 GMT
+(NSString*)prettyTimeWithTimeZone:(NSString *)time;

// Sat, 25 Jul 2015 06:21:29 GMT
+(NSString*)formalTimeWithTimeZone:(NSString *)time;

+(UIColor *)r:(int)red g:(int)green b:(int)blue a:(float)alpha;

+(UIColor *)finnaBlue;


@end
