//
//  AddressBookTool.m
//  Finna
//
//  Created by Allen White on 5/28/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//
// https://www.appcoda.com/ios-programming-import-contact-address-book/
// https://www.raywenderlich.com/63885/address-book-tutorial-in-ios
//

#import "AddressBookTool.h"
#import <UIKit/UIKit.h>
#import "Constants.h"

@implementation AddressBookTool


+ (BOOL)checkAddressBookAuthorized{
	if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
	    ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
		[Constants showAlert:@"Cannot Add Contact" withMessage:@"You must give the app permission to add the contact first."];
		return NO;
	} else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
		return YES;
	} else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
		ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
			if (!granted){
				[Constants showAlert:@"Cannot Add Contact" withMessage:@"You must give the app permission to add the contact first."];
				return;
			}
		});
		return [self checkAddressBookAuthorized];
	}
}


+ (NSArray *)getContacts{
	//[
	//	{
	//		"firstname":"",
	//		"lastname":"",
	//		"phone":"",
	//	}
	// ]
	ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
	NSArray *ab_contacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
	NSMutableArray *contacts = [NSMutableArray new];
	
	for (id record in ab_contacts){
		ABRecordRef thisContact = (__bridge ABRecordRef)record;
		CFTypeRef generalCFObject;
		NSString *firstname = @"";
		NSString *lastname = @"";
		NSString *phone = @"";
		generalCFObject = ABRecordCopyValue(thisContact, kABPersonFirstNameProperty);
		if (generalCFObject) {
			firstname = (__bridge NSString *)generalCFObject;
			CFRelease(generalCFObject);
		}
		generalCFObject = ABRecordCopyValue(thisContact, kABPersonLastNameProperty);
		if (generalCFObject) {
			lastname = (__bridge NSString *)generalCFObject;
			CFRelease(generalCFObject);
		}
		ABMultiValueRef phoneNumberMultiValue = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
		NSUInteger phoneNumberIndex;
		for (phoneNumberIndex = 0; phoneNumberIndex < ABMultiValueGetCount(phoneNumberMultiValue); phoneNumberIndex++) {
			CFStringRef labelStingRef = ABMultiValueCopyLabelAtIndex (phoneNumberMultiValue, phoneNumberIndex);
			NSString *phoneLabelLocalized = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(labelStingRef);
			if (![phoneLabelLocalized isEqualToString:@""]) {
				phone  = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneNumberMultiValue, phoneNumberIndex);
				//memory management
				CFRelease(labelStingRef);
			}
		}
		CFRelease(phoneNumberMultiValue);
		[contacts addObject:@{@"firstname":firstname, @"lastname":lastname, @"phone":phone}];
	}
	CFRelease(addressBookRef);
	return [contacts copy];
}

				    
+ (void)addContactFirstname:(NSString *)fname lastname:(NSString *)lname phoneNum:(NSString *)phone img:(NSData *)img{
	ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
	ABRecordRef person = ABPersonCreate();
	ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFStringRef)fname, nil);
	ABRecordSetValue(person, kABPersonLastNameProperty, (__bridge CFStringRef)lname, nil);
	
	ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)phone, kABPersonPhoneMainLabel, NULL);
	ABRecordSetValue(person, kABPersonPhoneProperty, phoneNumbers, nil);
	
	ABPersonSetImageData(person, (__bridge CFDataRef)img, nil);
	ABAddressBookAddRecord(addressBookRef, person, nil);
	
	NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
	for (id record in allContacts){
		ABRecordRef thisContact = (__bridge ABRecordRef)record;
		if (ABRecordCopyCompositeName(thisContact) != nil && CFStringCompare(ABRecordCopyCompositeName(thisContact), ABRecordCopyCompositeName(person), 0) == kCFCompareEqualTo){
			//The contact already exists!
			[Constants showAlert:[NSString stringWithFormat:@"There can only be one %@", fname] withMessage:nil];
			return;
		}
		CFRelease(thisContact);
	}
	ABAddressBookSave(addressBookRef, nil);
	CFRelease(person);
	CFRelease(phoneNumbers);
	CFRelease(addressBookRef);
	[Constants showAlert:@"Contact Added" withMessage:nil];
}


@end
