//
//  STCDiarizationSpeechKit.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 28.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCDiarizationKitImplementation.h"
#import "STCDRZNetworkingManager.h"

@interface STCDiarizationKitImplementation()

@property (nonatomic) DiarizationCompletionHandler diarizationCompletionHandler;

@end

@implementation STCDiarizationKitImplementation

-(void)diarize:(NSData *)sound
withCompletionHandler:(DiarizationCompletionHandler)completionHandler {
    self.diarizationCompletionHandler = completionHandler;
    STCDRZNetworkingManager *networkingManager = [[STCDRZNetworkingManager alloc] init];
    [networkingManager diarize:sound withCompletionHandler:^(NSError *error, NSObject *result) {
        NSDictionary *voice = (NSDictionary *)result;
        self.diarizationCompletionHandler(nil, voice);
    }];
}

@end
