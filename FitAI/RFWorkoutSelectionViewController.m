//
//  WorkoutSelectionViewController.m
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFWorkoutSelectionViewController.h"

@interface RFWorkoutSelectionViewController ()

@end

@implementation RFWorkoutSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.userWorkout = [[RFWorkout alloc] init];
    self.userWorkout.device = self.device;
    
    self.presetWorkouts = @[@"Shoulder Press - 65lbs", @"Standing Row - 65lbs"];
    self.isPreset = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.isPreset){
        return self.presetWorkouts.count;
    }
    return [RFWorkout getAvailableIds].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workout"];
    
    if(self.isPreset) {
        cell.textLabel.text = self.presetWorkouts[indexPath.row];
    }
    else{
        cell.textLabel.text = [RFWorkout getAvailableIds][indexPath.row];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.isPreset) {
        
        if(indexPath.row == 0) {
            self.userWorkout.selectedId = [RFWorkout getAvailableIds][0];
            self.userWorkout.weight = 65;
        }
        
        else {
            self.userWorkout.selectedId = [RFWorkout getAvailableIds][0];
            self.userWorkout.weight = 65;
        }
        
        [self performSegueWithIdentifier:@"choosePreset" sender:self];
    }
    
    else {
        self.userWorkout.selectedId = [RFWorkout getAvailableIds][indexPath.row];
        [self performSegueWithIdentifier:@"weightSelection" sender:self];
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    RFUserDataViewController *dest = [segue destinationViewController];
    dest.workout = self.userWorkout;
}


- (IBAction)changeOptions:(id)sender {
    if(self.isPreset) {
        self.optionButton.title = @"Manual";
    }
    
    else {
        self.optionButton.title = @"Preset";
    }
    
    self.isPreset = !self.isPreset;
    
    [self.optionsTable reloadData];
}
@end
