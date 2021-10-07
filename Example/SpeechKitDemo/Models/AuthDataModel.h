//
//  AuthDataModel.h
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 19.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <STCAuthorizationData.h>

@interface AuthDataModel : NSObject<STCAuthorizationData>

@property (nonatomic,readonly) NSString *username;
@property (nonatomic,readonly) NSString *password;
@property (nonatomic,readonly) NSString *domainid;

-(id)initWithUsername:(NSString *)username
         withPassword:(NSString *)password
         withDomainid:(NSString *)domainid;

@end
