//
//  AntiSpoofingViewController.m
//  STCSpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 18.09.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "AntiSpoofingViewController.h"

#import <STCSpeechKit.h>

@interface AntiSpoofingViewController ()

@property (nonatomic) id<STCASVSpoofing> spoofer;

@property (nonatomic,weak) IBOutlet UITextView *textView;

@end

@interface AntiSpoofingViewController (Private)

-(void)showResult:(NSString *)result;

@end

@implementation AntiSpoofingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.spoofer = STCSpeechKit.sharedInstance.spoofer;
}

-(IBAction)onPlay:(id)sender {
    if (self.isStopMode) {
        [self.spoofer stop];
        [self showActivityIndicator];
    } else {
        self.textView.text = @"";
        [self configureButtonAsStop];
        
        [self.spoofer startWithCompletionHandler:^(NSError *error, NSString *result) {
            NSString *resultString = error ? error.localizedDescription : [NSString stringWithFormat:@"%@",result];
            [self showResult:resultString];
            [self configureButtonAsPlay];
            [self hideActivityIndicator];
        }];
    }
}

@end

@implementation AntiSpoofingViewController (Private)

-(void)showResult:(NSString *)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = result;
    });
}

@end

/*

 
 @interface DiarizationViewController (Private)
 
 -(void)showResult:(NSString *)result;
 
 @end
 
 @implementation DiarizationViewController

 
 -(IBAction)onPlay:(id)sender {
 if (self.isStopMode) {
 [self.diarizator stop];
 [self showActivityIndicator];
 } else {
 [self configureButtonAsStop];
 self.textView.text = @"";
 
 [self.diarizator startWithCompletionHandler:^(NSError *error, NSDictionary *result) {
 [self showResult:[NSString stringWithFormat:@"%@",result]];
 [self configureButtonAsPlay];
 [self hideActivityIndicator];
 }];
 }
 }
 
 @end
 
 @implementation DiarizationViewController (Private)
 
 -(void)showResult:(NSString *)result {
 dispatch_async(dispatch_get_main_queue(), ^{
 self.textView.text = result;
 });
 }
 
 @end
 */
