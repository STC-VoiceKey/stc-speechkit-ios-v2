//
//  STCRecognizeKit.h
//  SpeechproSpeechKit
//
//  Created by Soloshcheva Aleksandra on 25.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The kit of methods used for recognition of speech
 */

/**
 * Is the block which is called when recognition data is received
 
 * @param error  Data receiving error.
 * @param result Responce data.\nIf data received successfully, 'error' is nil
 */
typedef void (^RecognizeCompletionHandler) ( NSError *error, NSDictionary *result);

/**
 * Is the block which is called when package list is received
 
 * @param error  Data receiving error.
 * @param result Responce data.\nIf data received successfully, 'error' is nil
 */
typedef void (^PackagesCompletionHandler)  ( NSError *error, NSArray<NSDictionary *> *result);

@protocol STCRecognizeKit <NSObject>

/**
 * Receives list of preset recognition packages
 * @param completionHandler The response block called when the result is received
 */
-(void)obtainPackagesWithCompletionHandler:(PackagesCompletionHandler)completionHandler;

/**
 * Receives the recognition result
 * @param completionHandler The response block called when the result is received
 */
-(void)recognize:(NSData *)voice
withCompletionHandler:(RecognizeCompletionHandler)completionHandler;

/**
 * Receives the recognition result
 * @param voice The sound for recognition
 * @param package The package for recognition
 * @param completionHandler The response block called when the result is received
 */
-(void)recognize:(NSData *)voice
     withPackage:(NSString *)package
withCompletionHandler:(RecognizeCompletionHandler)completionHandler;

/**
 * Receives the stream url
 * @param completionHandler The response block called when the result is received
 */
-(void)streamWithCompletionHandler:(RecognizeCompletionHandler)completionHandler;

/**
 * Receives the stream url
 * @param completionHandler The response block called when the result is received
 */
-(void)streamWithPackage:(NSString *)package
   withCompletionHandler:(RecognizeCompletionHandler)completionHandler;

/**
 * Closes the socket
 * @param completionHandler The response block called when the result is received
 */
-(void)closeStreamWithCompletionHandler:(RecognizeCompletionHandler)completionHandler;

@end
