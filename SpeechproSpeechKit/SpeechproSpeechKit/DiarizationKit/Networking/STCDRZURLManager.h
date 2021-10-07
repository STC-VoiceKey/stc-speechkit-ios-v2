//
//  STCTTSDiarizationURLManager.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 28.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCSessionURLManager.h"

/**
 Provides the transport service urls for Diarization API.
 API help
 @see https://vkplatform.speechpro.com/vkdiarization/help
 */
@interface STCDRZURLManager : STCSessionURLManager

/**
 The main Diarization API url
 @code
 https://vkplatform.speechpro.com/vkdiarization/rest
 @endcode
 */
+(NSString *)diarizationApiUrl ;

/**
 The API url for diarization.
 @code
 https://vkplatform.speechpro.com/vkdiarization/rest/v1/diarization
 @endcode
 */
+(NSString *)diarization;

@end
