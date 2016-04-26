//
//  RFWorkoutViewController.m
//  FitAI
//
//  Created by Ross Freeman on 4/4/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFWorkoutViewController.h"

@interface RFWorkoutViewController ()

@end

@implementation RFWorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Reset labels to blank values
    self.powerLabel.text = @"";
    self.velocityLabel.text = @"";
    self.repsLabel.text = @"";
}

-(void)viewDidAppear:(BOOL)animated {
    NSInteger weight = self.workout.weight;
    
    self.workout = [[RFWorkout alloc] init];
    self.workout.weight = weight;
    
    [self collectData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collectData {
    BFTask<NSArray<MBLMetaWear *> *> *devices = [[MBLMetaWearManager sharedManager] retrieveSavedMetaWearsAsync];
    
    [devices success:^(NSArray<MBLMetaWear *> * _Nonnull result) {
        self.device = result[0];
        
        MBLAccelerometer *accelerometer = self.device.accelerometer;
        
        accelerometer.sampleFrequency = 10;
        
        [accelerometer.dataReadyEvent startNotificationsWithHandlerAsync:^(MBLAccelerometerData * _Nullable obj, NSError * _Nullable error) {
            if (!error) {
                [self.workout findDataWithX:[NSNumber numberWithDouble:obj.x] y:[NSNumber numberWithDouble:obj.y] andZ:[NSNumber numberWithDouble:obj.z]];
                // NSLog([NSString stringWithFormat:@"%2.6f W", [[_workout.powerPoints lastObject]floatValue]]);
                
                // These values should not update if the user is in the 'pre-lift' phase, meaning he has not started the workout yet.
                // Want findDataWithX(), and the lift detection within that, to decide if/when these values should appear.
                // The values will all be stored, for now, regardless of if they are printed.
                if( _workout.exercise ) {
                    self.powerLabel.text = [NSString stringWithFormat:@"%4.2f mW", [[_workout.powerPoints lastObject]floatValue]*1000 ];
                    self.velocityLabel.text = [NSString stringWithFormat:@"%4.2f mm/s", [[_workout.velocityPoints lastObject] floatValue]*1000];
                    self.repsLabel.text = [NSString stringWithFormat:@"%ld", (long)[_workout.reps integerValue]];
                }
                else{
                    self.powerLabel.text = @"Pre Lift";
                    self.velocityLabel.text = @" ";
                    self.repsLabel.text = @" ";
                }
            }
            
            else {
                NSLog(@"%@", error.localizedDescription);
            }
        }];
    }];
}

- (IBAction)completeWorkout:(id)sender {
    MBLAccelerometer *accelerometer = self.device.accelerometer;
    
    [accelerometer.dataReadyEvent stopNotificationsAsync];
    
    [self performSegueWithIdentifier:@"showSummary" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    RFSummaryViewController *dest = [segue destinationViewController];
    
    dest.workout = self.workout;
}

@end
