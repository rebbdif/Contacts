//
//  NetworkServises.m
//  contacts
//
//  Created by iOS-School-1 on 27.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "NetworkServises.h"
#import "UIKit/UIKit.h"


@implementation NetworkServises

+(void) getFromNetworkWithCompletionHandler:(void (^)(NSDictionary* result))completionHandler {
    __block BOOL success=NO;
    
      __block NSDictionary * result;
    
    NSURL *url=[NSURL URLWithString:@"https://api.vk.com/method/friends.get?user_id=37183009&v=5.52&nickname&fields=name&access_token=b91ab773b91ab773b91ab77347b9411c0ebb91ab91ab773e019d77b75efb8f9b348810c"];
    
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    

    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (error) {
            NSLog(@"ERROR %@",error.localizedDescription);
        }
        else {
            NSHTTPURLResponse *resp =(NSHTTPURLResponse *)response;
            if (resp.statusCode==200){
                NSLog(@"network interactions were successful");
                NSError *error = nil;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
                result=[[NSDictionary alloc]initWithDictionary:json];
                success=YES;
                
                completionHandler(result);
            }
        }
    }];
    
    [task resume];
    
    
}




@end
