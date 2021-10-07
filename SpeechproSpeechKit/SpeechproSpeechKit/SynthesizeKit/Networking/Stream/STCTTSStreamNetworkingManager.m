//
//  STCTTSStreamNetworkingManager.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 08.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCTTSStreamNetworkingManager.h"
#import "STCTTSURLManager.h"
#import "STCNetworkingManager+Requests.h"
#import "STCNetworkingManager+Error.h"

@interface STCTTSStreamNetworkingManager()

@property (nonatomic) NSString *voice;

@end

@implementation STCTTSStreamNetworkingManager

-(NSString *)method {
    return @"POST";
}

-(NSDictionary *)body {
    return @{ @"text":@{  @"mime":@"text/plain" },
        @"voice_name":self.voice,
             @"audio":@"audio/wav" };
}

-(NSString *)request {
    return STCTTSURLManager.ttsStartStream;
}

-(void)streamWithVoice:(NSString *)voice
 withCompletionHandler:(CompletionHandler)completionHandler {
    self.voice = voice;
    self.completionHandler = completionHandler;
    
    [self startingRequest];
}

-(void)progressRequest {
    NSLog(@"POST %@",[STCTTSURLManager ttsStartStream]);
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
                                                    
                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                    self.transactionId = [httpResponse allHeaderFields][@"X-Transaction-Id"];
                                                    self.completionHandler(nil, self.result);
                                                }];
    [task resume];
}

-(void)closeStreamWithCompletionHandler:(CompletionHandler)completionHandler {
    self.completionHandler = completionHandler;
    NSLog(@"DELETE %@",[STCTTSURLManager ttsCloseStream]);
    NSURLSessionDataTask *task = [self taskRequestWithTypeRequest:@"DELETE"
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
                                                        
                                                        [self finalizeRequest];
                                                    }];
        [task resume];
    }

@end
