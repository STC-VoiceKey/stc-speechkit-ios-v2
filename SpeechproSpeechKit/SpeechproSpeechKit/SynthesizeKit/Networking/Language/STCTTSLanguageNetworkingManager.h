//
//  STCTTSLanguageNetworkingManager.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 23.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"

/**
 * Provides working with the languages API requests
 */
@interface STCTTSLanguageNetworkingManager : STCNetworkingManager

/**
 * Receives list of preset languages
 * @param completionHandler The language completion handler
 */
-(void)obtainLanguagesWithCompletionHandler:(CompletionHandler)completionHandler;

@end
