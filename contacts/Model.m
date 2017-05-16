//
//  Model.m
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "Model.h"
#import "ContactInfo.h"
#import "NetworkServises.h"
@import FBSDKCoreKit;

@implementation Model

- (void)getNamesWithCompletionHandler:(void(^)(void))completionHandler {
    __weak typeof (self) weakself=self;
    [NetworkServises getFromNetworkWithCompletionHandler:^(NSDictionary *result) {
        NSDictionary *json2=result[@"response"];
        NSArray *items =json2[@"items"];
        NSMutableArray *items_cont=[NSMutableArray new];
        for (NSDictionary *item in items)
        {
            NSString *name=item[@"first_name"];
            NSString *surname=item[@"last_name"];
            [items_cont addObject:( [ContactInfo contactWithName: name andSurname: surname])];
        }
        weakself.contacts=items_cont;
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler();
        });
    }];
}

- (void)getContactsFromFacebookWithCompletionHandler:(void(^)(void))completionHandler {
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me/taggable_friends"
                                  parameters:nil
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        if (error) {
            NSLog(@"error is %@",error.userInfo);
        }
        else {
            completionHandler();
        }
    }];
}

@end





