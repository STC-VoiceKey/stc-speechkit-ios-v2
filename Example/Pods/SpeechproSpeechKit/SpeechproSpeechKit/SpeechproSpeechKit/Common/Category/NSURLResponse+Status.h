//
//  NSURLResponse+Status.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 23.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLResponse (Status)

/**
 * Checks statusCode is 200 or 204
 * @return YES, if the condition is satisfied
 */
-(BOOL)isSuccess;

/**
 * Checks statusCode is 404
 * @return YES, if the condition is satisfied
 */
-(BOOL)is404;

/**
 * Checks statusCode is 500
 * @return YES, if the condition is satisfied
 */
-(BOOL)is500;

/**
 * Returns statusCode 
 */
-(NSInteger)responceStatusCode;

@end
