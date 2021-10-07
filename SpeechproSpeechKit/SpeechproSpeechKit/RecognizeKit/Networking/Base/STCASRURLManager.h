//
//  STCASRURLManager.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 03.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Provides the transport service urls for ASR API.
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
 The ASR API url for the recognizion.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/recognize
 @endcode
 */
+(NSString *)asrRecognize;

/**
 The ASR API url for starting stream transaction.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v1/transaction/ws
 @endcode
 */
+(NSString *)asrRecognizeStream;

/**
 The ASR API url for starting stream transaction.
 @code
 https://vkplatform.speechpro.com/vktts/rest/v2/transaction
 @endcode
 */
+(NSString *)asrRecognizeStreamClose;

@end
