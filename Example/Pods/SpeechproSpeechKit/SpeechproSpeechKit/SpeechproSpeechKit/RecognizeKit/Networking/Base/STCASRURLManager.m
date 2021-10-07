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

static NSString *kASRPackages              = @"v1/packages/available";
static NSString *kASRPackageLoad           = @"v1/packages/%@/load";
static NSString *kASRPackageUpload         = @"v1/packages/%@/unload";

static NSString *kASRRecognize            = @"v1/recognize";
static NSString *kASRRecognizeWords       = @"v1/recognize/words";
static NSString *kASRRecognizeStream      = @"v1/recognize/stream";

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

+(NSString *)asrLoadPackage:(NSString *)package {
    NSString *subUrl = [NSString stringWithFormat:kASRPackageLoad, package];
    return  [NSString stringWithFormat:@"%@/%@", STCASRURLManager.asrApiUrl, subUrl];
}

+(NSString *)asrUnloadPackage:(NSString *)package {
    NSString *subUrl = [NSString stringWithFormat:kASRPackageUpload, package];
    return  [NSString stringWithFormat:@"%@/%@", STCASRURLManager.asrApiUrl, subUrl];
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

@end
