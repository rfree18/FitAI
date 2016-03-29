//
//  WorkoutSelectionViewController.h
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RFWorkout.h"

@interface RFWorkoutSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) RFWorkout *userWorkout;

@end
