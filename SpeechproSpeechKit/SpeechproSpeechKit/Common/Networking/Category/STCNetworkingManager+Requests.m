//
//  STCNetworkingManager+Requests.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 18.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager+Requests.h"
#import "NSObject+JSON.h"

@implementation STCNetworkingManager (Requests)

-(NSURLSessionDataTask *)taskGetRequestForURLString:(NSString *)urlString
                                           withBody:(NSDictionary *)body
                                  completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler {
    
    return [self taskRequestWithTypeRequest:@"GET"
                                   withBody:body
                               forURLString:urlString
                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                              if (completionHandler) {
                                  completionHandler( data, response, error);
                              }
                          }];
    
}

-(NSURLSessionDataTask *)taskPostRequestForURLString:(NSString *)urlString
                                            withBody:(NSDictionary *)body
                                   completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler {
    
    return [self taskRequestWithTypeRequest:@"POST"
                                   withBody:body
                               forURLString:urlString
                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                              if (completionHandler) {
                                  completionHandler( data, response, error);
                              }
                          }];
    
}

-(NSURLSessionDataTask *)taskDeleteRequestForURLString:(NSString *)urlString
                                     completionHandler:(void (^)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler {
    return [self taskRequestWithTypeRequest:@"DELETE"
                                   withBody:nil
                               forURLString:urlString
                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                              if (completionHandler) {
                                  completionHandler( data, response, error);
                              }
                          }];
}


-(NSURLSessionDataTask *)taskRequestWithTypeRequest:(NSString *)type
                                           withBody:(NSDictionary *)body
                                       forURLString:(NSString *)urlString
                                  completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler {
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:urlString]
                                    cachePolicy: NSURLRequestReloadIgnoringCacheData
                                    timeoutInterval: 20];
    
    [request setHTTPMethod:type];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if(body) {
        NSString *bodyJSON = [body JSONString];
        [request setHTTPBody:[bodyJSON dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (self.sessionId) {
        [request addValue:self.sessionId forHTTPHeaderField:@"X-Session-Id"];
    }
    
    if (self.transactionId) {
        [request addValue:self.transactionId forHTTPHeaderField:@"X-Transaction-Id"];
    }
    
    return [NSURLSession.sharedSession dataTaskWithRequest:request
                                         completionHandler:^(NSData * _Nullable data,
                                                             NSURLResponse * _Nullable response,
                                                             NSError * _Nullable error) {
                                             if (completionHandler) {
                                                 completionHandler( data, response, error);
                                             }
                                         }];
}

@end
