//
//  RecognizeViewController.m
//  SpeechKitDemo
//
//  Created by Soloshcheva Aleksandra on 28.05.2018.
//  Copyright © 2018 Speech Tehnology Center. All rights reserved.
//

#import "RecognizeViewController.h"
#import <STCSpeechKit.h>

@interface RecognizeViewController ()< UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,weak) IBOutlet UISwitch *isSocketsSwitcher;
@property (nonatomic,weak) IBOutlet UITextView *textView;
@property (nonatomic,weak) IBOutlet UITableView *tableView;

@property (nonatomic,weak) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

@property (nonatomic) id<STCRecognizing> recognizer;
@property (nonatomic) id<STCStreamRecognizing> streamRecognizer;
@property (nonatomic) NSArray<NSDictionary*>* packagesDataSource;

@end

@interface RecognizeViewController (Private)

-(void)continueAsOnline;
-(void)continueAsSocket;

-(BOOL)isPackageSelected;
-(NSDictionary *)selectedPackage;

-(void)showResult:(NSString *)result;

-(void)startRecognizing;
-(void)startStreamRecognizing;

-(void)handleResult:(NSString *)result withError:(NSError *)error;

@end

@implementation RecognizeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.recognizer = STCSpeechKit.sharedInstance.recognizer;
    self.streamRecognizer = STCSpeechKit.sharedInstance.streamRecognizer;
    
    id<STCRecognizeKit> recognizeKit = STCSpeechKit.sharedInstance.recognizeKit;
    [recognizeKit obtainPackagesWithCompletionHandler:^(NSError *error, NSArray<NSDictionary *> *result) {
        self.packagesDataSource = [NSArray arrayWithArray:result];
       //  NSLog(self.packagesDataSource);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

-(IBAction)onPlay:(UIButton *)sender {
    
    self.textViewHeightConstraint.constant = 200;
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    if (self.isSocketsSwitcher.isOn) {
        [self continueAsSocket];
    } else {
        [self continueAsOnline];
    }
}

#pragma mark - UITableViewDataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *kPackageTableCellIdentifier = @"kPackageTableCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kPackageTableCellIdentifier];
    
    if (cell) {
        cell.textLabel.text = self.packagesDataSource[indexPath.row][@"package_id"];
        cell.detailTextLabel.text = self.packagesDataSource[indexPath.row][@"name"];
        NSLog(@"%@",self.packagesDataSource[indexPath.row]);
    } else {
        return [[UITableViewCell alloc] init];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.packagesDataSource.count;
}

@end

@implementation RecognizeViewController (Private)

-(void)continueAsOnline {
    if (self.isStopMode) {
        [self showActivityIndicator];
        [self.recognizer stop];
    } else {
        [self startRecognizing];
        [self configureButtonAsStop];
    }
}

-(void)continueAsSocket {
    if (self.isStopMode) {
        [self.streamRecognizer stopWithCompletionHandler:^(NSError *error, NSString *result) {
            [self showResult:result];
            [self configureButtonAsPlay];
        }];
    } else {
        [self startStreamRecognizing];
        [self configureButtonAsStop];
    }
}

-(void)showResult:(NSString *)result {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = result;
    });
}

-(BOOL)isPackageSelected {
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.tableView.indexPathForSelectedRow];
    return cell ? YES : NO;
}

-(NSDictionary *)selectedPackage {
    return  [self.packagesDataSource objectAtIndex:self.tableView.indexPathForSelectedRow.row];
}

-(void)startRecognizing {
    if (self.isPackageSelected) {
        [self.recognizer startWithPackage:self.selectedPackage withCompletionHandler:^(NSError *error, NSString *result) {
            [self handleResult:result withError:error];
        }];
    } else {
        [self.recognizer startWithCompletionHandler:^(NSError *error, NSString *result) {
            [self handleResult:result withError:error];
        }];
    }
}

-(void)startStreamRecognizing {
    if (self.isPackageSelected) {
        [self.streamRecognizer startWithPackage:self.selectedPackage
                          withCompletionHandler:^(NSError *error, NSString *result) {
                              [self handleResult:result withError:error];
                          }];
    } else {
        [self.streamRecognizer startWithCompletionHandler:^(NSError *error, NSString *result) {
           [self handleResult:result withError:error];
        }];
    }
}

-(void)handleResult:(NSString *)result withError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.isSocketsSwitcher.isOn) {
            [self hideActivityIndicator];
            [self configureButtonAsPlay];
        }
        
        if (error) {
            [self showError:error];
            [self configureButtonAsPlay];
        } else {
            [self showResult:result];
        }
    });
}

@end
