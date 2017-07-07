//
//  Model.h
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^voidBlock)(void);

@interface SLVModel : NSObject

@property (nonatomic, copy) NSArray *contacts;

- (void)getNamesWithCompletionHandler:(voidBlock)completionHandler;

- (void)getContactsFromFacebookWithCompletionHandler:(voidBlock)completionHandler;

@end
