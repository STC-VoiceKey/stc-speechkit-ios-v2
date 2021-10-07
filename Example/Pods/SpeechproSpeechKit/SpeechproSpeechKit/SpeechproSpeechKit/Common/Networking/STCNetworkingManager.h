//
//  STCNetworkingManager.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 18.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCSessionURLManager.h"
/**
 * The bases class for all networking managers
 */

@protocol STCAuthorizationData;

/**
 * The common completion handler
 * @param error  Data receiving error.
 * @param result Responce data.\nIf data received successfully, 'error' is nil
 */
typedef void (^CompletionHandler) ( NSError *error, NSObject *result);

@interface STCNetworkingManager : NSObject

/**
 * Keeps the common completion handler
 */
@property (nonatomic) CompletionHandler completionHandler;

/**
 * The current session identifier
 */
@property (nonatomic) NSString *sessionId;

/**
 * The current transaction identifier(if exists)
 */
@property (nonatomic) NSString *transactionId;

/**
 * The received result
 */
@property (nonatomic) NSObject *result;

/**
 * Obtains data with current networking request
 */
-(void)obtainWithCompletionHandler:(CompletionHandler)completionHandler;

/**
 * Starts prerequest
 */
-(void)startingRequest;

/**
 * Returns the current request url
 */
-(NSString *)request;

/**
 * Returns HTTP request method(should be reload in child class)
 */
-(NSString *)method;

/**
 * Returns HTTP request body(should be reload in child class)
 */
-(NSDictionary *)body;

/**
 * Returns the session url
 */
-(NSString *)sessionRequest;

/**
 * Starts the current request
 */
-(void)progressRequest;

/**
 * Start the finalize request (Closes session as rule)
 */
-(void)finalizeRequest;

@end
