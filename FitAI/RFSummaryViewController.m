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
    
    // Make sure that resultsTable recognizes custom cell
    [self.resultsTable registerNib:[UINib nibWithNibName:@"ResultsCell" bundle:nil] forCellReuseIdentifier:@"result"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    // Save previous workout
    self.workout.previousWorkout = [self.workout copyWithZone:nil];
    NSLog(@"Test");
}

#pragma mark - Table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RFResultsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"result"];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ResultsCell" bundle:nil] forCellReuseIdentifier:@"result"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"result"];
    }
    
    // Set workout to display in proper cell
    RFWorkout *chosenWorkout = indexPath.row == 0 ? self.workout : self.workout.previousWorkout;
    
    cell.avgPwrLabel.text = [NSString stringWithFormat:@"Average Power: %6.2f W", [[chosenWorkout.powerPoints valueForKeyPath:@"@avg.self"] floatValue]];
    cell.avgVelLabel.text = [NSString stringWithFormat:@"Average Velocity: %4.4f mm/s", [[chosenWorkout.velocityPoints valueForKeyPath:@"@avg.self"] floatValue]*1000]; //measured in mm/s
    cell.peakPwrLabel.text = [NSString stringWithFormat:@"Peak Power: %6.2f W", [[chosenWorkout.powerPoints valueForKeyPath:@"@max.self"] floatValue]];
    cell.peakVelLabel.text = [NSString stringWithFormat:@"Peak Velocity: %4.4f mm/s", [[chosenWorkout.velocityPoints valueForKeyPath:@"@max.self"] floatValue]*1000]; // measured in mm/s
    cell.pwrSumLabel.text = [NSString stringWithFormat:@"Total Power: %6.2f W", [[chosenWorkout.powerPoints valueForKeyPath:@"@sum.self"] floatValue]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (_resultsTable.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.frame.size.height) / 2.0;
}

- (IBAction)restartWorkout:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
