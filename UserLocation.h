//
//  UserLocation.h
//  Finna
//
//  Created by Allen White on 5/29/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface UserLocation : NSObject <CLLocationManagerDelegate>

@property BOOL locationSet;
@property (strong, nonatomic) NSNumber *lat;
@property (strong, nonatomic) NSNumber *lon;
+ (id)sharedManager;

@end
