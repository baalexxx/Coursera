//
//  ViewController.m
//  PeerReview04
//
//  Created by Oleksii Baiev on 18/01/16.
//  Copyright © 2016 baevsoft. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"


@interface ViewController ()

@property (nonatomic) DGDistanceRequest* req;

@property (weak, nonatomic) IBOutlet UITextField *startLocation;

@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UILabel *distanceA;


@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;

@property (weak, nonatomic) IBOutlet UITextField *endLocationC;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;

@property (weak, nonatomic) IBOutlet UITextField *endLocationD;
@property (weak, nonatomic) IBOutlet UILabel *distanceD;

@property (weak, nonatomic) IBOutlet UIButton *calculateButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitsController;

- (void) setResponce:(id)responce toLabel: (UILabel*) textField;

@end

@implementation ViewController

- (void) setResponce:(id)responce toLabel: (UILabel*) label {
    
    NSNull* badResult = [NSNull null];
    
    if (responce != badResult) {
        
        float num;
        
        if (self.unitsController. selectedSegmentIndex == 0) {
            
            num = [responce floatValue];
            NSString* x = [NSString stringWithFormat:@"%.2f m", num];
            label.text = x;
        }
        else if (self.unitsController. selectedSegmentIndex == 1) {
            
            num = [responce floatValue]/1000.;
            NSString* x = [NSString stringWithFormat:@"%.2f km", num];
            label.text = x;
        }
        else if (self.unitsController. selectedSegmentIndex == 2) {
            
            num = [responce floatValue]/525.;
            NSString* x = [NSString stringWithFormat:@"%.2f miles", num];
            label.text = x;
        }
    }
    else {
        label.text = @"Error";
    }
}


- (IBAction)calculateButtonTapped:(id)sender {
    
    self.calculateButton.enabled = NO;
    
    self.req = [DGDistanceRequest alloc];
    
    NSString* start = self.startLocation.text;
    NSString* destA = self.endLocationA.text;
    NSString* destB = self.endLocationB.text;
    NSString* destC = self.endLocationC.text;
    NSString* destD = self.endLocationD.text;
    
    NSArray* dests = @[destA, destB, destC, destD];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController* weakSelf = self;
    
    
    self.req.callback = ^(NSArray* responces) {
        
        ViewController* strongSelf = weakSelf;
        
        if (!strongSelf)
            return;
        
        [strongSelf setResponce:responces[0] toLabel:strongSelf.distanceA];
        [strongSelf setResponce:responces[1] toLabel:strongSelf.distanceB];
        [strongSelf setResponce:responces[2] toLabel:strongSelf.distanceC];
        [strongSelf setResponce:responces[3] toLabel:strongSelf.distanceD];
        
        strongSelf.calculateButton.enabled = YES;
        strongSelf.req = nil;
    };
    
    
    [self.req start];
    
}



@end
