//
//  Model.h
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property(nonatomic,copy)NSArray *contacts;

- (void)getNamesWithCompletionHandler:(void(^)(void))completionHandler;
- (void)getContactsFromFacebookWithCompletionHandler:(void(^)(void))completionHandler;

@end
