//
//  STCSpeechKit.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 17.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCDiarizating.h"
#import "STCRecognizing.h"

#import "STCAuthorizationData.h"
#import "STCSynthesizeKit.h"
#import "STCRecognizeKit.h"
#import "STCDiarizationKit.h"
#import "STCSynthesizing.h"
#import "STCStreamSynthesizing.h"
#import "STCStreamRecognizing.h"
#import "STCASVSpoofing.h"

/**
    The 'STCSpeechKit' manages a settings of framework
 */
@interface STCSpeechKit : NSObject

/**
 The shared default instance of `STCSpeechKit` initialized with default values.
 */
+(STCSpeechKit *)sharedInstance;

/**
    The data necessary for authorization in system
 */
@property (nonatomic) id<STCAuthorizationData> authorizationData;

/**
 Returns the new instance of the synthesize kit
 */
-(id<STCSynthesizeKit>)synthesizeKit;

/**
 Returns the new instance of the recognize kit
 */
-(id<STCRecognizeKit>)recognizeKit;


/**
 Returns the new instance of the diarization kit
 */
-(id<STCDiarizationKit>)diarizationKit;

/**
 Returns the new instance of the synthesizer
 */
-(id<STCSynthesizing>)synthesizer;

/**
 Returns the new instance of the stream synthesizer
 */
-(id<STCStreamSynthesizing>)streamSynthesizer;

/**
 Returns the new instance of the diarizator
 */
-(id<STCDiarizating>)diarizator;

/**
 Returns the new instance of the recognizer
 */
-(id<STCRecognizing>)recognizer;

/**
 Returns the new instance of the
 */
-(id<STCStreamRecognizing>)streamRecognizer;

/**
 Returns the new instance of the
 */
-(id<STCASVSpoofing>)spoofer;


@end
