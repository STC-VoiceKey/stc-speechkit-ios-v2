 //
//  OPCSCaptureVoice2BufferManager.m
//  OnePassCaptureStandard
//
//  Created by Soloshcheva Aleksandra on 06.09.16.
//  Copyright © 2016 Speech Technology Center. All rights reserved.
//

#import "OPCSCaptureVoice2BufferManager.h"
#import "OPCSAudioQueueRecorder.h"
#import <AVFoundation/AVFoundation.h>

static NSString *kOnePassLimitNoise = @"kOnePassVoiceNoiseLimit";
static NSString *kVoiceNoiseLimitName = @"VoiceNoiseLimit";

@interface OPCSCaptureVoice2BufferManager()

@property (nonatomic) NSUInteger sampleRate;
@property (nonatomic) OPCSCaptureVoiceMode mode;

@property (nonatomic) OPCSAudioQueueRecorderRef source;
@property (nonatomic) NSMutableData *voiceBuffer;

@end

@interface OPCSCaptureVoice2BufferManager(PrivateMethods)

-(NSMutableData *)addWavHeader:(NSData *)wav;
-(void)addData:(OPCSAudioQueueRecorderRef)recorderRef fromBuffer:(AudioQueueBufferRef)bufRef;

@end

void OPCRRecorderCallback(OPCSAudioQueueRecorderRef ref, AudioQueueRef audioQueue, AudioQueueBufferRef bufRef);

@implementation OPCSCaptureVoice2BufferManager

-(id)initWithSampleRate:(NSUInteger)sampleRate {
    self = [super init];
    if (self) {
        self.sampleRate = sampleRate;
        self.mode = OPCSCaptureVoiceModeNormal;
    }
    return self;
}

-(id)initWithSampleRate:(NSUInteger)sampleRate
               withMode:(OPCSCaptureVoiceMode)mode {
    self = [super init];
    if (self) {
        self.sampleRate = sampleRate;
        self.mode = mode;
    }
    return self;
}

-(void)record {
    @synchronized(self) {
        if(self.isRecording) {
            if (self.loadDataBlock) {
                self.loadDataBlock(nil,[NSError errorWithDomain:@"com.onepass.captureresource"
                                                           code:400
                                                       userInfo:@{ NSLocalizedDescriptionKey: @"Record is running exeption"}]);
            }
            return;
        }
    }

    self.voiceBuffer = [[NSMutableData alloc] init];
    
    self.isRecording = YES;
    
    self.source = OPCRAudioQueueSourceCreate(OPCRRecorderCallback,(__bridge void *)self, self.sampleRate);
    OPCSAudioQueueSourceStartRecord(self.source);
}

-(void)stop {
    @synchronized(self) {
        if(self.isRecording) {
            self.isRecording = NO;
            OPCSAudioQueueSourceStopRecord(self.source);
            if (self.loadDataBlock && (self.mode==OPCSCaptureVoiceModeNormal) ) {
                self.loadDataBlock([self addWavHeader:self.voiceBuffer],nil);
            }
        }
    }
}

-(NSTimeInterval)currentTime {
    return (self.isRecording) ? OPCSSourceGetCurrentTime(self.source) : 0;
}

-(void)dealloc {
    _voiceBuffer = nil;
}

@end

@implementation OPCSCaptureVoice2BufferManager(PrivateMethods)

-(NSMutableData *)addWavHeader:(NSData *)wav {
    NSMutableData *wavHeader = [[NSMutableData alloc] init];
    
    NSUInteger sampleRate = self.sampleRate;
    NSUInteger bps = 16;
    
    NSUInteger numChannels = 1;
    NSUInteger byteRate = sampleRate * numChannels * (bps/8);
    NSUInteger blockAlign = numChannels * (bps/8);
    
    [wavHeader appendBytes:"RIFF" length:4]; // 0x52, 0x49, 0x46, 0x46, whole file is RIFF chunk
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(36 + wav.length) } length: 4]; // RIFF chunk size (== WAVE subchunk + data chunk)
    [wavHeader appendBytes:"WAVE" length:4];// 0x57, 0x41, 0x56, 0x45, WAVE chunk
    [wavHeader appendBytes:"fmt " length:4];// 0x66, 0x6D, 0x74, 0x20, fmt subchunk of WAVE chunk
    
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(16) } length: 4]; // 0x10, 0x00, 0x00, 0x00, fmt subchunk size (16 for PCM)
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(1) }  length: 2]; // 0x01, 0x00, PCM format
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(numChannels) } length: 2];
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(sampleRate)  } length: 4];
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(byteRate) } length: 4];
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(blockAlign) } length: 2];
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(bps) } length:2 ];// end of fmt subchunk
    
    [wavHeader appendBytes:"data" length:4];
    [wavHeader appendBytes: (uint64_t[]){ (uint64_t)(wav.length) } length:4 ];
    
    [wavHeader appendData:wav];
    
    return wavHeader;
}

-(void)addData:(OPCSAudioQueueRecorderRef)recorderRef fromBuffer:(AudioQueueBufferRef)bufRef{
    if(self.isRecording) {
        @synchronized (self) {
            if (self.mode==OPCSCaptureVoiceModeNormal) {
                [self.voiceBuffer appendBytes: bufRef->mAudioData length: bufRef->mAudioDataByteSize];
            } else {
                NSData *portion = [NSData dataWithBytes:bufRef->mAudioData length:bufRef->mAudioDataByteSize];
                self.loadDataBlock(portion, nil);
            }
        }
    }
}

@end

void OPCRRecorderCallback(OPCSAudioQueueRecorderRef ref, AudioQueueRef audioQueue, AudioQueueBufferRef bufRef) {
    if (ref && ref->userInfo) {
        OPCSCaptureVoice2BufferManager* manager = (__bridge OPCSCaptureVoice2BufferManager*)ref->userInfo;
        if(ref->queue != audioQueue) return;
        
        [manager addData:ref fromBuffer:bufRef];
    }
}
