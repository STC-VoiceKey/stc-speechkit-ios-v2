//
//  STCDiarizator.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 16.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCDiarizator.h"
#import "OPCSCaptureVoice2BufferManager.h"
#import "STCDiarizationKitImplementation.h"

@interface STCDiarizator()

@property (nonatomic) OPCSCaptureVoice2BufferManager *voiceManager;
@property (nonatomic) STCDiarizationKitImplementation              *diarizationKit;
@property (nonatomic) DiarizationCompletionHandler    diarizationHandler;

@end

@interface STCDiarizator(Private)

-(void)configureVoiceManager;

@end

@implementation STCDiarizator

-(id)init {
    self = [super init];
    if (self) {
        self.diarizationKit = [[STCDiarizationKitImplementation alloc] init];
        
        [self configureVoiceManager];
    }
    return self;
}

-(void)startWithCompletionHandler:(DiarizationCompletionHandler)handler {
    self.diarizationHandler = handler;
    [self.voiceManager record];
}

-(void)stop {
    [self.voiceManager stop];
}

@end

@implementation STCDiarizator(Private)

-(void)configureVoiceManager {
    self.voiceManager = [[OPCSCaptureVoice2BufferManager alloc] initWithSampleRate:16000];
    
    __weak typeof(self) weakself = self;
    self.voiceManager.loadDataBlock = ^(NSData *data, NSError *error) {
        if (error) {
            weakself.diarizationHandler( error, nil);
            return ;
        }
        [weakself.diarizationKit diarize:data
                   withCompletionHandler:^(NSError *error, NSDictionary *result) {
                       weakself.diarizationHandler( error, result);
                   }];
    };
}

@end
