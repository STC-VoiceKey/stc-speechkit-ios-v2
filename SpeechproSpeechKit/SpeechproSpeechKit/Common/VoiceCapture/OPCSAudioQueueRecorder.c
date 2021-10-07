//
//  OPCSAudioQueueRecorder.c
//  OnePassCaptureStandard
//
//  Created by Soloshcheva Aleksandra on 06.09.16.
//  Copyright © 2016 Speech Technology Center. All rights reserved.
//

#include "OPCSAudioQueueRecorder.h"

void FormatError( OSStatus error);
//https://developer.apple.com/library/content/documentation/MusicAudio/Conceptual/AudioQueueProgrammingGuide/AQRecord/RecordingAudio.html
OPCSAudioQueueRecorderRef OPCRAudioQueueSourceCreate(OPCSAudioQueueRecorderCallbackPointer callback, void *userInfo, Float64 sampleRate) {
    OPCSAudioQueueRecorderRef ref = (OPCSAudioQueueRecorderRef)calloc(sizeof(struct OPCSAudioQueueRecorder), 1);

    ref->dataFormat.mFormatID = kAudioFormatLinearPCM;
    ref->dataFormat.mSampleRate = sampleRate;
    ref->dataFormat.mBitsPerChannel = 16;
    ref->dataFormat.mChannelsPerFrame = 1;
    ref->dataFormat.mFramesPerPacket = 1;
    ref->dataFormat.mBytesPerFrame  = ref->dataFormat.mBitsPerChannel / 8;
    ref->dataFormat.mBytesPerPacket = ref->dataFormat.mBytesPerFrame * ref->dataFormat.mFramesPerPacket;
    ref->dataFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
    
    ref->userInfo = userInfo;
    ref->callback = callback;
    
    return ref;
}

void OPCSAudioQueueSourceDestroy(OPCSAudioQueueRecorderRef ref) {
    
    if(ref->queue) {
      OSStatus status = AudioQueueDispose ( ref->queue, true);
       FormatError(status);
    }
    
    ref->queue = NULL;
    
    ref->callback = NULL;
    ref->isRunning = false;
    ref->userInfo = nil;
    
}

static void OPCSAudioQueueHandleInputBuffer (
                                             void                                 *aqData,
                                             AudioQueueRef                        inAQ,
                                             AudioQueueBufferRef                  inBuffer,
                                             const AudioTimeStamp                 *inStartTime,
                                             UInt32                               inNumPackets,
                                             const AudioStreamPacketDescription   *inPacketDesc
                                             ) ;

OSStatus OPCSAudioQueueSourceStartRecord(OPCSAudioQueueRecorderRef ref) {
    OSStatus status = noErr;
    
    if(ref->isRunning)
        return noErr;
    
    ref->isRunning = true;
    
#ifndef OSX
    status = AudioSessionInitialize(NULL, NULL, NULL, NULL);
    if (status!=noErr) {
        FormatError(status);
        return status;
    }
    
    status = AudioSessionSetActive(true);
    if (status!=noErr) {
        FormatError(status);
        return status;
    }
#endif

    status = AudioQueueNewInput(&ref->dataFormat, OPCSAudioQueueHandleInputBuffer, ref, NULL, kCFRunLoopCommonModes, 0, &(ref->queue));
    
    if (status!=noErr) {
        FormatError(status);
        return status;
    }
    
    UInt32 propertySize = sizeof(AudioStreamBasicDescription);
    
    status = AudioQueueGetProperty(ref->queue, kAudioQueueProperty_StreamDescription, &(ref->dataFormat), &propertySize);
    if (status!=noErr) {
        FormatError(status);
        return status;
    }
    
    for (int i = 0; i < kNumberBuffers; ++i) {
        status = AudioQueueAllocateBuffer ( ref->queue, 4410, &ref->buffers[i]);
        if (status!=noErr) {
            FormatError(status);
            break;
        }
        status = AudioQueueEnqueueBuffer ( ref->queue, ref->buffers[i], 0, NULL );
        if (status!=noErr) {
            FormatError(status);
            break;
        }
    }
    
    if (status!=noErr) {
        FormatError(status);
        return status;
    }
    
    status = AudioQueueStart( ref->queue, NULL);

    if (status!=noErr) {
        FormatError(status);
        return status;
    }
    
    return noErr;
}



void FormatError( OSStatus error)
{
//    char *str = malloc(6);
//    // see if it appears to be a 4-char-code
//    *(UInt32 *)(str + 1) = CFSwapInt32HostToBig(error);
//    if (isprint(str[1]) && isprint(str[2]) && isprint(str[3]) && isprint(str[4])) {
//        str[0] = str[5] = '\'';
//        str[6] = '\0';
//    } else {
//        // no, format it as an integer
//        sprintf(str, "%d", (int)error);
//    }
//    
//     printf("%s", str);
   
}


void OPCSAudioQueueSourceStopRecord(OPCSAudioQueueRecorderRef ref){
    if (ref->isRunning) {
        OPCSAudioQueueSourceDestroy(ref);
        free(ref);
    }
}

static void OPCSAudioQueueHandleInputBuffer (
                               void                                 *aqData,
                               AudioQueueRef                        inAQ,
                               AudioQueueBufferRef                  inBuffer,
                               const AudioTimeStamp                 *inStartTime,
                               UInt32                               inNumPackets,
                               const AudioStreamPacketDescription   *inPacketDesc
                               ) {
    OPCSAudioQueueRecorderRef ref = (OPCSAudioQueueRecorderRef)aqData;
    
    if (inNumPackets == 0 && ref->dataFormat.mBytesPerPacket != 0)
        inNumPackets = inBuffer->mAudioDataByteSize / ref->dataFormat.mBytesPerPacket;

    if (ref->isRunning == false)
        return;
    if(ref->callback)
        ref->callback(ref,inAQ,inBuffer);
    
    AudioQueueEnqueueBuffer ( ref->queue, inBuffer, 0, NULL);
}

Float64 OPCSSourceGetCurrentTime(OPCSAudioQueueRecorderRef ref) {
    Float64 time = -1;
    AudioTimeStamp queueTime;
    
    OSStatus err = AudioQueueGetCurrentTime(ref->queue, NULL, &queueTime, NULL);
    
    
    if(err == 0) time = queueTime.mSampleTime / 11025;
    else
        fprintf(stderr, "Getting time error: %i\n", (int)err);
    
    return time;
}
