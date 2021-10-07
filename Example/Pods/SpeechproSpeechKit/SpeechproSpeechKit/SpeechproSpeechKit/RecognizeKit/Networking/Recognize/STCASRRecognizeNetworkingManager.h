//
//  STCASRRecognizeNetworkingManager.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 04.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"

/**
 * Provides working with the recognize API requests
 */
@interface STCASRRecognizeNetworkingManager : STCNetworkingManager

/**
 * Recognizes speech
 * @param speech64Base The voice in base64 encoding
 * @param completionHandler The recognition completion handler
 */
-(void)recognizeSpeech:(NSString *)speech64Base
 withCompletionHandler:(CompletionHandler)completionHandler;

/**
 * Recognizes speech with specific package
 * @param speech64Base The voice in base64 encoding
 * @param package The specific package
 * @param completionHandler The recognition completion handler
 */
-(void)recognizeSpeech:(NSString *)speech64Base
           withPackage:(NSString *)package
 withCompletionHandler:(CompletionHandler)completionHandler;

@end
