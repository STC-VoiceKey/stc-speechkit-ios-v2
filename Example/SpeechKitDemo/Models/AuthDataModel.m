//
//  AuthDataModel.m
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 19.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "AuthDataModel.h"
#import <STCSpeechKit.h>

@interface AuthDataModel()

@property ( nonatomic) NSString *username;
@property ( nonatomic) NSString *password;
@property ( nonatomic) NSString *domainid;

@end

@implementation AuthDataModel

-(id)initWithUsername:(NSString *)username
         withPassword:(NSString *)password
         withDomainid:(NSString *)domainid{
    self = [self init];
    if (self) {
        self.username = username;
        self.password = password;
        self.domainid = domainid;
    }
    return self;
}

-(NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@ %@ %@ %@", self, self.username, self.password, self.domainid];
}

@end
