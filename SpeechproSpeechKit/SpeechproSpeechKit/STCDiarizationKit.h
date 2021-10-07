//
//  STCDiarizationKit.h
//  SpeechproSpeechKit
//
//  Created by Soloshcheva Aleksandra on 25.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The kit of methods used for diarization of speech
 */

/**
 * Is the block which is called when diarization data is received
 
 * @param error  Data receiving error.
 * @param result Responce data.\nIf data received successfully, 'error' is nil
 */
typedef void (^DiarizationCompletionHandler) ( NSError *error, NSDictionary *result);

@protocol STCDiarizationKit <NSObject>

/**
 * Receives the diarization result
 * @param completionHandler The response block called when the result is received
 */
-(void)diarize:(NSData *)sound
withCompletionHandler:(DiarizationCompletionHandler)completionHandler;

@end
