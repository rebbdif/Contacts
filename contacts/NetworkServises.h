//
//  NetworkServises.h
//  contacts
//
//  Created by iOS-School-1 on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkServises : NSObject

+(void) getFromNetworkWithCompletionHandler:(void (^)(NSDictionary* result))completionHandler;

@end
