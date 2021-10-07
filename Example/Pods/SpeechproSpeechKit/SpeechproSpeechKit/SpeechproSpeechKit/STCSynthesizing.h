//
//  STCSynthesizing.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 27.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The synthesizing protocol
 */

/**
 * The synthesis completion handler type defenition
 * @param error The error
 */
typedef void (^SynthesisCompletionHandler) (NSError *error);

@protocol STCSynthesizing <NSObject> 

/**
 * Synthesizes speech based on text and plays the speech with the specific voice
 * @param text The text for synthesis
 * @param voice The voice for synthesis
 * @param synthesizeCompletionHandler The synthesize completion handler
 */
        - (void)playText:(NSString *)text
               withVoice:(NSString *)voice
   withCompletionHandler:(SynthesisCompletionHandler)synthesizeCompletionHandler;

/**
 * Cancel all operations
 */
           -(void)cancel;

@end
