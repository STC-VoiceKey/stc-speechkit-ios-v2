//
//  STCASVSURLManager.h
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 18.09.2018.
//

#import <Foundation/Foundation.h>

#import "STCSessionURLManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface STCASVSURLManager : STCSessionURLManager

/**
 Provides the transport service urls for automatic speaker verification spoofing API.
 API help
 @see https://cp.speechpro.com/vkantispoofing/help
 */

/**
 The main automatic speaker verification spoofing API url
 @code
 https://cp.speechpro.com/vkantispoofing/rest
 @endcode
 */
+(NSString *)spoofingApiUrl ;

/**
 The API url for automatic speaker verification spoofing.
 @code
 https://cp.speechpro.com/vkantispoofing/rest/inspect
 @endcode
 */
+(NSString *)inspect;

@end

NS_ASSUME_NONNULL_END
