//
//  PhoneTextField.m
//  Finna
//
//  Created by Allen White on 5/28/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//
// http://stackoverflow.com/questions/1246439/uitextfield-for-phone-number
//

#import "PhoneTextField.h"

@implementation PhoneTextField


- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self = [super initWithCoder:aDecoder]) {
		self.delegate = self;
		self.clipsToBounds = YES;
	}
	return self;
}


// Delegate Methods
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSString* totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
	
	if (range.length == 1) {
		// Delete button was hit.. so tell the method to delete the last char.
		textField.text = [self formatPhoneNumber:totalString deleteLastChar:YES];
	} else {
		textField.text = [self formatPhoneNumber:totalString deleteLastChar:NO ];
	}
	return false;
}


// Additional methods
-(NSString *)getSimpleNumber:(NSString *)prettyNumber{
	// use regex to remove non-digits(including spaces) so we are left with just the numbers
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
	NSString *simpleNumber = [regex stringByReplacingMatchesInString:prettyNumber options:0 range:NSMakeRange(0, [prettyNumber length]) withTemplate:@""];
	return simpleNumber;
}

-(NSString *)getSimpleNumber{
	// use regex to remove non-digits(including spaces) so we are left with just the numbers
	NSError *error = NULL;
	NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
	NSString *simpleNumber = [regex stringByReplacingMatchesInString:self.text options:0 range:NSMakeRange(0, [self.text length]) withTemplate:@""];
	return simpleNumber;
}


-(NSString*) formatPhoneNumber:(NSString*)prettyNumber deleteLastChar:(BOOL)deleteLastChar {
	if(prettyNumber.length==0) return @"";
	NSString *simpleNumber = [self getSimpleNumber:prettyNumber];
	
	// check if the number is to long
	if(simpleNumber.length>10) {
		// remove last extra chars.
		simpleNumber = [simpleNumber substringToIndex:10];
	}
	
	if(deleteLastChar) {
		// should we delete the last digit?
		simpleNumber = [simpleNumber substringToIndex:[simpleNumber length] - 1];
	}
	
	// 123 456 7890
	// format the number.. if it's less then 7 digits.. then use this regex.
	if(simpleNumber.length<7)
		simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d+)"
								       withString:@"($1) $2"
									  options:NSRegularExpressionSearch
									    range:NSMakeRange(0, [simpleNumber length])];
	
	else   // else do this one..
		simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d+)"
								       withString:@"($1) $2-$3"
									  options:NSRegularExpressionSearch
									    range:NSMakeRange(0, [simpleNumber length])];
	return simpleNumber;
}


-(BOOL)isValidPhoneNum{
	BOOL yesno = NO;
	NSString *simpleNumber = [self getSimpleNumber];
	if(simpleNumber.length == 10)
		yesno = YES;
	return yesno;
}


@end
