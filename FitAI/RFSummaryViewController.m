//
//  RFSummaryViewController.m
//  FitAI
//
//  Created by Ross Freeman on 4/5/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFSummaryViewController.h"

@interface RFSummaryViewController ()

@end

@implementation RFSummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    float avgPwr = [[self.workout.powerPoints valueForKey:@"@avg.floatValue"] floatValue];
//    float avgVel = [[self.workout.velocityPoints valueForKey:@"@avg.floatValue"] floatValue];
//    float peakPwr = [[self.workout.powerPoints valueForKey:@"@max.floatValue"] floatValue];
//    float peakVel = [[self.workout.velocityPoints valueForKey:@"@max.floatValue"] floatValue];
    
    self.avgPwrLabel.text = [NSString stringWithFormat:@"%@ %.6f", self.avgPwrLabel.text, [[self.workout.powerPoints valueForKeyPath:@"@avg.self"] floatValue]];
    self.avgVelLabel.text = [NSString stringWithFormat:@"%@ %.6f", self.avgVelLabel.text, [[self.workout.velocityPoints valueForKeyPath:@"@avg.self"] floatValue]];
    self.peakPwrLabel.text = [NSString stringWithFormat:@"%@ %.6f", self.peakPwrLabel.text, [[self.workout.powerPoints valueForKeyPath:@"@max.self"] floatValue]];
    self.peakVelLabel.text = [NSString stringWithFormat:@"%@ %.6f", self.peakVelLabel.text, [[self.workout.velocityPoints valueForKeyPath:@"@max.self"] floatValue]];
    self.powerSumLabel.text = [NSString stringWithFormat:@"%@ %.6f", self.powerSumLabel.text, [[self.workout.powerPoints valueForKeyPath:@"@sum.self"] floatValue]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)restartWorkout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
