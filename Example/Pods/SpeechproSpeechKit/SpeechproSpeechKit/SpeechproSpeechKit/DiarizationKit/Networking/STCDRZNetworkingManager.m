//
//  STCDRZNetworkingManager.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 16.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCDRZNetworkingManager.h"

#import "STCDRZURLManager.h"

@interface STCDRZNetworkingManager()

@property (nonatomic) NSData *voiceData;

@end

@implementation STCDRZNetworkingManager

-(NSString *)method {
    return @"POST";
}

-(NSDictionary *)body {
    return @{ @"data":[self.voiceData base64EncodedStringWithOptions:0] };
}

-(NSString *)request {
    return STCDRZURLManager.diarization;
}

-(void)diarize:(NSData *)sound
withCompletionHandler:(CompletionHandler)completionHandler {
    self.voiceData = [NSData dataWithData:sound];
    [self obtainWithCompletionHandler:completionHandler];
}

@end
