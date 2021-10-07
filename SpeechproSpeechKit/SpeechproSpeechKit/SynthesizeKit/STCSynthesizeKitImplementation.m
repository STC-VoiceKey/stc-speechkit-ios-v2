//
//  STCSynthesizeKit.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 17.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//
#import "STCSpeechKit.h"
#import "STCSynthesizeKitImplementation.h"
#import "STCTTSLanguageNetworkingManager.h"
#import "STCTTSVoiceNetworkingManager.h"
#import "STCTTSSynthesizeNetworkingManager.h"
#import "STCTTSStreamNetworkingManager.h"
#import "NSString+Language.h"
#import "STCError.h"

@interface STCSynthesizeKitImplementation()

@property (nonatomic) LanguageCompletionHandler   languageCompletionHandler;
@property (nonatomic) VoicesCompletionHandler     voicesCompletionHandler;
@property (nonatomic) SynthesizeCompletionHandler synthesizeCompletionHandler;
@property (nonatomic) StreamCompletionHandler     streamCompletionHandler;

@property (nonatomic) STCTTSStreamNetworkingManager *streamNetworkingManager;

@end

@implementation STCSynthesizeKitImplementation

-(void)obtainLanguagesWithCompletionHandler:(LanguageCompletionHandler)completionHandler {
    self.languageCompletionHandler = completionHandler;
    STCTTSLanguageNetworkingManager *networkingManager = [[STCTTSLanguageNetworkingManager alloc] init];
    [networkingManager obtainLanguagesWithCompletionHandler:^(NSError *error, NSObject *result) {
        NSArray<NSDictionary *> *langs = (NSArray<NSDictionary *> *)result;
        self.languageCompletionHandler(error, langs);
    }];
}

-(void)obtainVoicesForLanguage:(NSString *)language
         withCompletionHandler:(VoicesCompletionHandler)completionHandler {
    self.voicesCompletionHandler = completionHandler;
    STCTTSVoiceNetworkingManager *networkingManager = [[STCTTSVoiceNetworkingManager alloc] init];
    [networkingManager obtainVoicesForLanguage:language withCompletionHandler:^(NSError *error, NSObject *result) {
        NSArray<NSDictionary *> *voices = (NSArray<NSDictionary *> *)result;
        self.voicesCompletionHandler(error, voices);
    }];
}

-(void)synthesizeText:(NSString *)text
            withVoice:(NSString *)voice
withCompletionHandler:(SynthesizeCompletionHandler)completionHandler {
    self.synthesizeCompletionHandler = completionHandler;

    STCTTSSynthesizeNetworkingManager *networkingManager = [[STCTTSSynthesizeNetworkingManager alloc] init];
    [networkingManager synthesizeText:text withVoice:voice
                withCompletionHandler:^(NSError *error, NSObject *result) {
                    if (error) {
                        self.synthesizeCompletionHandler(error, nil);
                        return ;
                    }
                    
                    NSDictionary *voice = (NSDictionary *)result;
                    NSString *base64String = voice[@"data"];
                    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
                    
                    self.synthesizeCompletionHandler(nil, data);
                }];
}
    
-(void)synthesizeText:(NSString *)text
withCompletionHandler:(SynthesizeCompletionHandler)completionHandler{
    NSString *language = [text language];
    if (language == nil) {
        completionHandler(STCError.unknownLanguageError, nil);
        return;
    }
        self.synthesizeCompletionHandler = completionHandler;
    [self obtainLanguagesWithCompletionHandler:^(NSError *error, NSArray<NSDictionary *> *result) {
        BOOL isLanguageExists = NO;
        for (NSDictionary *lang in result) {
            if ([lang[@"name"] isEqualToString:language]) {
                isLanguageExists = YES;
                break;
            }
        }
        if (isLanguageExists) {
            [self obtainVoicesForLanguage:language withCompletionHandler:^(NSError *error, NSArray<NSDictionary *> *result) {
                if (error) {
                    completionHandler(error, nil);
                    return ;
                }
                
                if (result.count > 0) {
                    NSString *voice = result.firstObject[@"name"];
                    [self synthesizeText:text withVoice:voice withCompletionHandler:completionHandler];
                } else {
                    completionHandler(STCError.noVoiceForLanguageError, nil);
                    return ;
                }
            }];
        } else {
            completionHandler(STCError.unsupportedLanguageError, nil);
            return;
        }
    }];
}

-(void)streamWithLanguage:(NSString *)language withCompletionHandler:(StreamCompletionHandler)completionHandler {
    if (language == nil) {
        completionHandler(STCError.unknownLanguageError, nil);
        return;
    }
    
    self.streamCompletionHandler = completionHandler;
    
    [self obtainLanguagesWithCompletionHandler:^(NSError *error, NSArray<NSDictionary *> *result) {
        BOOL isLanguageExists = NO;
        for (NSDictionary *lang in result) {
            if ([lang[@"name"] isEqualToString:language]) {
                isLanguageExists = YES;
                break;
            }
        }
        if (isLanguageExists) {
            [self obtainVoicesForLanguage:language withCompletionHandler:^(NSError *error, NSArray<NSDictionary *> *result) {
                if (error) {
                    completionHandler(error, nil);
                    return ;
                }
                
                if (result.count > 0) {
                    NSString *voice = result.firstObject[@"name"];
                    [self streamWithVoice:voice withCompletionHandler:completionHandler];
                } else {
                    completionHandler(STCError.noVoiceForLanguageError, nil);
                    return ;
                }
            }];
        } else {
            completionHandler(STCError.unsupportedLanguageError, nil);
            return;
        }
    }];
}

-(void)streamWithVoice:(NSString *)voice
withCompletionHandler:(StreamCompletionHandler)completionHandler {
    self.streamCompletionHandler = completionHandler;
    
    self.streamNetworkingManager = [[STCTTSStreamNetworkingManager alloc] init];
    [self.streamNetworkingManager streamWithVoice:voice
                       withCompletionHandler:^(NSError *error, NSObject *result) {
                           if (error) {
                               self.streamCompletionHandler(error, nil);
                               return ;
                           }

                           NSString *url = [((NSDictionary *)result) objectForKey:@"url"];
                           self.streamCompletionHandler(nil, url);
                       }];
}

-(void)closeStream:(StreamCompletionHandler)completionHandler {
    self.streamCompletionHandler = completionHandler;
    [self.streamNetworkingManager closeStreamWithCompletionHandler:^(NSError *error, NSObject *result) {
        self.streamCompletionHandler( error, (NSString *)result);
    }];
}



@end
