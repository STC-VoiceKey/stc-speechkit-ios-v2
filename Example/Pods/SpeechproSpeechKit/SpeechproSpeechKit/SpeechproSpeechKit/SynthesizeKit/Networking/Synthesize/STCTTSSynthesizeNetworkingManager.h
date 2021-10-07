//
//  STCTTSSynthesizeNetworkingManager.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 24.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"
#import "STCNetworkingManager.h"

/**
 * Provides working with the synthesize API requests
 */
@interface STCTTSSynthesizeNetworkingManager : STCNetworkingManager

/**
 * Synthesizes the text with specific voice
 * @param text The text for synthesis
 * @param voice The voice for synthesis
 * @param completionHandler The synthesis completion handler
 */
-(void)synthesizeText:(NSString *)text
            withVoice:(NSString *)voice
withCompletionHandler:(CompletionHandler)completionHandler;

@end
