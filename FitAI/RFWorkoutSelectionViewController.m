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
    
    // Want to load in workout from profile on disk.
    // Will load in the preset workouts and populate into the view here
    // Want to be able to pass in athlete ID and retrieve all values for that athlete
    workoutProfile *workout_info = [workout_info init];
    
    
    for (NSDictionary *object in workout_info) {
        // Probably dont' need to extract out each field
        //NSString *athleteID = object[@"athlete_id"];
        //NSString *workoutOrder = object[@"workout_order"];
        NSString *liftName = object[@"lift_name"];
        NSString *liftWeight = object[@"lift_weight"];
        NSString *liftUnits = object[@"lift_units"];
        
        NSString *workoutEntry = [NSString stringWithFormat: @"%@ - %@%@", liftName, liftWeight, liftUnits];
        NSLog(@"Read in workout string %@", workoutEntry);
    }
    
    self.presetWorkouts = @[@"Shoulder Press - 65lbs", @"Standing Row - 65lbs"];
    
    self.isPreset = NO;
}

// Function to load in data from disk
// Should return a 'workout_profile' object as defined in RFWorkoutSelectionViewController.h
// Is a dictionary of all relevant fields, present in the 'sample_workout_profile.json' file
// QUESTION: Can I do a return of a custom object like this? Or do I need to use a NSObject as the return?
+ (workoutProfile *)loadWorkout{
    // NOTE: Copied/edited from https://codereview.stackexchange.com/questions/66366/turning-json-objects-into-custom-nsobjects

    NSError *error;
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"sample_workout_profile" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    if (jsonData == nil) {
        NSLog(@"Error reading in/parsing JSON file");
    }
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    if (jsonArray == nil) {
        NSLog(@"Error converting JSON object to array? %@",error.localizedDescription);
    }
    
    // NOTE: JSON object has the following contents:
    //    [{“athlete_id”: 1, “workout_order”: 1, “lift_name”: ”squat”, “lift_weight”: 45, “lift_units”: ”lbs”},
    //    {“athlete_id”: 1, “workout_order”: 2, “lift_name”: ”squat”, “lift_weight”: 65, “lift_units”: ”lbs”}]

    // Create custom objects from JSON array
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in jsonArray) {
        workoutProfile *entry = [[workoutProfile alloc] initWithDict: dict];
        [items addObject: entry];
    }
    
    // QUESTION: return the entire object (contained within 'items' I guess) or just the latest line??
    return [items copy];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict;
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
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
