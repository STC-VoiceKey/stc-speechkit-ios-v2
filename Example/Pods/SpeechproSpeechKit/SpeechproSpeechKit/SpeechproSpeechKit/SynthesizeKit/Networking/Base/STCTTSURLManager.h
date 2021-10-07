//
//  STCURLManager.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 19.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides the transport service urls for TTS API.
 API help
 @see https://vkplatform.speechpro.com/vktts/help
 */

@interface STCTTSURLManager : NSObject

/**
 The main TTS API url
 @code
 https://vkplatform.speechpro.com/vktts/rest
 @endcode
 */
+(NSString *)ttsApiUrl;

/**
 The TTS API url for the starting server session.
 @code
 https://vkplatform.speechpro.com/vktts/rest/session
 @endcode
 */
+(NSString *)ttsStartSession;

/**
 The TTS API url for the closing server session.
 @code
 https://vkplatform.speechpro.com/vktts/rest/session
 @endcode
 */
+(NSString *)ttsCloseSession;

/**
 The TTS API url for the obtaining a list of supported languages.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/languages
 @endcode
 */
+(NSString *)ttsObtainLanguages;

/**
 The TTS API url for the obtaining a list of existed voices for language.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/languages/{language}/voices
 @endcode
 */
+(NSString *)ttsVoiceForLanguage:(NSString *)language;

/**
 The TTS API url for synthesizing sound from text.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/synthesize
 @endcode
 */
+(NSString *)ttsSynthesize;

/**
 The TTS API url for synthesizing sound from text without server session.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/synthesize/sessionless
 @endcode
 */
+(NSString *)ttsSynthesizeSessionless;

/**
 The TTS API url for starting stream session.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/synthesize/stream
 @endcode
 */
+(NSString *)ttsStartStream;

/**
 The TTS API url for closing stream session.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/synthesize/stream
 @endcode
 */
+(NSString *)ttsCloseStream;

@end
