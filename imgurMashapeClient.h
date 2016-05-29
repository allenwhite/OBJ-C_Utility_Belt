//
//  imgurMashapeClient.h
//  Finna
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface imgurMashapeClient : NSObject

+(void)loadImageFor:(UIImageView *)imageView withRemoteURL:(NSString *)url;
+(NSString *)sendPicAtFilepath:(NSString *)filepath;
+ (void) setUserPhoto:(UIImageView *)userImageView;

@end
