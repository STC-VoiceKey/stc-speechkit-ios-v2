//
//  STCASRRecognizeNetworkingManager.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 04.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCASRRecognizeNetworkingManager.h"
#import "STCASRURLManager.h"

#import "STCNetworkingManager+Requests.h"
#import "STCNetworkingManager+Error.h"

@interface STCASRRecognizeNetworkingManager()

@property (nonatomic) NSString *voice;
@property (nonatomic) NSString *package;

@end

@implementation STCASRRecognizeNetworkingManager

-(NSString *)method {
    return @"POST";
}

-(NSDictionary *)body {
    return @{ @"audio":@{ @"data":self.voice,
                          @"mime":@"audio/x-wav" },
         @"package_id":self.package };
}

-(NSString *)package {
    return ( _package==nil ) ? @"TelecomRus" : _package;
}

-(NSString *)request {
    return STCASRURLManager.asrRecognize;
}

-(void)recognizeSpeech:(NSString *)speech64Base
 withCompletionHandler:(CompletionHandler)completionHandler {
    self.voice = speech64Base;
    [self obtainWithCompletionHandler:completionHandler];
}

-(void)recognizeSpeech:(NSString *)speech64Base
           withPackage:(NSString *)package
 withCompletionHandler:(CompletionHandler)completionHandler {
    self.package = package;
    [self recognizeSpeech:speech64Base
    withCompletionHandler:completionHandler];
}

-(void)recognize {
    NSLog(@"%@",[STCASRURLManager asrRecognize]);
    NSURLSessionDataTask *task = [self taskRequestWithTypeRequest:@"POST"
                                                         withBody:self.body
                                                     forURLString:self.request
                                                completionHandler:^(NSData * _Nullable data,
                                                                    NSURLResponse * _Nullable response,
                                                                    NSError * _Nullable error) {
                                                    
                                                    NSError *responseError = [self checkError:error
                                                                                 withResponse:response
                                                                                withErrorData:data];
                                                    if (responseError) {
                                                        self.completionHandler(responseError, nil);
                                                        return ;
                                                    }
                                                    
                                                    self.result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                
                                                    [super finalizeRequest];
                                                }];
    [task resume];
}

@end
