//
//  Model.m
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVModel.h"
#import "SLVContactInfo.h"
#import "SLVNetworkServises.h"
#import "SLVVKLoginViewController.h"
@import FBSDKCoreKit;

@implementation SLVModel

- (void)getNamesWithCompletionHandler:(voidBlock)completionHandler {
    
    NSString *userID = [SLVVKLoginViewController currentUser];
    NSString *token = [SLVVKLoginViewController currentAccessToken];
    
    NSString *url = [NSString stringWithFormat:@"https://api.vk.com/method/friends.get?user_id=%@&v=5.52&nickname&fields=name&access_token=%@", userID, token];
    __weak typeof (self) weakself = self;
    [SLVNetworkServises downloadFromURL:[NSURL URLWithString:url] withCompletionHandler:^(NSDictionary *result) {
        NSMutableArray *items = [NSMutableArray new];
        for (NSDictionary *item in result[@"response"][@"items"]) {
            [items addObject:([SLVContactInfo contactWithName:item[@"first_name"] andSurname:item[@"last_name"]])];
        }
        weakself.contacts = items;
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler();
        });
    }];
}

- (void)getContactsFromFacebookWithCompletionHandler:(voidBlock)completionHandler {
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"me/taggable_friends"
                                  parameters:@{@"fields": @"id, name"}];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          NSDictionary *result,
                                          NSError *error) {
        if (result) {
            NSArray *friends = result[@"data"];
            NSMutableArray *facebookFriends = [NSMutableArray new];
            for (NSDictionary *contact in friends) {
                NSString *nameSurname = contact[@"name"];
                NSRange space = [nameSurname rangeOfString:@" "];
                NSString *name = [nameSurname substringToIndex:space.location];
                NSString *surname = [nameSurname substringFromIndex:space.location+1];
                SLVContactInfo *friend = [SLVContactInfo contactWithName: name andSurname:surname];
                [facebookFriends addObject:friend];
            }
            self.contacts = facebookFriends;
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler();
            });
        }
    }];
}

@end





