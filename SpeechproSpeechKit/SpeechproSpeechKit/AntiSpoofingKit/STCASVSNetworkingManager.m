//
//  STCASVSNetworkingManager.m
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 19.09.2018.
//

#import "STCASVSNetworkingManager.h"
#import "STCASVSURLManager.h"

@interface STCASVSNetworkingManager()

@property (nonatomic) NSData *voiceData;

@end

@implementation STCASVSNetworkingManager

-(NSString *)sessionRequest {
    return STCASVSURLManager.startSession;
}

-(NSString *)method {
    return @"POST";
}

-(NSDictionary *)body {
    return @{ @"data":[self.voiceData base64EncodedStringWithOptions:0] };
}

-(NSString *)request {
    return STCASVSURLManager.inspect;
}

-(void)inspect:(NSData *)sound withCompletionHandler:(CompletionHandler)completionHandler {
    self.voiceData = [NSData dataWithData:sound];
    [self obtainWithCompletionHandler:completionHandler];
}

@end
