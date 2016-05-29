//
//  AddressBookTool.h
//  Finna
//
//  Created by Allen White on 5/28/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import <Foundation/Foundation.h>
@import AddressBook;

@interface AddressBookTool : NSObject

+ (BOOL)checkAddressBookAuthorized;
+ (NSArray *)getContacts;
+ (void)addContactFirstname:(NSString *)fname lastname:(NSString *)lname phoneNum:(NSString *)phone img:(NSData *)img;

@end
