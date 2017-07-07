//
//  ContactInfo.m
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import "SLVContactInfo.h"

@implementation SLVContactInfo

+ (instancetype)contactWithName:(NSString *)name andSurname:(NSString *)surname {
    SLVContactInfo *contact = [[SLVContactInfo alloc] init];
    if (contact) {
        contact.surname = surname;
        contact.name = name;
    }
    return contact;
}


@end
