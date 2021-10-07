//
//  NSString+Language.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 25.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Detects language based on string
 */
@interface NSString (Language)

/**
 * Detected language
 */
-(NSString *)language;

@end
