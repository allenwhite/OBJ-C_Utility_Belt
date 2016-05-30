//
//  UserLocation.h
//  Finna
//
//  Created by Allen White on 5/29/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
// http://www.michaelbabiy.com/cllocationmanager-singleton/

/*
- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	[[UserLocation sharedController]setDelegate:self];
	[[UserLocation sharedController].locationManager startUpdatingLocation];
}

-(void)viewWillDisappear:(BOOL)animated{
	[super viewWillDisappear:animated];
	[[UserLocation sharedController].locationManager stopUpdatingLocation];
}
*/

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@protocol UserLocationDelegate

- (void)locationControllerDidUpdateLocation:(CLLocation *)location;

@end


@interface UserLocation : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) id delegate;

+ (UserLocation *)sharedController;

@end
