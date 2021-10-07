//
//  STCTTSSynthesizeNetworkingManager.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 24.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCTTSSynthesizeNetworkingManager.h"
#import "STCTTSURLManager.h"
#import "NSString+Language.h"

@interface STCTTSSynthesizeNetworkingManager()

@property (nonatomic) NSString *text;
@property (nonatomic) NSString *voice;

@end

@implementation STCTTSSynthesizeNetworkingManager

-(NSString *)method {
    return @"POST";
}

-(NSDictionary *)body {
    return @{ @"text":@{ @"mime":@"text/plain",
                        @"value":self.text },
        @"voice_name":self.voice,
             @"audio":@"audio/wav" };
}

-(NSString *)request {
    return STCTTSURLManager.ttsSynthesize;
}

-(void)synthesizeText:(NSString *)text
            withVoice:(NSString *)voice
withCompletionHandler:(CompletionHandler)completionHandler {
    self.text = text;
    self.voice = voice;
    
    NSLog(@"%@",[text language]);
    
    [self obtainWithCompletionHandler:completionHandler];
}
@end
