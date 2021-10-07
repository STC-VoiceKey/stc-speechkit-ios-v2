//
//  STCDiarizating.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 16.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The diarizating protocol
 */

/**
 * The diarization completion handler type defenition
 * @param error The error
 */

typedef void (^DiarizationCompletionHandler) ( NSError *error, NSDictionary *result);

@protocol STCDiarizating <NSObject>

/**
 * Starts recording and diarization
 * @param handler The diarization completion handler
 */
-(void)startWithCompletionHandler:(DiarizationCompletionHandler)handler;

/**
 * Stops diarization
 */
-(void)stop;

@end
