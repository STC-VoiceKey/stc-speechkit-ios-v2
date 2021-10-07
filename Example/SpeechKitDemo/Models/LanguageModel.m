//
//  LanguageModel.m
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 24.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "LanguageModel.h"

@implementation LanguageModel

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _name = dictionary[@"name"];
    }
    return self;
}

@end
