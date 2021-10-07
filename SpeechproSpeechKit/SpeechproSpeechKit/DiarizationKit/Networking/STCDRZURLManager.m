//
//  STCTTSDiarizationURLManager.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 28.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCDRZURLManager.h"

static NSString *kDiarizationApiURL     = @"DiarizationApiURL";
static NSString *kDiarizationSessionURL = @"session";
static NSString *kDiarization           = @"v1/diarization";

@implementation STCDRZURLManager

+(NSString *)diarizationApiUrl {
    static dispatch_once_t once;
    static id apiurl;
    dispatch_once(&once, ^{
        apiurl = [NSBundle.mainBundle objectForInfoDictionaryKey:kDiarizationApiURL];
    });
    return apiurl;
}

+(NSString *)diarization {
    static dispatch_once_t once_diarizationObtain;
    static id diarizationObtain;
    dispatch_once(&once_diarizationObtain, ^{
        diarizationObtain = [NSString stringWithFormat:@"%@/%@",STCDRZURLManager.diarizationApiUrl, kDiarization];
    });
    return diarizationObtain;
}

@end
