//
//  STCStreamSynthesizing.h
//  SpeechKit
//
//  Created by Soloshcheva Aleksandra on 08.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCSynthesizing.h"

/**
 * The stream synthesizing protocol
 */
@protocol STCStreamSynthesizing <STCSynthesizing>

/**
 * Adds text to playing
 */
- (void)addTextToPlay:(NSString *)text;

@end
