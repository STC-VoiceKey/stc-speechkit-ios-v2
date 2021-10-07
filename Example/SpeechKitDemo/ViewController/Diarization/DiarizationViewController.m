//
//  DiarizationViewController.m
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 16.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "DiarizationViewController.h"
#import <STCSpeechKit.h>

@interface DiarizationViewController ()

@property (nonatomic) id<STCDiarizating> diarizator;

@property (nonatomic,weak) IBOutlet UITextView *textView;

@end

@interface DiarizationViewController (Private)

-(void)showResult:(NSString *)result;

@end

@implementation DiarizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.diarizator = STCSpeechKit.sharedInstance.diarizator;
    self.textView.text = @"";
}

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
