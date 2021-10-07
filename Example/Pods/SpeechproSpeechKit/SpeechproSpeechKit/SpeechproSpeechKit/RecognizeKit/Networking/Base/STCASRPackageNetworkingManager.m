//
//  STCASRPackageNetworkingManager.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 28.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCASRPackageNetworkingManager.h"
#import "STCASRURLManager.h"

#import "STCNetworkingManager+Requests.h"
#import "STCNetworkingManager+Error.h"

@interface STCASRPackageNetworkingManager()


@end

@interface STCASRPackageNetworkingManager(Private)

-(void)loadPackage;
-(void)unloadPackage;
-(void)recognize;

@end

@implementation STCASRPackageNetworkingManager

-(void)progressRequest {
    [self loadPackage];
}

-(NSString *)package {
    return nil;
}

-(void)finalizeRequest {
    [self unloadPackage];
}

@end

@implementation STCASRPackageNetworkingManager(Private)

-(void)loadPackage {
    NSLog(@"%@",[STCASRURLManager asrLoadPackage:self.package]);
    NSURLSessionDataTask *task = [self taskRequestWithTypeRequest:@"GET"
                                                         withBody:nil
                                                     forURLString:[STCASRURLManager asrLoadPackage:self.package]
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
                                                    
                                                    [self recognize];
                                                }];
    [task resume];
}

-(void)unloadPackage {
    NSLog( @"%@", [STCASRURLManager asrUnloadPackage:self.package]);
    NSURLSessionDataTask *task = [self taskRequestWithTypeRequest:@"GET"
                                                         withBody:nil
                                                     forURLString:[STCASRURLManager asrUnloadPackage:self.package]
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
                                                    
                                                    [super finalizeRequest];
                                                }];
    [task resume];
}

-(void)recognize {
    
}

@end
