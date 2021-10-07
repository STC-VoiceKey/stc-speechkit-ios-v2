//
//  BaseViewController.h
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 13.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

-(void)showActivityIndicator;
-(void)hideActivityIndicator;

-(void)configureButtonAsPlay;
-(void)configureButtonAsStop;

-(BOOL)isPlayMode;
-(BOOL)isStopMode;

-(void)showError:(NSError *)error;

-(void)applicationDidEnterBackground;

@end
