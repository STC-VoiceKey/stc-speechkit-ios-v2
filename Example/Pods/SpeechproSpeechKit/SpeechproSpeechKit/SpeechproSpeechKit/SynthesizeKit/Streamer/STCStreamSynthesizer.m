//
//  STCStreamSynthesizer.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 08.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCStreamSynthesizer.h"
#import "STCSynthesizeKitImplementation.h"
#import "STCWebSocket.h"
#import "STCAudioPlayer.h"
#import "NSString+Language.h"

@interface STCStreamSynthesizer()<NSStreamDelegate>

@property (nonatomic) STCWebSocket   *socket;
@property (nonatomic) NSString       *startingText;

@property (nonatomic) STCAudioPlayer *audioplayer;
@property (nonatomic) BOOL isPlayerInitialized;

@property (nonatomic) SynthesisCompletionHandler synthesizeDoneBlock;
@property (nonatomic) STCSynthesizeKitImplementation *synthesizeKit;

@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isCanceling;

@end

@interface STCStreamSynthesizer(Private)

-(void)startStreamWithURL:(NSString *)urlString;

@end

@interface STCStreamSynthesizer(ConfigureSocket)

-(void)configureOnData;
-(void)configureOnConnect;
-(void)configureOnDisconnect;

@end

@implementation STCStreamSynthesizer

- (void)cancel {
    self.isCanceling = YES;
    [self.socket disconnect];
    self.socket.onData = nil;
    self.socket.onDisconnect = nil;
    self.socket.onConnect = nil;
    [self.audioplayer stop];
}

- (void)playText:(NSString *)text
       withVoice:(NSString *)voice
withCompletionHandler:(SynthesisCompletionHandler)synthesizeDoneBlock{
    self.isCanceling = NO;
    self.isPlaying = NO;
    self.isPlayerInitialized = NO;
    self.startingText = text;
    self.synthesizeKit = [[STCSynthesizeKitImplementation alloc] init];
    self.synthesizeDoneBlock = synthesizeDoneBlock;
    [self.synthesizeKit streamWithVoice:voice
withCompletionHandler:^(NSError *error, NSObject *result) {
        if (self.isCanceling) {
            return ;
        }
    
      if (error) {
          synthesizeDoneBlock(error);
          return ;
      }
      [self startStreamWithURL:(NSString *)result];
      synthesizeDoneBlock(nil);
  }];
}

- (void)addTextToPlay:(NSString *)text {
    if (self.socket) {
        [self.socket writeString:text];
    }
}

@end

@implementation STCStreamSynthesizer(Private)

-(void)startStreamWithURL:(NSString *)urlString {
    
    if (self.isCanceling) {
        return;
    }
    NSLog(@"startStreamWithURL");

    self.socket = [[STCWebSocket alloc] initWithURL:[NSURL URLWithString:urlString] protocols:@[@"chat",@"superchat"]];
    
    [self configureOnData];
    [self configureOnConnect];
    [self configureOnDisconnect];
    
    [self.socket connect];
}

@end

@implementation STCStreamSynthesizer(ConfigureSocket)

-(void)configureOnData {
    __weak typeof(self) weakself = self;
    self.socket.onData = ^(NSData * _Nullable data) {
        if (weakself.isCanceling) {
            return ;
        }
        NSLog(@"%lu",data.length);
        
        if (!weakself.isPlayerInitialized) {
            weakself.isPlayerInitialized = YES;
            [weakself.audioplayer start];
        }
        [weakself.audioplayer putAudioData:(short*)data.bytes withSize:(int)data.length];
    };
}

-(void)configureOnConnect {
    __weak typeof(self) weakself = self;
    self.socket.onConnect = ^{
        weakself.audioplayer = [[STCAudioPlayer alloc] initWithSampleRate:22050];
        [weakself.socket writeString:weakself.startingText];
        NSLog(@"%@",weakself.startingText);
        [weakself.synthesizeKit closeStream:^(NSError *error, NSString *stream) {
            
        }];
    };
}

-(void)configureOnDisconnect {
    __weak typeof(self) weakself = self;
    self.socket.onDisconnect = ^(NSError * _Nullable error) {
        if (error) {
            if (weakself) {
                weakself.synthesizeDoneBlock(error);
            }
        }
    };
}

@end
