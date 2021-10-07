//
//  OPCSCaptureVoice2BufferManager.h
//  OnePassCaptureStandard
//
//  Created by Soloshcheva Aleksandra on 06.09.16.
//  Copyright © 2016 Speech Technology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, OPCSCaptureVoiceMode) {
    OPCSCaptureVoiceModeNormal,
    OPCSCaptureVoiceModePortion
};

typedef void (^LoadDataBlock) ( NSData *data, NSError *error);

/**
 * Provides the voice resource.
 * Writes the voice data into a buffer.
 */
@interface OPCSCaptureVoice2BufferManager :  NSObject

/**
 * Creates the new manager with sample rate
 * @param sampleRate The sample rate
 */
-(id)initWithSampleRate:(NSUInteger)sampleRate;

/**
 * Creates the new manager with the sample rate and voice capture mode
 * @param sampleRate The sample rate
 */
-(id)initWithSampleRate:(NSUInteger)sampleRate withMode:(OPCSCaptureVoiceMode)mode;

/**
 * The block called when data recieved
 */
@property (nonatomic,copy) LoadDataBlock loadDataBlock;

/**
 * Shows the recording in progress
 */
@property(nonatomic) BOOL isRecording;

/**
 * Starts recording
 */
-(void)record;

/**
 * Stops recording
 */
-(void)stop;

@end
