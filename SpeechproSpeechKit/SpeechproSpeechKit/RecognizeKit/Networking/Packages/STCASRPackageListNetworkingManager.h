//
//  STCASRPackageListNetworkingManager.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 19.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"

/**
 * Provides ASR package list
 */
@interface STCASRPackageListNetworkingManager : STCNetworkingManager

/**
 * Receives list of preset packages
 * @param completionHandler The package completion handler
 */
-(void)obtainPackagesWithCompletionHandler:(CompletionHandler)completionHandler;

@end
