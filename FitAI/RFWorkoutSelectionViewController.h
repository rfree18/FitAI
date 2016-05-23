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

// set up object 'workout_profile' to contain the contents of the loaded JSON file.
// fields are self-explanatory, and should be very easy to parse
// QUESTION: Can't cast NSIntegers and NSStrings in same object??
// will rely on casting the strings to ints if necessary
@interface workoutProfile : NSObject
@property(copy, nonatomic) NSString *athlete_id;
@property(copy, nonatomic) NSString *workout_order;
@property(copy, nonatomic) NSString *lift_name;
@property(copy, nonatomic) NSString *lift_weight;
@property(copy, nonatomic) NSString *lift_units;
// Copied from same source as in load_workout.
// Explicitly casts each line from the JSON file to a dict??
// QUESTION: Where do I put this??
-(instancetype)initWithDict:(NSDictionary *)dict;

@end