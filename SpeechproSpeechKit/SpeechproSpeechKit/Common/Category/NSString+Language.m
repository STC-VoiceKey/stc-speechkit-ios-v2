//
//  NSString+Language.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 25.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "NSString+Language.h"

@implementation NSString (Language)

-(NSString *)language {
    NSString *languageCode  =  (NSString *) CFBridgingRelease(CFStringTokenizerCopyBestStringLanguage((CFStringRef)self, CFRangeMake(0, self.length)));
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    return [locale displayNameForKey:NSLocaleIdentifier value:languageCode];

}


@end
