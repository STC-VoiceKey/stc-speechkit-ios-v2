//
//  STCNetworkingManager+Error.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 23.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"

/**
 * Category creates and analyses server errors
 */

@interface STCNetworkingManager (Error)

/**
 * Returns the error with reason formed from errorData
 */
-(NSError *)errorWithData:(NSData *)errorData;

/**
 * Returns the error or nil based on received parameters
 * @param error The error
 * @param response The response
 * @param errorData The error data
 */
-(NSError *)checkError:(NSError *)error
          withResponse:(NSURLResponse *)response
         withErrorData:(NSData *)errorData;

@end
