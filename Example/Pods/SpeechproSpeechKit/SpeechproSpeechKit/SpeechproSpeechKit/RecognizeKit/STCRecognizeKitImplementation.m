//
//  STCRecognizeKit.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 28.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCRecognizeKitImplementation.h"
#import "STCASRRecognizeNetworkingManager.h"
#import "STCASRStreamNetworkingManager.h"
#import "STCASRPackageListNetworkingManager.h"

@interface STCRecognizeKitImplementation()

@property (nonatomic) RecognizeCompletionHandler recognizeCompletionHandler;
@property (nonatomic) RecognizeCompletionHandler streamCompletionHandler;

@property (nonatomic) STCASRStreamNetworkingManager *streamNetworkingManager;

@end

@implementation STCRecognizeKitImplementation

-(void)obtainPackagesWithCompletionHandler:(PackagesCompletionHandler)completionHandler{
    STCASRPackageListNetworkingManager * packageListNetworkingManager = [[STCASRPackageListNetworkingManager alloc] init];
    [packageListNetworkingManager obtainPackagesWithCompletionHandler:^(NSError *error, NSObject *result) {
        NSArray<NSDictionary *>*resultArray = (NSArray<NSDictionary *>*)result;
        completionHandler(error,resultArray);
    }];
}

-(void)recognize:(NSData *)voice withCompletionHandler:(RecognizeCompletionHandler )completionHandler {
    self.recognizeCompletionHandler = completionHandler;
    STCASRRecognizeNetworkingManager *recognizeNetworkingManager = [[STCASRRecognizeNetworkingManager alloc] init];
    [recognizeNetworkingManager recognizeSpeech:[voice base64EncodedStringWithOptions:0]
                          withCompletionHandler:^(NSError *error, NSObject *result) {
                              NSDictionary *recognizeResult = (NSDictionary *)result;
                              self.recognizeCompletionHandler(error, recognizeResult);
                    }];
}

-(void)recognize:(NSData *)voice
     withPackage:(NSString *)package
withCompletionHandler:(RecognizeCompletionHandler)completionHandler {
    self.recognizeCompletionHandler = completionHandler;
    STCASRRecognizeNetworkingManager *recognizeNetworkingManager = [[STCASRRecognizeNetworkingManager alloc] init];
    [recognizeNetworkingManager recognizeSpeech:[voice base64EncodedStringWithOptions:0]
                                    withPackage:package
                          withCompletionHandler:^(NSError *error, NSObject *result) {
                              NSDictionary *recognizeResult = (NSDictionary *)result;
                              self.recognizeCompletionHandler(error, recognizeResult);
                          }];
}

-(void)streamWithCompletionHandler:(RecognizeCompletionHandler)completionHandler {
    self.streamCompletionHandler = completionHandler;
    self.streamNetworkingManager = [[STCASRStreamNetworkingManager alloc] init];
    [self.streamNetworkingManager startStreamWithCompletionHandler:^(NSError *error, NSObject *result) {
        NSDictionary *recognizeResult = (NSDictionary *)result;
        self.streamCompletionHandler(error, recognizeResult);
    }];
}

-(void)streamWithPackage:(NSString *)package
   withCompletionHandler:(RecognizeCompletionHandler)completionHandler {
    self.streamCompletionHandler = completionHandler;
    self.streamNetworkingManager = [[STCASRStreamNetworkingManager alloc] init];
    [self.streamNetworkingManager startStreamWithPackage:package withCompletionHandler:^(NSError *error, NSObject *result) {
        NSDictionary *recognizeResult = (NSDictionary *)result;
        self.streamCompletionHandler(error, recognizeResult);
    }];
}

-(void)closeStreamWithCompletionHandler:(RecognizeCompletionHandler)completionHandler  {
    self.streamCompletionHandler = completionHandler;
    if ( self.streamNetworkingManager ) {
        [self.streamNetworkingManager closeStreamWithCompletionHandler:^(NSError *error, NSObject *result) {
            NSDictionary *recognizeResult = (NSDictionary *)result;
            self.streamCompletionHandler(error, recognizeResult);
        }];
    }
}

@end
