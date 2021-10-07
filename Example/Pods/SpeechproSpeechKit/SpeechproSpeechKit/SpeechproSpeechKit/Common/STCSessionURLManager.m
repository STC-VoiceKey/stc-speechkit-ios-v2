//
//  STCSessionURLManager.m
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 18.09.2018.
//

#import "STCSessionURLManager.h"

static NSString *kSessionApiURL     = @"SessionApiURL";
static NSString *kSessionURL        = @"session";

@implementation STCSessionURLManager

+(NSString *)sessionApiUrl {
    static dispatch_once_t once;
    static id session_apiurl;
    dispatch_once(&once, ^{
        session_apiurl = [NSBundle.mainBundle objectForInfoDictionaryKey:kSessionApiURL];
    });
    return session_apiurl;
}

+(NSString *)startSession {
    static dispatch_once_t once_sessionStartSession;
    static id sessionStartSession;
    dispatch_once(&once_sessionStartSession, ^{
        sessionStartSession = [NSString stringWithFormat:@"%@/%@", STCSessionURLManager.sessionApiUrl, kSessionURL];
    });
    return sessionStartSession;
}

+(NSString *)closeSession {
    return STCSessionURLManager.startSession;
}

@end
