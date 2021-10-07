//
//  STCNetworkingManager+Error.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 23.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager+Error.h"

#import "NSObject+JSON.h"
#import "NSURLResponse+Status.h"

@implementation STCNetworkingManager (Error)

-(NSError *)errorWithData:(NSData *)errorData{
    
    NSError *error ;
    NSDictionary *errorDictionary = [NSJSONSerialization JSONObjectWithData:errorData options:0 error:&error];
    
    NSString *errorString = error ? [[NSString alloc] initWithData:errorData encoding: NSUTF8StringEncoding] : errorDictionary[@"reason"];

    return [NSError errorWithDomain:@"com.speachpro.speechkit"
                               code:400
                           userInfo:@{ NSLocalizedDescriptionKey: errorString }];
}

-(NSError *)checkError:(NSError *)error
          withResponse:(NSURLResponse *)response
         withErrorData:(NSData *)errorData {
    
    if (error) {
        return error;
    } else {
        if(!response.isSuccess) {
            if(errorData) {
                return [self errorWithData:errorData];
            }
        }
    }
    
    return nil;
}

//https://cp.speechpro.com/vkasr/rest/v1/recognize/stream
@end
