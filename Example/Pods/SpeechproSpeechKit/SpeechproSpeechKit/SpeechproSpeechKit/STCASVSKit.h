//
//  STCASVSKit.h
//  Pods-STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 18.09.2018.
//

#import <Foundation/Foundation.h>

/**
 * The kit of methods used for automatic speaker verification spoofing
 */

/**
 * Is the block which is called when automatic speaker verification spoofing data is received
 
 * @param error  Data receiving error.
 * @param result Responce data.\nIf data received successfully, 'error' is nil
 */
typedef void (^ASVSCompletionHandler) (NSError *error, NSString *result);

@protocol STCASVSKit <NSObject>

/**
 * Receives the automatic speaker verification spoofing result
 * @param completionHandler The response block called when the result is received
 */
-(void)spoof:(NSData *)sound
withCompletionHandler:(ASVSCompletionHandler)completionHandler;

@end

