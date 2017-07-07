//
//  ContactInfo.h
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLVContactInfo : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *surname;

+ (instancetype)contactWithName:(NSString *)name andSurname:(NSString *)surname;

@end
