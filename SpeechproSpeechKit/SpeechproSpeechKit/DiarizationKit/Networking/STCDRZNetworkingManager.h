//
//  STCDRZNetworkingManager.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 16.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"

/**
 * Provides working with the diarization API requests
 */
@interface STCDRZNetworkingManager : STCNetworkingManager

/**
 * Receives result of diarization
 * @param sound The voice data
 * @param completionHandler The voice completion handler
 */
       -(void)diarize:(NSData *)sound
withCompletionHandler:(CompletionHandler)completionHandler;

@end
