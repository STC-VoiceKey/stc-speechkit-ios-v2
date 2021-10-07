//
//  LoginViewController.m
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 22.06.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "LoginViewController.h"
#import <STCSpeechKit.h>
#import "AuthDataModel.h"

@interface LoginViewController ()

@property (nonatomic) IBOutlet UITextField *usernameTextField;
@property (nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic) IBOutlet UITextField *domainidTextField;

@end

@implementation LoginViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    STCSpeechKit  *speechKit = [STCSpeechKit sharedInstance];
    AuthDataModel *dataModel = [[AuthDataModel alloc] initWithUsername:self.usernameTextField.text
                                                          withPassword:self.passwordTextField.text
                                                          withDomainid:self.domainidTextField.text];
    [speechKit setAuthorizationData: dataModel];
}

@end
