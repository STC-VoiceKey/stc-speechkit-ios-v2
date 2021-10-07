//
//  STCSpeechKit.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 17.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCSpeechKit.h"

#import "STCRecognizeKit.h"
#import "STCSynthesizeKit.h"
#import "STCDiarizationKit.h"

#import "STCRecognizeKitImplementation.h"
#import "STCSynthesizeKitImplementation.h"
#import "STCDiarizationKitImplementation.h"

#import "STCSynthesizer.h"
#import "STCSynthesizing.h"
#import "STCStreamSynthesizer.h"
#import "STCStreamSynthesizing.h"

#import "STCStreamRecognizer.h"
#import "STCRecognizing.h"
#import "STCRecognizer.h"
#import "STCStreamSynthesizing.h"

#import "STCDiarizator.h"
#import "STCDiarizating.h"

#import "STCASVSpoofer.h"

@implementation STCSpeechKit

+(STCSpeechKit *)sharedInstance{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[STCSpeechKit alloc] init];
    });
    return sharedInstance;
}

-(id<STCSynthesizeKit>)synthesizeKit {
    return [[STCSynthesizeKitImplementation alloc] init];
}

-(id<STCRecognizeKit>)recognizeKit {
    return [[STCRecognizeKitImplementation alloc] init];
}

-(id<STCDiarizationKit>)diarizationKit {
    return [[STCDiarizationKitImplementation alloc] init];
}

-(id<STCSynthesizing>)synthesizer {
    return [[STCSynthesizer alloc] init];
}

-(id<STCStreamSynthesizing>)streamSynthesizer {
    return [[STCStreamSynthesizer alloc] init];
}

-(id<STCDiarizating>)diarizator {
     return [[STCDiarizator alloc] init];
}

-(id<STCRecognizing>)recognizer {
    return [[STCRecognizer alloc] init];
}

-(id<STCStreamRecognizing>)streamRecognizer {
    return [[STCStreamRecognizer alloc] init];
}

-(id<STCASVSpoofing>)spoofer {
    return [[STCASVSpoofer alloc] init];
}
@end
