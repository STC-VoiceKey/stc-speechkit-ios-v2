//
//  STCASRPackageNetworkingManager.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 28.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCNetworkingManager.h"

/**
 * Provides working with the recognize API requests with load/unload package
 */
@interface STCASRPackageNetworkingManager : STCNetworkingManager

/**
 * Returns current package
 */
-(NSString *)package;

@end
