//
//  NSURLResponse+Status.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 23.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "NSURLResponse+Status.h"

@implementation NSURLResponse (Status)

-(BOOL)isSuccess{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self;
    return  (httpResponse.statusCode==200 || httpResponse.statusCode==204 );
}

-(BOOL)is404{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self;
    return  (httpResponse.statusCode==404);
}

-(BOOL)is500 {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self;
    return  (httpResponse.statusCode==500);
}

-(NSInteger)responceStatusCode {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)self;
    return  httpResponse.statusCode;
}

@end
