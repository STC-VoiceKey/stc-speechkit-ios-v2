//
//  STCNetworkingManager.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 18.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"

#import "STCSpeechKit.h"
#import "STCNetworkingManager+Error.h"
#import "STCNetworkingManager+Requests.h"
#import "STCAuthorizationData.h"

static NSString * _Nonnull kUsernameURLParam    = @"username";
static NSString * _Nonnull kDomainIdURLParam    = @"domain_id";
static NSString * _Nonnull kPasswordURLParam    = @"password";
static NSString * _Nonnull kSessionIdURLParam   = @"session_id";

@interface STCNetworkingManager()

@property (nonatomic) id<STCAuthorizationData> authorizationData;

@end

@interface STCNetworkingManager(Private)

-(NSDictionary *)authorizationDataAsBody;
-(void)startSession;
-(void)closeSession;

@end

@implementation STCNetworkingManager

-(id)init {
    self = [super init];
    if (self) {
        self.authorizationData = STCSpeechKit.sharedInstance.authorizationData;
    }
    return self;
}

-(void)obtainWithCompletionHandler:(CompletionHandler)completionHandler{
    self.completionHandler = completionHandler;
    [self startingRequest];
}

-(void)startingRequest {
    if ( self.sessionId == nil ) {
        [self startSession];
        return;
    }
    [self progressRequest];
}

-(NSString *)request{
    return nil;
}

-(NSString *)sessionRequest {
    return STCSessionURLManager.startSession;
}

-(NSString *)method{
    return @"GET";
}

-(NSDictionary *)body{
    return nil;
}

-(void)finalizeRequest {
    [self closeSession];
}

-(void)progressRequest {
    NSLog(@"progress request %@", self.request);
    NSURLSessionDataTask *task = [self taskRequestWithTypeRequest:self.method
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

@implementation STCNetworkingManager(Private)

-(void)startSession {
    NSLog(@"start session %@",self.authorizationDataAsBody);
    NSURLSessionDataTask *task = [self taskPostRequestForURLString:self.sessionRequest
                                                          withBody:self.authorizationDataAsBody
                                                 completionHandler:^(NSData * _Nullable data,
                                                                     NSURLResponse * _Nullable response,
                                                                     NSError * _Nullable error){
                                                     NSError *responseError = [self checkError:error
                                                                                  withResponse:response
                                                                                 withErrorData:data];
                                                     if (responseError) {
                                                         self.completionHandler(responseError, nil);
                                                         return ;
                                                     }
                                                     
                                                     NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                                                                          options:0
                                                                                                            error:nil];
                                                     self.sessionId = json[kSessionIdURLParam];
                                                     
                                                     [self progressRequest];
    }];
    [task resume];
}

-(void)closeSession {
    NSLog(@"close session %@",self.sessionRequest);
    NSURLSessionDataTask *task = [self taskDeleteRequestForURLString:self.sessionRequest
                                                   completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *responseError = [self checkError:error
                                     withResponse:response
                                    withErrorData:data];
        if (responseError) {
            self.completionHandler(responseError, nil);
            [self finalizeRequest];
            return ;
        }
        self.completionHandler(nil, self.result);
    }];
    [task resume];
}

-(NSDictionary *)authorizationDataAsBody {
    return @{ kUsernameURLParam:self.authorizationData.username,
              kPasswordURLParam:self.authorizationData.password,
              kDomainIdURLParam:self.authorizationData.domainid};
}

@end
