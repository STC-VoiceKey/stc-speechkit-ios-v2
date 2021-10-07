//
//  STCURLManager.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 19.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCTTSURLManager.h"

static NSString *kTTSApiURL                = @"TTSApiURL";
static NSString *kTTSSessionURL            = @"session";
static NSString *kTTSLanguages             = @"v1/languages";
static NSString *kTTSVoices                = @"voices";
static NSString *kTTSSynthesize            = @"v1/synthesize";
static NSString *kTTSSynthesizeSessionless = @"v1/synthesize/sessionless";
static NSString *kTTSStream                = @"v1/synthesize/stream";

@implementation STCTTSURLManager

+(NSString *)ttsApiUrl {
    static dispatch_once_t once;
    static id apiurl;
    dispatch_once(&once, ^{
        apiurl = [NSBundle.mainBundle objectForInfoDictionaryKey:kTTSApiURL];
    });
    return apiurl;
}

+(NSString *)ttsStartSession {
    static dispatch_once_t once_ttsStartSession;
    static id urlttsStartSession;
    dispatch_once(&once_ttsStartSession, ^{
        urlttsStartSession = [NSString stringWithFormat:@"%@/%@",STCTTSURLManager.ttsApiUrl, kTTSSessionURL];
    });
    return urlttsStartSession;
}

+(NSString *)ttsCloseSession {
    static dispatch_once_t once_ttsCloseSession;
    static id urlttsCloseSession;
    dispatch_once(&once_ttsCloseSession, ^{
        urlttsCloseSession = STCTTSURLManager.ttsStartSession;
    });
    return urlttsCloseSession;
}

+(NSString *)ttsObtainLanguages {
    static dispatch_once_t once_ttsObtainLanguage;
    static id urlttsObtainLanguage;
    dispatch_once(&once_ttsObtainLanguage, ^{
        urlttsObtainLanguage = [NSString stringWithFormat:@"%@/%@",STCTTSURLManager.ttsApiUrl, kTTSLanguages];
    });
    return urlttsObtainLanguage;
}

+(NSString *)ttsVoiceForLanguage:(NSString *)language {
    return  [NSString stringWithFormat:@"%@/%@/%@/%@", STCTTSURLManager.ttsApiUrl, kTTSLanguages, language, kTTSVoices];
}

+(NSString *)ttsSynthesize {
    static dispatch_once_t once_ttsSynthesizeText;
    static id urlttsSynthesizeText;
    dispatch_once(&once_ttsSynthesizeText, ^{
        urlttsSynthesizeText = [NSString stringWithFormat:@"%@/%@", STCTTSURLManager.ttsApiUrl, kTTSSynthesize];
    });
    return urlttsSynthesizeText;
}

+(NSString *)ttsSynthesizeSessionless {
    static dispatch_once_t once_ttsSynthesizeSessionless;
    static id urlttsSynthesizeSessionless;
    dispatch_once(&once_ttsSynthesizeSessionless, ^{
        urlttsSynthesizeSessionless = [NSString stringWithFormat:@"%@/%@", STCTTSURLManager.ttsApiUrl, kTTSSynthesizeSessionless];
    });
    return urlttsSynthesizeSessionless;
}

+(NSString *)ttsStartStream {
    static dispatch_once_t once_ttsStartStream;
    static id urlttsStartStream;
    dispatch_once(&once_ttsStartStream, ^{
        urlttsStartStream = [NSString stringWithFormat:@"%@/%@",STCTTSURLManager.ttsApiUrl, kTTSStream];
    });
    return urlttsStartStream;
}

+(NSString *)ttsCloseStream {
    static dispatch_once_t once_ttsCloseStream;
    static id urlttsCloseStream;
    dispatch_once(&once_ttsCloseStream, ^{
        urlttsCloseStream = STCTTSURLManager.ttsStartStream;
    });
    return urlttsCloseStream;
}

@end
