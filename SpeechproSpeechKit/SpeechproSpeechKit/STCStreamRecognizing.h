//
//  STCStreamRecognizing.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 04.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCRecognizing.h"

/**
 * The stream recognizing protocol
 */
@protocol STCStreamRecognizing <STCRecognizing>

/**
 * Stops the recognition
 * @param completionHandler The recognition completion handler
 */
-(void)stopWithCompletionHandler:(RecognizingCompletionHandler)completionHandler;

@end
