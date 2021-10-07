//
//  STCError.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 26.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCErrorCode.h"

/**
 * Provides creation and sending specific application error
 */

@interface STCError : NSError

/**
 * The happens when language is unknown
 */
+(NSError *)unknownLanguageError;

/**
 * The happens when voice is not existed for language
 */
+(NSError *)noVoiceForLanguageError;

/**
 * The happens when language is The happens when language is unknown
 */
+(NSError *)unsupportedLanguageError;

/**
 * Creates the error with the reason
 * @param reason The reason
 */
+(NSError *)errorWithReason:(NSString *)reason;

@end
