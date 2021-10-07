//
//  NSObject+JSON.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 19.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Category provides to serialize the object as JSON
 */
@interface NSObject (JSON)

/**
 * Serializes itself as JSON
 * @return The JSON string
 */
- (NSString*) JSONString;

@end
