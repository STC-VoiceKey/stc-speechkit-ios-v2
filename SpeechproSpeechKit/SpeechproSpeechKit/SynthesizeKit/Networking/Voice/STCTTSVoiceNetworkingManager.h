//
//  STCTTSVoiceNetworkingManager.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 24.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"

/**
 * Provides working with the voices API requests
 */
@interface STCTTSVoiceNetworkingManager : STCNetworkingManager

/**
 * Receives list of preset voices for specific language
 * @param language The language for voices
 * @param completionHandler The voice completion handler
 */
-(void)obtainVoicesForLanguage:(NSString *)language
         withCompletionHandler:(CompletionHandler)completionHandler;

@end
