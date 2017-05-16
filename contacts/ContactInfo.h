//
//  ContactInfo.h
//  contacts
//
//  Created by iOS-School-1 on 25.04.17.
//  Copyright © 2017 iOS-School-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactInfo : NSObject
@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *surname;

+(ContactInfo*)contactWithName:(NSString*)name andSurname:(NSString*)surname;
@end
