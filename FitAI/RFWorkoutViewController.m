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
    
    [self collectData];
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

-(void)collectData {
    BFTask<NSArray<MBLMetaWear *> *> *devices = [[MBLMetaWearManager sharedManager] retrieveSavedMetaWearsAsync];
    
    [devices success:^(NSArray<MBLMetaWear *> * _Nonnull result) {
        self.device = result[0];
        
        MBLAccelerometer *accelerometer = self.device.accelerometer;
        
        accelerometer.sampleFrequency = 100;
        
        [accelerometer.dataReadyEvent startNotificationsWithHandlerAsync:^(MBLAccelerometerData * _Nullable obj, NSError * _Nullable error) {
            if (!error) {
                [self.workout findDataWithX:[NSNumber numberWithDouble:obj.x] y:[NSNumber numberWithDouble:obj.y] andZ:[NSNumber numberWithDouble:obj.z]];
                NSLog(@"%@", [NSNumber numberWithDouble:obj.y]);
                self.powerLabel.text = [NSString stringWithFormat:@"%f", [[_workout.powerPoints lastObject] floatValue]];
                self.velocityLabel.text = [NSString stringWithFormat:@"%f", [[_workout.velocityPoints lastObject] floatValue]];
                self.repsLabel.text = [NSString stringWithFormat:@"%ld", (long)[_workout.reps integerValue]];
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
}
@end