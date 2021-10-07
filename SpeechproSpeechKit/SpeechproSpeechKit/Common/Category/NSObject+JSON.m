//
//  NSObject+JSON.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 19.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

- (NSString *)JSONString{
    NSError *error = nil;
    NSData  *data = [NSJSONSerialization dataWithJSONObject:self options:NO error:&error];
    return [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];;
}

@end
