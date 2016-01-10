//
//  ViewController.m
//  UnitConverter
//
//  Created by Alex Baev on 04/01/16.
//  Copyright © 2016 baevsoft. All rights reserved.
//

#import "ViewController.h"

double convertUnitOneToUnitTwo (double unitOneValue) {
    
    double unitTwoValue;
    unitTwoValue = 1000*unitOneValue;
    return unitTwoValue;
}

double convertUnitOneToUnitThree (double unitOneValue) {
    
    double unitTwoValue;
    unitTwoValue = 1000*100*unitOneValue;
    return unitTwoValue;
}

double convertUnitOneToUnitFour (double unitOneValue) {
    
    double unitTwoValue;
    unitTwoValue = 1000*1000*unitOneValue;
    return unitTwoValue;
}

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (weak, nonatomic) IBOutlet UILabel *outputField;

@end

@implementation ViewController

- (IBAction)updateButton:(id)sender {
    
    NSMutableString* buf = [NSMutableString new];
    double userInput = [self.inputField.text doubleValue];
    
    if (self.segmentController.selectedSegmentIndex == 0) {
        double unitTwoValue = convertUnitOneToUnitTwo(userInput);
        [buf appendString: [@(unitTwoValue) stringValue]];
    }
    else if (self.segmentController.selectedSegmentIndex == 1) {
        double unitThreeValue = convertUnitOneToUnitThree(userInput);
        [buf appendString: [@(unitThreeValue) stringValue]];
    }
    else  if (self.segmentController.selectedSegmentIndex == 2) {
        double unitFourValue = convertUnitOneToUnitFour(userInput);
        [buf appendString: [@(unitFourValue) stringValue]];
    }
    
    self.outputField.text = buf;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
