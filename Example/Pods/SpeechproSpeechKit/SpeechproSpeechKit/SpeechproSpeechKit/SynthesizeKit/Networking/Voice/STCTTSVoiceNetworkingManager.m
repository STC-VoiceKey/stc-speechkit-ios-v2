//
//  STCTTSVoiceNetworkingManager.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 24.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCTTSVoiceNetworkingManager.h"
#import "STCTTSURLManager.h"

@interface STCTTSVoiceNetworkingManager ()

@property (nonatomic) NSString *language;

@end

@implementation STCTTSVoiceNetworkingManager

-(void)obtainVoicesForLanguage:(NSString *)language
         withCompletionHandler:(CompletionHandler)completionHandler {
    self.language = language;
    [self obtainWithCompletionHandler:completionHandler];
}

-(NSString *)request {
    return [STCTTSURLManager ttsVoiceForLanguage:self.language];
}

@end
