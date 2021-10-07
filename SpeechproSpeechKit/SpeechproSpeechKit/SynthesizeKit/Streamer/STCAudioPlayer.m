//
//  AudioPlayer.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 22.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCAudioPlayer.h"

@implementation STCAudioPlayer
@synthesize queue;

void AQBufferCallback(void *                inUserData ,
                      AudioQueueRef         inAQ,
                      AudioQueueBufferRef   inBuffer) {
    STCAudioPlayer *THIS = (__bridge STCAudioPlayer *)(inUserData);
    
    if(THIS->isRunning) {
        inBuffer->mPacketDescriptionCount = THIS->bufferByteSize/2;
        
        NSLog(@"mPacketDescriptionCount %d",inBuffer->mPacketDescriptionCount);
        
        inBuffer->mAudioDataByteSize = THIS->bufferByteSize;
        
        if(read(THIS->pip_fd[0], inBuffer->mAudioData, THIS->bufferByteSize) > 0 ){
            AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
            NSLog(@"AudioQueueEnqueueBuffer %d",inBuffer->mAudioDataByteSize);
        }
    }
}

-(id)init {
    return [self initWithSampleRate:22050];
}

-(id)initWithSampleRate:(int)sampleRate {
    self = [super init];
    if(self) {
        memset(&playFormat, 0, sizeof(playFormat));
        playFormat.mFormatID = kAudioFormatLinearPCM;
        playFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked ;
        playFormat.mBitsPerChannel = 16;
        playFormat.mChannelsPerFrame = 1;
        playFormat.mBytesPerPacket = playFormat.mBytesPerFrame = (playFormat.mBitsPerChannel / 8) * playFormat.mChannelsPerFrame;
        playFormat.mFramesPerPacket = 1;
        playFormat.mSampleRate = sampleRate;
        isRunning = false;
        isInitialized = false;
    }
    return self;
}

-(void)start {
    if (isInitialized) {
        return;
    }
    
   // bufferByteSize = kBufferSize;
    AudioQueueNewOutput(&playFormat, AQBufferCallback, (__bridge void *)(self), nil, nil, 0, &queue);
    for (int i=0; i<kNumberBuffers; i++) {
        AudioQueueAllocateBuffer( queue, kBufferSize, &mBuffers[i]);
    }
    
    AudioQueueSetParameter( queue, kAudioQueueParam_Volume, 1.0);

    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute, sizeof (audioRouteOverride), &audioRouteOverride);

    isInitialized = true;
    int ret = pipe(pip_fd);
    if (ret == -1) {
        NSLog(@"create pipe failed");
    }
}

-(void)stop  {
    close(pip_fd[0]);
    close(pip_fd[1]);
    AudioQueueStop(queue, false);
    if (queue){
        AudioQueueDispose(queue, true);
        queue = NULL;
        isRunning = false;
    }
    isInitialized = false;
}

-(void)putAudioData:(short*)pcmData withSize:(int)dataSize{
    if (!isRunning) {
        memcpy(mBuffers[index]->mAudioData, pcmData, dataSize);
        bufferByteSize = dataSize;
        NSLog(@"putAudioData %d",dataSize);
        mBuffers[index]->mAudioDataByteSize = dataSize;
        mBuffers[index]->mPacketDescriptionCount = dataSize/2;
        AudioQueueEnqueueBuffer(queue, mBuffers[index], 0, NULL);
        NSLog(@"fill audio queue buffer[%d]",index);
        if(index == kNumberBuffers - 1) {
            isRunning = true;
            index = 0;
            AudioQueueStart(queue, NULL);
        } else {
            index++;
        }
    } else {
        NSLog(@"write putAudioData %d",dataSize);
        bufferByteSize = dataSize;
        if(write(pip_fd[1], pcmData, dataSize) < 0){
            NSLog(@"write to the pipe failed!");
        }
    }
}
@end
