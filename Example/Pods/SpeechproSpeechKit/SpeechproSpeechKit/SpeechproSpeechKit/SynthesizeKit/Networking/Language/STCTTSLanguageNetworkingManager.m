//
//  STCTTSLanguageNetworkingManager.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 23.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCTTSLanguageNetworkingManager.h"
#import "STCTTSURLManager.h"


@implementation STCTTSLanguageNetworkingManager

-(void)obtainLanguagesWithCompletionHandler:(CompletionHandler)completionHandler {
    [self obtainWithCompletionHandler:completionHandler];
}

-(NSString *)request {
    return STCTTSURLManager.ttsObtainLanguages;
}

@end
