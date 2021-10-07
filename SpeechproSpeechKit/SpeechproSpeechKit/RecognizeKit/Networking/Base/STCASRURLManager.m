//
//  STCASRURLManager.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 03.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCASRURLManager.h"

static NSString *kASRApiURL = @"ASRApiURL";

static NSString *kASRSessionURL            = @"session";

static NSString *kASRPackages              = @"v2/models";

static NSString *kASRRecognize            = @"v2/recognizer/simple";
static NSString *kASRRecognizeWords       = @"v2/recognizer/words";

static NSString *kASRRecognizeStream      = @"v2/transaction/ws";
static NSString *kASRRecognizeStreamClose = @"v2/transaction";

@implementation STCASRURLManager

+(NSString *)asrApiUrl {
    static dispatch_once_t once_asr;
    static id asrapiurl;
    dispatch_once(&once_asr, ^{
        asrapiurl = [NSBundle.mainBundle objectForInfoDictionaryKey:kASRApiURL];
    });
    return asrapiurl;
}

+(NSString *)asrStartSession {
    static dispatch_once_t once_asrStartSession;
    static id urlasrStartSession;
    dispatch_once(&once_asrStartSession, ^{
        urlasrStartSession = [NSString stringWithFormat:@"%@/%@", STCASRURLManager.asrApiUrl, kASRSessionURL];
    });
    return urlasrStartSession;
}

+(NSString *)asrCloseSession {
    static dispatch_once_t once_asrCloseSession;
    static id urlasrCloseSession;
    dispatch_once(&once_asrCloseSession, ^{
        urlasrCloseSession = STCASRURLManager.asrStartSession;
    });
    return urlasrCloseSession;
}

#pragma mark - Packages

+(NSString *)asrAvailablePackages {
    static dispatch_once_t once_asrAvailablePackages;
    static id urlasrAvailablePackages;
    dispatch_once(&once_asrAvailablePackages, ^{
        urlasrAvailablePackages = [NSString stringWithFormat:@"%@/%@", STCASRURLManager.asrApiUrl, kASRPackages];
    });
    return urlasrAvailablePackages;
}


#pragma mark - recognize

+(NSString *)asrRecognize {
    static dispatch_once_t once_asrRecognize;
    static id urlasrRecognize;
    dispatch_once(&once_asrRecognize, ^{
        urlasrRecognize = [NSString stringWithFormat:@"%@/%@", STCASRURLManager.asrApiUrl, kASRRecognize];
    });
    return urlasrRecognize;
}

+(NSString *)asrRecognizeStream {
    static dispatch_once_t once_asrRecognizeStream;
    static id urlasrRecognizeStream;
    dispatch_once(&once_asrRecognizeStream, ^{
        urlasrRecognizeStream = [NSString stringWithFormat:@"%@/%@", STCASRURLManager.asrApiUrl, kASRRecognizeStream];
    });
    return urlasrRecognizeStream;
}

+(NSString *)asrRecognizeStreamClose {
    static dispatch_once_t once_asrRecognizeStream;
    static id urlasrRecognizeStream;
    dispatch_once(&once_asrRecognizeStream, ^{
        urlasrRecognizeStream = [NSString stringWithFormat:@"%@/%@", STCASRURLManager.asrApiUrl, kASRRecognizeStreamClose];
    });
    return urlasrRecognizeStream;
}

@end
