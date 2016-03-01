//
//  ViewController.m
//  TwitterShare
//
//  Created by Alex Baev on 16/02/16.
//  Copyright © 2016 baevsoft. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

- (void) configureTweetTextView;
- (void) showAlertMessage: (NSString*) myMessage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configureTweetTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) showAlertMessage: (NSString*) myMessage {
    
    UIAlertController* actionColntroller = [UIAlertController
                                            alertControllerWithTitle:@"SocialShare"
                                            message:myMessage
                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [actionColntroller addAction: [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil]];
    
    [self presentViewController:actionColntroller animated:YES completion:nil];
}

- (IBAction)showShareAction:(id)sender {
    
    //hide keybord if it is being shoew
    if ([self.tweetTextView isFirstResponder]) {
        [self.tweetTextView resignFirstResponder];
    }
    
    UIAlertController* actionColntroller = [UIAlertController
                                            alertControllerWithTitle:@"Share" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
    
    UIAlertAction* tweetAction = [UIAlertAction actionWithTitle:@"Tweet"
                                                           style:UIAlertActionStyleDefault
                                                        handler: ^(UIAlertAction* alertAction) {
                                                            
                                                            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                                                                
                                                                
                                                                SLComposeViewController* twitterVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                                                                
                                                                
                                                                //Tweet out the tweet
                                                                if (self.tweetTextView.text.length < 140) {
                                                                    [twitterVC setInitialText:self.tweetTextView.text];
                                                                }
                                                                else {
                                                                    NSString* shortText = [self.tweetTextView.text substringToIndex:140];
                                                                    [twitterVC setInitialText: shortText];
                                                                }
                                                                
                                                                [self presentViewController: twitterVC animated:YES completion:nil];
                                                                
                                                            }
                                                            else {
                                                                
                                                                //raise some kind of objection
                                                                [self showAlertMessage:@"You are not signed in to Twitter"];
                                                            }
                                                            
                                                        }];
    
    
    UIAlertAction* facebookAction = [UIAlertAction actionWithTitle:@"Post to Facebook"
                                                          style:UIAlertActionStyleDefault
                                                        handler: ^(UIAlertAction* alertAction) {
                                                            
                                                            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                                                                
                                                                //[self showAlertMessage:@"Facebook is available"];
                                                                
                                                                SLComposeViewController* facebookVC = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                                                                
                                                                //Post message into facebook
                                                                [facebookVC setInitialText:self.tweetTextView.text];
                                                                [self presentViewController: facebookVC animated:YES completion:nil];
                                                                
                                                            }
                                                            else {
                                                                
                                                                //raise some kind of objection
                                                                [self showAlertMessage:@"You are not signed in to Facebook"];
                                                            }
                                                            
                                                        }];
    
    UIAlertAction* moreAction = [UIAlertAction actionWithTitle:@"More"
                                                             style:UIAlertActionStyleDefault
                                                           handler: ^(UIAlertAction* alertAction) {
                                                               
                                                               
                                                               UIActivityViewController* moreVC = [[UIActivityViewController alloc]
                                                                                                   initWithActivityItems:@[] applicationActivities:nil];
                                                               
                                                               
                                                           }];
    
    [actionColntroller addAction: tweetAction];
    [actionColntroller addAction: facebookAction];
    [actionColntroller addAction: moreAction];
    [actionColntroller addAction: cancelAction];
    
    
    [self presentViewController:actionColntroller animated:YES completion:nil];
    
}

- (void) configureTweetTextView {
    
    self.tweetTextView.layer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
    self.tweetTextView.layer.cornerRadius = 10.0;
    self.tweetTextView.layer.borderColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    self.tweetTextView.layer.borderWidth = 2.0;
}


@end
