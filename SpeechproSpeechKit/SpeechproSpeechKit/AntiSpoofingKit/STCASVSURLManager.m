//
//  STCASVSURLManager.m
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 18.09.2018.
//

#import "STCASVSURLManager.h"

static NSString *kASVSApiURL = @"ASVSApiURL";
static NSString *kInspect    = @"inspect";

@implementation STCASVSURLManager

+(NSString *)spoofingApiUrl {
    static dispatch_once_t once_spoofingApiUrl;
    static id apiurl_spoofingApiUrl;
    dispatch_once(&once_spoofingApiUrl, ^{
        apiurl_spoofingApiUrl = [NSBundle.mainBundle objectForInfoDictionaryKey:kASVSApiURL];
    });
    return apiurl_spoofingApiUrl;
}

+(NSString *)inspect {
    static dispatch_once_t once_inspect;
    static id inspectObtain;
    dispatch_once(&once_inspect, ^{
        inspectObtain = [NSString stringWithFormat:@"%@/%@",STCASVSURLManager.spoofingApiUrl, kInspect];
    });
    return inspectObtain;
}

@end
