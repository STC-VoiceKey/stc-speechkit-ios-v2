//
//  STCNetworkingManager+Requests.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 18.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "STCNetworkingManager.h"

/**
 * Is requests helper
 */
@interface STCNetworkingManager (Requests)

/**
 Forms GET request
 
 @param urlString The URL for request
 @param body The body of the requests
 @param completionHandler The block which is called when data is received
 @return The request
 */
-(NSURLSessionDataTask *_Nonnull)taskGetRequestForURLString:(NSString *_Nonnull)urlString
                                                   withBody:(NSDictionary *__nullable)body
                                          completionHandler:(void (^_Nonnull)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;
/**
 Forms POST request
 
 @param urlString The URL for request
 @param body The body of the requests
 @param completionHandler The block which is called when data is received
 @return The request
 */
-(NSURLSessionDataTask *_Nullable)taskPostRequestForURLString:(NSString * _Nonnull)urlString
                                                     withBody:(NSDictionary * _Nullable)body
                                            completionHandler:(void (^_Nullable)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;
/**
 Forms DELETE request
 
 @param urlString The URL for request
 @param completionHandler The block which is called when data is received
 @return The request
 */
-(NSURLSessionDataTask *_Nonnull)taskDeleteRequestForURLString:(NSString * _Nonnull)urlString
                                             completionHandler:(void (^_Nullable)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

-(NSURLSessionDataTask *)taskRequestWithTypeRequest:(NSString *)type
                                           withBody:(NSDictionary *)body
                                       forURLString:(NSString *)urlString
                                  completionHandler:(void (^)(NSData * _Nullable, NSURLResponse * _Nullable, NSError * _Nullable))completionHandler;
@end
