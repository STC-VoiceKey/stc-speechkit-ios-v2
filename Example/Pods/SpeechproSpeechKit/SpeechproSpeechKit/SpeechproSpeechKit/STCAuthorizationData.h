//
//  STCAuthorizationData.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 17.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The authorization data protocol
 */
@protocol STCAuthorizationData <NSObject>

/**
 * The authorization username
 */
-(NSString *)username;

/**
 * The authorization password
 */
-(NSString *)password;

/**
 * The authorization domain identifier
 */
-(NSString *)domainid;

@end
