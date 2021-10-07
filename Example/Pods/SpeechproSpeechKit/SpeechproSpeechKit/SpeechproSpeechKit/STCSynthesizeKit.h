//
//  STCSynthesizeKit.h
//  SpeechproSpeechKit
//
//  Created by Soloshcheva Aleksandra on 25.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * The kit of methods used for synthesis of speech
 */

/**
 * Is the block which is called when languages data is received
 
 * @param error  Data receiving error.
 * @param result Responce data.\nIf data received successfully, 'error' is nil
 */
typedef void (^LanguageCompletionHandler)     ( NSError *error, NSArray<NSDictionary *> *result);

/**
 * Is the block which is called when voices list is received
 
 * @param error  Data receiving error.
 * @param result Responce data.\nIf data received successfully, 'error' is nil
 */
typedef void (^VoicesCompletionHandler)       ( NSError *error, NSArray<NSDictionary *> *result);

/**
 * Is the block which is called when synthesis data is received
 
 * @param error  Data receiving error.
 * @param result Responce data.\nIf data received successfully, 'error' is nil
 */
typedef void (^SynthesizeCompletionHandler)   ( NSError *error, NSData *result);

/**
 * Is the block which is called when start streaming result is received
 
 * @param error  Data receiving error.
 * @param stream Stream URL.\nIf data received successfully, 'error' is nil
 */
typedef void (^StreamCompletionHandler)       ( NSError *error, NSString *stream);

@protocol STCSynthesizeKit <NSObject>
/**
 * Receives list of preset languages
 * @param completionHandler The response block called when the result is received
 */
-(void)obtainLanguagesWithCompletionHandler:(LanguageCompletionHandler)completionHandler;

/**
 * Receives list of preset voices for specific language
 * @param language The specific language
 * @param completionHandler The response block called when the result is received
 */
-(void)obtainVoicesForLanguage:(NSString *)language
         withCompletionHandler:(VoicesCompletionHandler)completionHandler;

/**
 * Receives the synthesis result
 * @param text The text for synthesis
 * @param completionHandler The response block called when the result is received
 */
-(void)synthesizeText:(NSString *)text
withCompletionHandler:(SynthesizeCompletionHandler)completionHandler;

/**
 * Receives the synthesis result
 * @param text The text for synthesis
 * @param voice The voice for synthesis
 * @param completionHandler The response block called when the result is received
 */
-(void)synthesizeText:(NSString *)text
            withVoice:(NSString *)voice
withCompletionHandler:(SynthesizeCompletionHandler)completionHandler;

/**
 * Receives the stream url
 * @param language The synthesis language
 * @param completionHandler The response block called when the result is received
 */
-(void)streamWithLanguage:(NSString *)language
    withCompletionHandler:(StreamCompletionHandler)completionHandler;

/**
 * Receives the stream url
 * @param voice The voice for synthesis
 * @param completionHandler The response block called when the result is received
 */
-(void)streamWithVoice:(NSString *)voice
 withCompletionHandler:(StreamCompletionHandler)completionHandler;

/**
 * Closes stream
 * @param completionHandler The response block called when the result is received
 */
-(void)closeStream:(StreamCompletionHandler)completionHandler;

@end
