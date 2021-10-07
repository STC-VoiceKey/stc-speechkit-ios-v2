![itunesartwork 2x](https://user-images.githubusercontent.com/20855360/42330705-644607a8-807c-11e8-8de8-5dede6f49ed6.png)

STCSpeechKitDemo demonstrates a functionality of STCSpeechKit framework. 

## How To Get Started
STCSpeechKitDemo supports multiple methods for installing the library in a project.
[Download STCSpeechKit](https://github.com/STC-VoiceKey/stc-speechkit-ios/archive/master.zip) and add SpeechproSpeechKit  source code folder to project

### Installation with CocoaPods
To integrate STCSpeechKit into your Xcode project using CocoaPods, specify it in your Podfile:

pod 'SpeechproSpeechKit', :git => 'https://github.com/STC-VoiceKey/stc-speechkit-ios-v2.git'


##Before you get started
Review the [Documentation](https://stc-voicekey.github.io/stc-speechkit-ios/html/index.html) for the library API.
Register on the [website](https://cp.speechpro.com/) and get credentials

## Communication
- If you'd like to **ask a general question**, email to voicekey@speechpro.com.
- If you **found a bug**, _and can provide steps to reliably reproduce it_, open an issue.
- If you **have a feature request**, open an issue.

## How to use STC SpeechKit

### Initialization STCSpeechKit
```objective-c
STCSpeechKit  *speechKit = [STCSpeechKit sharedInstance];
AuthDataModel *dataModel = [[AuthDataModel alloc] initWithUsername:self.usernameTextField.text
                                                          withPassword:self.passwordTextField.text
                                                          withDomainid:self.domainidTextField.text];
[speechKit setAuthorizationData: dataModel];
```

### Web Socket Recognizer
```objective-c
id<STCStreamRecognizing> streamRecognizer = STCSpeechKit.sharedInstance.streamRecognizer;
        
[streamRecognizer startWithCompletionHandler:^(NSError *error, NSString *result) {
           //handle result;
        }];
```

### Recognizer
```objective-c
id<STCRecognizing> recognizer = STCSpeechKit.sharedInstance.recognizer;;

[recognizer startWithCompletionHandler:^(NSError *error, NSString *result) {
            //handle result;
}];
```

### Web Socket Synthesizer

```objective-c
id<STCStreamSynthesizing> streamSynthesizer = STCSpeechKit.sharedInstance.streamSynthesizer;
[streamSynthesizer playText:text withVoice:@"Carol"
                       withCompletionHandler:^(NSError *error) {
                           //handle result
                       }];
```

### Synthesizer
```objective-c
id<STCSynthesizing> synthesizer   = STCSpeechKit.sharedInstance.synthesizer;

[synthesizer playText:text withVoice:self.voice withCompletionHandler:^(NSError *error) {
			//handle result
                         } ];
[synthesizer cancel];
```

### Diarization
```objective-c
id<STCDiarizating> diarizator = STCSpeechKit.sharedInstance.diarizator;

[diarizator startWithCompletionHandler:^(NSError *error, NSDictionary *result) {
	//handle result
        }];
```

## License

Copyright (c) 2016 STC. Licensed under the FreeBSD <a href="https://onepass.tech/license-agreement.html">License</a>.
