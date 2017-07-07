//
//  VKLoginViewController.h
//  contacts
//
//  Created by 1 on 18.05.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLVVKLoginViewController : UIViewController

+ (NSString *)currentAccessToken;
+ (NSString *)currentUser;
+ (void)logout;

@end
