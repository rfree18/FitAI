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
    return [RFWorkout getAvailableIds].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"workout"];
    
    cell.textLabel.text = [RFWorkout getAvailableIds][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.userWorkout.selectedId = [RFWorkout getAvailableIds][indexPath.row];
    
    [self performSegueWithIdentifier:@"weightSelection" sender:self];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
