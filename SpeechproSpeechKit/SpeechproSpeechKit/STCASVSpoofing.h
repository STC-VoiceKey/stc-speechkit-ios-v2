//
//  STCASVSpoofing.h
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 18.09.2018.
//

#import <Foundation/Foundation.h>
#import "STCASVSKit.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * The automatic speaker verification spoofing protocol
 */

@protocol STCASVSpoofing <NSObject>

/**
 * Starts recording and automatic speaker verification spoofing
 * @param handler The automatic speaker verification spoofing completion handler
 */
-(void)startWithCompletionHandler:(ASVSCompletionHandler)handler;

/**
 * Stops automatic speaker verification spoofing
 */
-(void)stop;

@end

NS_ASSUME_NONNULL_END
