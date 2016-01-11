//
//  ViewController.m
//  PeerReview03
//
//  Created by Alex Baev on 10/01/16.
//  Copyright © 2016 baevsoft. All rights reserved.
//

#import "ViewController.h"

#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"



@interface ViewController () <CRCurrencyRequestDelegate>


@property (nonatomic) CRCurrencyRequest* req;

@property (weak, nonatomic) IBOutlet UITextField *unputField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencySegment;

@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)currencyRequest:(CRCurrencyRequest *)req
    retrievedCurrencies:(CRCurrencyResults *)currencies {
    
    if (self.currencySegment.selectedSegmentIndex == 0) {
        
       float eur = [self.unputField.text floatValue] * currencies.EUR;
        
        NSString* temp = [NSString stringWithFormat:@"%2.f", eur];
        
        
        self.currencyLabel.text = temp;
    }
    else if (self.currencySegment.selectedSegmentIndex == 1) {
        
        float yen = [self.unputField.text floatValue] * currencies.JPY;
        
        NSString* temp = [NSString stringWithFormat:@"%2.f", yen];
        
        
        self.currencyLabel.text = temp;
    }
    else if (self.currencySegment.selectedSegmentIndex == 2) {
        
        float gbp = [self.unputField.text floatValue] * currencies.GBP;
        
        NSString* temp = [NSString stringWithFormat:@"%2.f", gbp];
        
        
        self.currencyLabel.text = temp;
    }
    
    self.convertButton.enabled = YES;
    
    
}

- (IBAction)buttonTapped:(id)sender {
    
    self.convertButton.enabled = NO;
    
    self.req = [[CRCurrencyRequest alloc] init];
    self.req.delegate = self;
    
    [self.req start];
    
    
    
    
}

@end
