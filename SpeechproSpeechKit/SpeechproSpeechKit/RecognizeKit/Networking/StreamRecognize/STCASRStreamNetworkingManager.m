//
//  STCASRStreamNetworkingManager.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 04.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCASRStreamNetworkingManager.h"
#import "STCNetworkingManager+Requests.h"
#import "STCNetworkingManager+Error.h"
#import "STCASRURLManager.h"

@interface STCASRStreamNetworkingManager()

@property (nonatomic) NSString *package;

@end

@implementation STCASRStreamNetworkingManager

-(NSString *)method {
    return @"POST";
}

-(NSDictionary *)body {
    return @{ @"model_id":self.package//,
                    //@"mime":@"audio/l16"
    };
}

//-(NSDictionary *)closeBody {
//    return @{ @"model_id":self.package//,
//                    //@"mime":@"audio/l16"
//    };
//}
-(NSString *)package {
    return ( _package==nil ) ? @"FarFieldRus10:online" : _package;
}

-(NSString *)request {
    return STCASRURLManager.asrRecognizeStream;
}

-(NSString *)closeRequest {
    return STCASRURLManager.asrRecognizeStreamClose;
}

//-(void)recognize {
-(void)progressRequest {
    NSLog(@"POST %@",[STCASRURLManager asrRecognizeStream]);
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

-(void)startStreamWithCompletionHandler:(CompletionHandler)completionHandler {
    self.package = nil;
    self.completionHandler = completionHandler;
    [self obtainWithCompletionHandler:completionHandler];
}

-(void)startStreamWithPackage:(NSString *)package
        withCompletionHandler:(CompletionHandler)completionHandler {
    self.package = package;
    self.completionHandler = completionHandler;
    [self obtainWithCompletionHandler:completionHandler];
}

-(void)closeStreamWithCompletionHandler:(CompletionHandler)completionHandler {
    self.completionHandler = completionHandler;
    NSLog(@"DELETE %@",STCASRURLManager.asrRecognizeStreamClose);
    NSURLSessionDataTask *task = [self taskRequestWithTypeRequest:@"DELETE"
                                                         withBody:nil
                                                     forURLString:self.closeRequest
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
