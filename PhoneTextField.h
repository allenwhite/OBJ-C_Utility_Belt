//
//  PhoneTextField.h
//  Finna
//
//  Created by Allen White on 5/28/16.
//  Copyright © 2016 Worldwide International. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneTextField : UITextField <UITextFieldDelegate>

- (BOOL)isValidPhoneNum;
@property (nonatomic) int maxchars;
-(NSString *)getSimpleNumber;
@end
