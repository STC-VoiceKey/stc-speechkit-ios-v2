//
//  STCSessionURLManager.h
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 18.09.2018.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Provides the transport service urls for Session API.
 API help
 @see https://cp.speechpro.com/vksession/help
 */

@interface STCSessionURLManager : NSObject

/**
 The main Session API url
 @code
 https://cp.speechpro.com/vksession/rest
 @endcode
 */
+(NSString *)sessionApiUrl ;

/**
 The Session API url for the starting server session.
 @code
 https://cp.speechpro.com/vksession/rest/session
 @endcode
 */
+(NSString *)startSession;

/**
 The Session API url for the closing server session.
 @code
 https://cp.speechpro.com/vksession/rest/session
 @endcode
 */
+(NSString *)closeSession;

@end

NS_ASSUME_NONNULL_END
