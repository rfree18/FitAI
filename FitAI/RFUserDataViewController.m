//
//  RFUserDataViewController.m
//  FitAI
//
//  Created by Ross Freeman on 3/29/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFUserDataViewController.h"

@interface RFUserDataViewController ()

@end

@implementation RFUserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RFWorkoutViewController *dest = [segue destinationViewController];
    
    dest.workout = self.workout;
}

- (IBAction)submitData:(id)sender {
    NSInteger weight = [self.weightTextField.text integerValue];
    
    if(weight > 0) {
        self.workout.weight = weight;
        [self performSegueWithIdentifier:@"startWorkout" sender:self];
    }
}

@end
