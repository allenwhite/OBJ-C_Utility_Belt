//
//  imgurMashapeClient.m
//  Finna
//
//  Created by Allen White on 5/24/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import "imgurMashapeClient.h"
#import <UNIRest.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation imgurMashapeClient


+(void)loadImageFor:(UIImageView *)imageView withRemoteURL:(NSString *)url{
	//	imageView.contentMode = UIViewContentModeScaleAspectFit;
	imageView.contentMode = UIViewContentModeScaleAspectFill;
	[imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed: @"default_profile_pic"]];
}


+(NSString *)sendPicAtFilepath:(NSString *)filepath{
	NSData *pngData = [NSData dataWithContentsOfFile:filepath];
	UIImage *image = [self compressImage:[UIImage imageWithData:pngData]];
	NSData *data = UIImagePNGRepresentation(image);
	NSString *base64EncodedString = [data base64EncodedStringWithOptions:0];
	// These code snippets use an open-source library. http://unirest.io/objective-c
	NSDictionary *headers = @{
				  @"X-Mashape-Key": @"c2wuh74HjDmshLVne6AgEpjtm3eBp1G8LJ1jsn0XwgouDnMgHh",
				  @"Authorization": @"Client-ID ebf2a9c0fa18b2b",
				  @"Content-Type": @"application/x-www-form-urlencoded",
				  @"Accept": @"application/json"
				  };
	NSDictionary *parameters = @{
				     @"image": base64EncodedString,
				     @"type":@"base64"
				     };

	UNIHTTPJsonResponse *response = [[UNIRest post:^(UNISimpleRequest *request) {
		[request setUrl:@"https://imgur-apiv3.p.mashape.com/3/image"];
		[request setHeaders:headers];
		[request setParameters:parameters];
	}] asJson];
	NSInteger code = response.code;
	NSDictionary *responseHeaders = response.headers;
	UNIJsonNode *body = response.body;
	NSDictionary *body_json = [body JSONObject];
	NSLog(@"@@@@@@ imgur @@@@@@@@\n\tcode: %ld,\n\tresponseHeaders: %@,\n\trawbody: %@", (long)code, responseHeaders, body_json);
	//	NSLog(@"base64EncodedString: %@", base64EncodedString);
	return [[body_json objectForKey:@"data"] objectForKey:@"link"];
}


+(UIImage *)compressImage:(UIImage *)image{
	float actualHeight = image.size.height;
	float actualWidth = image.size.width;
	float maxHeight = 600.0;
	float maxWidth = 800.0;
	float imgRatio = actualWidth/actualHeight;
	float maxRatio = maxWidth/maxHeight;
	float compressionQuality = 0.9;//50 percent compression
	if (actualHeight > maxHeight || actualWidth > maxWidth){
		if(imgRatio < maxRatio){
			//adjust width according to maxHeight
			imgRatio = maxHeight / actualHeight;
			actualWidth = imgRatio * actualWidth;
			actualHeight = maxHeight;
		}
		else if(imgRatio > maxRatio){
			//adjust height according to maxWidth
			imgRatio = maxWidth / actualWidth;
			actualHeight = imgRatio * actualHeight;
			actualWidth = maxWidth;
		}
		else{
			actualHeight = maxHeight;
			actualWidth = maxWidth;
		}
	}
	CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
	UIGraphicsBeginImageContext(rect.size);
	[image drawInRect:rect];
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
	UIGraphicsEndImageContext();
	return [UIImage imageWithData:imageData];
}


+ (void) makeRoundPhoto:(UIImageView *)userImageView{
	userImageView.layer.cornerRadius = userImageView.frame.size.height / 2.0;
	userImageView.layer.masksToBounds = YES;
	userImageView.layer.shouldRasterize = YES;
	userImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
}


@end
