//
//  VoiceModel.h
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 24.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceModel : NSObject

-(id)initWithDictionary:(NSDictionary *)dictionary;

@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) BOOL isMale;

@end
