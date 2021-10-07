//
//  STCASVSKitImplementation.m
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 19.09.2018.
//

#import "STCASVSKitImplementation.h"
#import "STCASVSNetworkingManager.h"


 @interface STCASVSKitImplementation()
 
 @property (nonatomic) ASVSCompletionHandler spoofingCompletionHandler;
 
 @end

@implementation STCASVSKitImplementation

-(void)spoof:(NSData *)sound
withCompletionHandler:(ASVSCompletionHandler)completionHandler {
    self.spoofingCompletionHandler = completionHandler;
    STCASVSNetworkingManager *networkingManager = [[STCASVSNetworkingManager alloc] init];
    [networkingManager inspect:sound
         withCompletionHandler:^(NSError *error, NSObject *result) {
             NSDictionary *decision = (NSDictionary *)result;
             self.spoofingCompletionHandler(error, decision[@"decision"]);
         }];
}

@end

/*
 
 -(void)diarize:(NSData *)sound
 withCompletionHandler:(DiarizationCompletionHandler)completionHandler {
 self.diarizationCompletionHandler = completionHandler;
 STCDRZNetworkingManager *networkingManager = [[STCDRZNetworkingManager alloc] init];
 [networkingManager diarize:sound withCompletionHandler:^(NSError *error, NSObject *result) {
 NSDictionary *voice = (NSDictionary *)result;
 self.diarizationCompletionHandler(nil, voice);
 }];
 }


 */
