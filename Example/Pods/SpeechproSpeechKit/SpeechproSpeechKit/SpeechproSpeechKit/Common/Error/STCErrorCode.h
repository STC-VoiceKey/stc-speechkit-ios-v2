//
//  STCErrorCode.h
//  SynthesizeSpeechKit
//
//  Created by Soloshcheva Aleksandra on 26.04.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#ifndef STCErrorCode_h
#define STCErrorCode_h

/**
 *
 */
typedef NS_ENUM(NSInteger, STCErrorCode) {
    
    /**
     *
     */
    STCErrorUnknownLanguage = 1,
    
    /**
     *
     */
    STCErrorNoVoiceForLanguage = 2,
    
    /**
     *
     */
    STCErrorUnsupportedLanguage = 3,
    
    /**
     *
     */
    STCErrorTextCantBeSynthesized = 4,

    /**
     *
     */
    STCErrorAudioIsNotCorrect = 5,
    
    /**
     *
     */
    STCErrorCredentialsIsNotDefine = 6,
    
    /**
     *
     */
    STCErrorInvalidUUIDString = 7,
    
    /**
     *
     */
    STCErrorTextIsNotDefine = 8,
    
    /**
     *
     */
    STCErrorTextNotFound = 9,
    
    /**
     *
     */
    STCErrorTextIsTooLong = 10,
    
    /**
     *
     */
    STCErrorTextIsNotSynthesized = 11,
    
    /**
     *
     */
    STCErrorLanguageIsNotCorrect = 12,
    
    /**
     *
     */
    STCErrorVoiceTypeNotDefine = 13,
    
    /**
     *
     */
    STCErrorVoiceNameNotDefine = 14,
    
    /**
     *
     */
    STCErrorVoiceNameIsNotCorrect = 15,
    
    /**
     *
     */
    STCErrorVoiceNotFound = 16,
    
    /**
     *
     */
    STCErrorTransactionIsNotCorrect = 17,
    
    /**
     *
     */
    STCErrorTextValueIsNotDefine = 18

};


/**
 *
 */
FOUNDATION_EXPORT NSString *const STCSpeechKitErrorDomain;

#endif /* STCErrorCode_h */
