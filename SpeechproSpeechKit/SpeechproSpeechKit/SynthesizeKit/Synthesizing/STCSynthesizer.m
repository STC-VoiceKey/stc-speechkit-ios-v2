//
//  STCSynthesizer.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 27.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>

#import "STCSynthesizer.h"
#import "STCSynthesizeKitImplementation.h"

@interface STCSynthesizer()

@property (nonatomic) AVPlayer *player;
@property (nonatomic) BOOL isPlaying;
@property (nonatomic) BOOL isCanceling;

@end

@interface STCSynthesizer(Private)

-(BOOL)saveForData:(NSData *)data toPath:(NSString *)path;
-(void)playFileFromPath:(NSString *)path;
-(NSString *)pathForVoice;

@end

@implementation STCSynthesizer

- (void)cancel {
    self.isCanceling = YES;
    if (self.isPlaying) {
        [self.player pause];
        self.player = nil;
    }
}

-(void)playText:(NSString *)text withCompletionHandler:(SynthesisCompletionHandler)synthesizeDoneBlock{
    self.isPlaying = NO;
    self.isCanceling = NO;
    STCSynthesizeKitImplementation *kit = [[STCSynthesizeKitImplementation alloc] init];
    [kit synthesizeText:text withCompletionHandler:^(NSError *error, NSObject *result) {
        if (self.isCanceling) {
            return ;
        }
        
        if (error) {
            synthesizeDoneBlock(error);
            return ;
        }
        
        NSDictionary *voice = (NSDictionary *)result;
        NSData *data = [[NSData alloc] initWithBase64EncodedString:voice[@"data"] options:0];
        
        [self saveForData:data toPath:self.pathForVoice];
        
        synthesizeDoneBlock(nil);
        
        [self playFileFromPath:self.pathForVoice];
    }];
}

-(void)playText:(NSString *)text
      withVoice:(NSString *)voice
withCompletionHandler:(SynthesisCompletionHandler)synthesizeDoneBlock{
    self.isPlaying = NO;
    self.isCanceling = NO;
    STCSynthesizeKitImplementation *kit = [[STCSynthesizeKitImplementation alloc] init];
    [kit synthesizeText:text withVoice:voice
  withCompletionHandler:^(NSError *error, NSObject *result) {
      if (self.isCanceling) {
          return ;
      }
      
      if (error) {
          synthesizeDoneBlock(error);
          return ;
      }
      NSData *data = (NSData *)result;
      [self saveForData:data toPath:self.pathForVoice];
      
      synthesizeDoneBlock(nil);
      
      [self playFileFromPath:self.pathForVoice];
  }];
}

@end

@implementation STCSynthesizer(Private)

-(NSString *)pathForVoice {
    return  [NSString stringWithFormat:@"%@/voice.wav",NSTemporaryDirectory()];
}

-(BOOL)saveForData:(NSData *)data toPath:(NSString *)path{
    BOOL success = [data writeToFile:path atomically:YES];
    return success;
}

-(void)playFileFromPath:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:self.pathForVoice];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.player = [[AVPlayer alloc] initWithURL:url];
        [self.player play];
        self.isPlaying = YES;
    });
}

@end
