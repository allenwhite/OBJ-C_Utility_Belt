//
//  Constants.m
//  Finna
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import "Constants.h"
#import "NSDate+NVTimeAgo.h"

@implementation Constants


+(void)showAlert:(NSString *)title withMessage:(NSString *)message fromController:(UIViewController *)vc{
	UIAlertController * alert=   [UIAlertController
				      alertControllerWithTitle:title
				      message:message
				      preferredStyle:UIAlertControllerStyleAlert];
	UIAlertAction* ok = [UIAlertAction
			     actionWithTitle:@"Y'arr!"
			     style:UIAlertActionStyleDefault
			     handler:^(UIAlertAction * action){
				     [alert dismissViewControllerAnimated:YES completion:nil];
			     }];
	[alert addAction:ok];
	[vc presentViewController:alert animated:YES completion:nil];
}


+ (void)showAlert:(NSString *)title withMessage:(NSString *)message{
	UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:title
							   message:message
							  delegate:self
						 cancelButtonTitle:@"OK"
						 otherButtonTitles:nil];
	[theAlert show];
}



+(void)fixSeparators:(UITableViewCell *)cell{
	// Remove seperator inset
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
	// Prevent the cell from inheriting the Table View's margin settings
	if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
		[cell setPreservesSuperviewLayoutMargins:NO];
	}
	// Explictly set your cell's layout margins
	if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
		[cell setLayoutMargins:UIEdgeInsetsZero];
	}
	[cell setNeedsUpdateConstraints];
	[cell updateConstraintsIfNeeded];
}


+(NSString*)prettyTime:(NSString *)time{
	// 2015-07-03 21:26:22.124185
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSSS"];
	return [[[dateFormatter dateFromString:time] dateByAddingTimeInterval:-14400] formattedAsTimeAgo];
}


+(NSString*)prettyTimeWithTimeZone:(NSString *)time{
	// Sat, 25 Jul 2015 06:21:29 GMT
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss v"];
	return [[dateFormatter dateFromString:time] formattedAsTimeAgo];
}


+(NSString*)formalTimeWithTimeZone:(NSString *)time{
	// Sat, 25 Jul 2015 06:21:29 GMT
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss v"];
	NSDate *date = [dateFormatter dateFromString:time];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MMM dd, h:mm a"];
	//Optionally for time zone conversions
	//	[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
	NSString *stringFromDate = [formatter stringFromDate:date];
	return stringFromDate;
}



+(UIColor *)r:(int)red g:(int)green b:(int)blue a:(float)alpha{
	return [UIColor colorWithRed:(float)red/255.0f green:(float)green/255.0f blue:(float)blue/255.0f alpha:alpha];
	
}

+(UIColor *)finnaBlue{
	return [self r:98 g:200 b:236 a:1];
}



@end
