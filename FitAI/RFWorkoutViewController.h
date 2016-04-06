//
//  RFWorkoutViewController.h
//  FitAI
//
//  Created by Ross Freeman on 4/4/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MetaWear/MetaWear.h>

#import "RFWorkout.h"
#import "RFSummaryViewController.h"

@interface RFWorkoutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *powerLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsLabel;
@property (weak, nonatomic) IBOutlet UILabel *velocityLabel;

@property (strong, nonatomic) RFWorkout *workout;
@property (retain, nonatomic) NSTimer *timer;
@property (strong, nonatomic) MBLMetaWear *device;

-(void)collectData;
- (IBAction)completeWorkout:(id)sender;

@end
