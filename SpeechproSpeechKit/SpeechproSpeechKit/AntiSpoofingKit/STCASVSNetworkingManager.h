//
//  STCASVSNetworkingManager.h
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 19.09.2018.
//

#import "STCNetworkingManager.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Provides working with the automatic speaker verification spoofing API requests
 */
@interface STCASVSNetworkingManager : STCNetworkingManager

/**
 * Receives result of automatic speaker verification spoofing
 * @param sound The voice data
 * @param completionHandler The voice completion handler
 */
-(void)inspect:(NSData *)sound
withCompletionHandler:(CompletionHandler)completionHandler;

@end

NS_ASSUME_NONNULL_END

