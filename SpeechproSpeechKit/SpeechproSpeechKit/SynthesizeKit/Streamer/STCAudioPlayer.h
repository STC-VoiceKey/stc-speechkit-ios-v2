//
//  AudioPlayer.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 22.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import <CoreFoundation/CoreFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#include <unistd.h>


#define kNumberBuffers 3
#define kBufferSize 100000

@interface STCAudioPlayer : NSObject
{
    AudioQueueRef                   queue;
    AudioQueueBufferRef             mBuffers[kNumberBuffers];
    AudioStreamBasicDescription     playFormat;
    int                             index;
@public
    Boolean                         isRunning;
    Boolean                         isInitialized;
    int                             bufferByteSize;
    int                             pip_fd[2];
    UInt32                          numPacketsToRead;
}
@property AudioQueueRef queue;

-(id)init;
-(id)initWithSampleRate:(int)sampleRate;
-(void)start;
-(void)stop;
-(void)putAudioData:(short*)pcmData withSize:(int)dataSize;

@end
