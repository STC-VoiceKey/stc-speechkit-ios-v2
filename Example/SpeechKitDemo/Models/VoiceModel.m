//
//  VoiceModel.m
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 24.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "VoiceModel.h"

@implementation VoiceModel

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
        
        NSString *genderString = dictionary[@"gender"];
        _isMale = [genderString isEqualToString:@"MALE"];
    }
    return self;
}

@end
