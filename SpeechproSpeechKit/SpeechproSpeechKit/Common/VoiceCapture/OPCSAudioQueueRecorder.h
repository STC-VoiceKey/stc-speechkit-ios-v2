//
//  OPCSAudioQueueRecorder.h
//  OnePassCaptureStandard
//
//  Created by Soloshcheva Aleksandra on 06.09.16.
//  Copyright © 2016 Speech Technology Center. All rights reserved.
//

#ifndef OPCSAudioQueueRecorder_h
#define OPCSAudioQueueRecorder_h

#include <AudioToolbox/AudioToolbox.h>

#include <stdio.h>

/**
 * The type definition of the pointer to OPCSAudioQueueRecorderRef
 */
typedef struct OPCSAudioQueueRecorder* OPCSAudioQueueRecorderRef;

/**
 * Is type for the callback function which is invoked when the buffer is full
 */
typedef void(*OPCSAudioQueueRecorderCallbackPointer)(OPCSAudioQueueRecorderRef, AudioQueueRef, AudioQueueBufferRef) ;

/**
 * The constant of the number of buffers
 */
static const int kNumberBuffers = 3;


/**
 * The struct of the audio queue recorder
 */
struct OPCSAudioQueueRecorder{
    ///This structure encapsulates all the information for describing the format of an audio stream.
    AudioStreamBasicDescription  dataFormat;
    ///Defines an opaque data type that represents an audio queue.
    AudioQueueRef                queue;
    //An array of pointers to an AudioQueueBuffer.
    AudioQueueBufferRef          buffers[kNumberBuffers];
    ///The size of buffers in bytes
    UInt32                       bufferByteSize;
    ///Shows that recording is in progress
    bool                         isRunning;
    /// The pointer to the additional data 
    void                        *userInfo;
    ///The pointer to the callback function which is invoked when the buffer is full
    OPCSAudioQueueRecorderCallbackPointer		callback;
};


/**
 * Creates the audio queue source and return reference to it

 * @param callback The pointer to the callback function
 * @param userInfo The additional data passed to the callback function
 * @return The reference to the audio queue recorder
 */

OPCSAudioQueueRecorderRef OPCRAudioQueueSourceCreate(OPCSAudioQueueRecorderCallbackPointer callback, void *userInfo, Float64 sampleRate);

/**
 * Destroys the audio queue recorder
 * @param ref The reference to the audio queue recorder
 */
void OPCSAudioQueueSourceDestroy(OPCSAudioQueueRecorderRef ref);

/**
 * Starts recording

 * @param ref The audio queue recorder references
 * @return The recorder status
 */
OSStatus OPCSAudioQueueSourceStartRecord(OPCSAudioQueueRecorderRef ref);

/**
 * Stops recording
 * @param ref The audio queue recorder references
 */
void OPCSAudioQueueSourceStopRecord(OPCSAudioQueueRecorderRef ref);

/**
 * Returns the current time
 * @param ref The audio queue recorder references
 * @return The timestamp
 */
Float64 OPCSSourceGetCurrentTime(OPCSAudioQueueRecorderRef ref);

#endif /* OPCSAudioQueueRecorder_h */
