//
//  STCRecognizing.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 28.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The recognizing protocol
 */

/**
 * The recognition completion handler type defenition
 * @param error The error
 * @param result The result of recognition
 */

typedef void (^RecognizingCompletionHandler) ( NSError *error, NSString *result);

@protocol STCRecognizing <NSObject>

/**
 * Starts recording and recognizing
 * @param completionHandler The recognition completion handler
 */
-(void)startWithCompletionHandler:(RecognizingCompletionHandler)completionHandler;

/**
 * Starts recording and recognizing for specific package
 * @param package The specific package
 * @param completionHandler The recognition completion handler
 */
-(void)startWithPackage:(NSDictionary *)package
  withCompletionHandler:(RecognizingCompletionHandler)completionHandler;

/**
 * Stops recording and recognizing
 */
-(void)stop;

@end
