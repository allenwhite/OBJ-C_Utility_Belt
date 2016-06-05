//
//  UserPrefs.h
//  Finna
//
//  Created by Allen White on 5/28/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPrefs : NSObject

+ (void)setUserID:(NSString *)user_id;
+ (void)setUsername:(NSString *)username;
+ (void)setFirstname:(NSString *)firstname;
+ (void)setLastname:(NSString *)lastname;
+ (void)setBio:(NSString *)bio;
+ (void)setPhone:(NSString *)phone;
+ (void)setPhoto:(NSString *)photoLink;
+ (void)setToken:(NSString *)token;
+ (void)setDevicePushToken:(NSString *)token;

+ (NSString *)getUserID;
+ (NSString *)getUsername;
+ (NSString *)getFirstname;
+ (NSString *)getLastname;
+ (NSString *)getBio;
+ (NSString *)getPhone;
+ (NSString *)getPhoto;
+ (NSString *)getToken;
+ (NSString *)getDevicePushToken;

@end
