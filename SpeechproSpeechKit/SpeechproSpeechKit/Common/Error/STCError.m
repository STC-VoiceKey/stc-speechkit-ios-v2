//
//  STCError.m
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 26.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "STCError.h"

NSString *const STCSpeechKitErrorDomain = @"STCSpeechKitErrorDomain";

@implementation STCError

+(NSError *)unknownLanguageError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorUnknownLanguage
                           userInfo:nil];
}

+(NSError *)noVoiceForLanguageError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorNoVoiceForLanguage
                           userInfo:nil];
}

+(NSError *)unsupportedLanguageError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorUnsupportedLanguage
                           userInfo:nil];
}

+(NSError *)errorWithReason:(NSString *)reason {
    if ( [reason isEqualToString:@"TEXT_IS_NOT_SYNTHESIZED"] ) {
        return STCError.textCantBeSynthesizedError;
    }
    
    if ( [reason isEqualToString:@"AUDIO_IS_NOT_CORRECT"] ) {
        return STCError.audioIsNotCorrectError;
    }
    
    if ( [reason isEqualToString:@"CREDENTIALS_IS_NOT_DEFINE"] ) {
        return STCError.credentialsIsNotDefineError;
    }
    
    if ( [reason isEqualToString:@"INVALID_UUID_STRING"] ) {
        return STCError.invalidUUIDStringError;
    }
    
    if ( [reason isEqualToString:@"TEXT_IS_NOT_DEFINE"] ) {
        return STCError.textIsNotDefineError;
    }
    
    if ( [reason isEqualToString:@"TEXT_VALUE_IS_NOT_DEFINE"] ) {
        return STCError.textValueIsNotDefineError;
    }
    
    if ( [reason isEqualToString:@"TEXT_NOT_FOUND"] ) {
        return STCError.textNotFoundError;
    }
    
    if ( [reason isEqualToString:@"TEXT_IS_TOO_LONG"] ) {
        return STCError.textIsTooLongError;
    }
    
    if ( [reason isEqualToString:@"TEXT_IS_NOT_SYNTHESIZED"] ) {
        return STCError.textIsNotSynthesizedError;
    }
    
    if ( [reason isEqualToString:@"LANGUAGE_IS_NOT_CORRECT"] ) {
        return STCError.languageIsNotCorrectError;
    }
    
    if ( [reason isEqualToString:@"VOICE_TYPE_NOT_DEFINE"] ) {
        return STCError.voiceTypeNotDefineError;
    }
    
    if ( [reason isEqualToString:@"VOICE_NAME_NOT_DEFINE"] ) {
        return STCError.voiceNameNotDefineError;
    }
    
    if ( [reason isEqualToString:@"VOICE_NAME_IS_NOT_CORRECT"] ) {
        return STCError.voiceNameIsNotCorrectError;
    }
    
    if ( [reason isEqualToString:@"VOICE_NOT_FOUND"] ) {
        return STCError.voiceNotFoundError;
    }
    
    if ( [reason isEqualToString:@"TRANSACTION_IS_NOT_CORRECT"] ) {
        return STCError.transactionIsNotCorrectError;
    }
    
    return nil;
}

+(NSError *)textCantBeSynthesizedError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorTextCantBeSynthesized
                           userInfo:nil];
}

+(NSError *)audioIsNotCorrectError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorAudioIsNotCorrect
                           userInfo:nil];
}

+(NSError *)credentialsIsNotDefineError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorCredentialsIsNotDefine
                           userInfo:nil];
}

+(NSError *)invalidUUIDStringError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorInvalidUUIDString
                           userInfo:nil];
}

+(NSError *)textIsNotDefineError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorTextIsNotDefine
                           userInfo:nil];
}

+(NSError *)textValueIsNotDefineError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorTextValueIsNotDefine
                           userInfo:nil];
}

+(NSError *)textNotFoundError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorTextNotFound
                           userInfo:nil];
}

+(NSError *)textIsTooLongError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorTextIsTooLong
                           userInfo:nil];
}

+(NSError *)textIsNotSynthesizedError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorTextIsNotSynthesized
                           userInfo:nil];
}

+(NSError *)languageIsNotCorrectError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorLanguageIsNotCorrect
                           userInfo:nil];
}

+(NSError *)voiceTypeNotDefineError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorVoiceTypeNotDefine
                           userInfo:nil];
}

+(NSError *)voiceNameNotDefineError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorVoiceNameNotDefine
                           userInfo:nil];
}
+(NSError *)voiceNameIsNotCorrectError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorVoiceNameIsNotCorrect
                           userInfo:nil];
}

+(NSError *)voiceNotFoundError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorVoiceNotFound
                           userInfo:nil];
}

+(NSError *)transactionIsNotCorrectError {
    return [NSError errorWithDomain:STCSpeechKitErrorDomain
                               code:STCErrorTransactionIsNotCorrect
                           userInfo:nil];
}

@end
