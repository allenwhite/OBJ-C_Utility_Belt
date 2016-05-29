//
//  UserLocation.m
//  Finna
//
//  Created by Allen White on 5/29/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import "UserLocation.h"

@implementation UserLocation 

CLLocationManager *locationManager;

// another way to do a singleton, without using GCD
+ (id)sharedManager {
	static UserLocation *sharedManager = nil;
	@synchronized(self) {
		if (sharedManager == nil)
			sharedManager = [[self alloc] init];
			sharedManager.locationSet = NO;
			if ([CLLocationManager locationServicesEnabled]) {
				locationManager = [[CLLocationManager alloc] init];
				locationManager.delegate = sharedManager;
				if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
						[locationManager requestWhenInUseAuthorization];
				}
				locationManager.distanceFilter = kCLDistanceFilterNone;
				locationManager.desiredAccuracy = kCLLocationAccuracyBest;
				[locationManager startUpdatingLocation];
			}
	}
	return sharedManager;
}




-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
	if (status == kCLAuthorizationStatusDenied) {
		//location denied, handle accordingly
		self.locationSet = NO;
	}else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
		self.locationSet = YES;
		self.lat = [NSNumber numberWithFloat:locationManager.location.coordinate.latitude];
		self.lon =[NSNumber numberWithFloat:locationManager.location.coordinate.longitude];
	}
}


@end
