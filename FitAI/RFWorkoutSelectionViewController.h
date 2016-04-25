//
//  WorkoutSelectionViewController.h
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MetaWear/MetaWear.h>

#import "RFWorkout.h"
#import "RFUserDataViewController.h"

@interface RFWorkoutSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) RFWorkout *userWorkout;
@property (strong, nonatomic) MBLMetaWear *device;
@property (strong, nonatomic) NSArray *presetWorkouts;
@property (weak, nonatomic) IBOutlet UITableView *optionsTable;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *optionButton;

@property (assign, nonatomic) BOOL isPreset;

- (IBAction)changeOptions:(id)sender;

@end
