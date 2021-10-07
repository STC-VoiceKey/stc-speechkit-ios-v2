//
//  STCASRURLManager.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 03.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides the transport service urls for TTS API.
 API help
 @see https://vkplatform.speechpro.com/vkasr/help
 */
@interface STCASRURLManager : NSObject

/**
 The main ASR API url
 @code
 https://vkplatform.speechpro.com/vkasr/rest
 @endcode
 */
+(NSString *)asrApiUrl;

/**
 The ASR API url for the starting server session.
 @code
 https://vkplatform.speechpro.com/vkasr/rest/session
 @endcode
 */
+(NSString *)asrStartSession;

/**
 The ASR API url for the closing server session.
 @code
 https://vkplatform.speechpro.com/vkasr/rest/session
 @endcode
 */
+(NSString *)asrCloseSession;

/**
 The ASR API url for the obtaining a list of supported packages.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/packages/available
 @endcode
 */
+(NSString *)asrAvailablePackages ;

/**
 The ASR API url for the load specific package.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/packages/{packageId}/load
 @endcode
 */
+(NSString *)asrLoadPackage:(NSString *)package;

/**
 The ASR API url for the unload specific package.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/packages/{packageId}/unload
 @endcode
 */
+(NSString *)asrUnloadPackage:(NSString *)package;

/**
 The ASR API url for the recognizion.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/recognize
 @endcode
 */
+(NSString *)asrRecognize;

/**
 The ASR API url for starting stream transaction.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/recognize/session
 @endcode
 */
+(NSString *)asrRecognizeStream;

@end
