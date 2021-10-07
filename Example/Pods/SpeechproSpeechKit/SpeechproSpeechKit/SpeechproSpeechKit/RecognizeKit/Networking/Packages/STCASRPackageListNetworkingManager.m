//
//  STCASRPackageListNetworkingManager.m
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 19.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCASRPackageListNetworkingManager.h"
#import "STCASRURLManager.h"

@implementation STCASRPackageListNetworkingManager

-(void)obtainPackagesWithCompletionHandler:(CompletionHandler)completionHandler {
    [self obtainWithCompletionHandler:completionHandler];
}

-(NSString *)request {
    return [STCASRURLManager asrAvailablePackages];
}

@end
