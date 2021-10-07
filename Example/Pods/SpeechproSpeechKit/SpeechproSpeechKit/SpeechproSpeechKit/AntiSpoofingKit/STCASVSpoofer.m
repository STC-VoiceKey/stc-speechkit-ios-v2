//
//  STCASVSpoofer.m
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 19.09.2018.
//

#import "STCASVSpoofer.h"
#import "OPCSCaptureVoice2BufferManager.h"
#import "STCASVSKitImplementation.h"

@interface STCASVSpoofer()

@property (nonatomic) OPCSCaptureVoice2BufferManager *voiceManager;
@property (nonatomic) id<STCASVSKit>                  spoofingKit;
@property (nonatomic) ASVSCompletionHandler           spoofingHandler;

@end

@interface STCASVSpoofer(Private)

-(void)configureVoiceManager;

@end

@implementation STCASVSpoofer

-(id)init {
    self = [super init];
    if (self) {
        self.spoofingKit = [[STCASVSKitImplementation alloc] init];
        
        [self configureVoiceManager];
    }
    return self;
}

- (void)startWithCompletionHandler:(ASVSCompletionHandler)handler {
    self.spoofingHandler = handler;
    [self.voiceManager record];
}

- (void)stop {
    [self.voiceManager stop];
}

@end

@implementation STCASVSpoofer(Private)

-(void)configureVoiceManager {
    self.voiceManager = [[OPCSCaptureVoice2BufferManager alloc] initWithSampleRate:16000];
    
    __weak typeof(self) weakself = self;
    self.voiceManager.loadDataBlock = ^(NSData *data, NSError *error) {
        if (error) {
            weakself.spoofingHandler( error, nil);
            return ;
        }
        [weakself.spoofingKit spoof:data
                   withCompletionHandler:^(NSError *error, NSString *result) {
                       weakself.spoofingHandler( error, result);
                   }];
    };
}

@end

