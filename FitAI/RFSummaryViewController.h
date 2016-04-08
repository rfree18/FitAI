//
//  RFSummaryViewController.h
//  FitAI
//
//  Created by Ross Freeman on 4/5/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RFWorkout.h"

@interface RFSummaryViewController : UIViewController

// @property (weak, nonatomic) IBOutlet UILabel *setNum;
@property (weak, nonatomic) IBOutlet UILabel *avgPwrLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgVelLabel;
@property (weak, nonatomic) IBOutlet UILabel *peakPwrLabel;
@property (weak, nonatomic) IBOutlet UILabel *peakVelLabel;
@property (weak, nonatomic) IBOutlet UILabel *powerSumLabel;

@property (strong, nonatomic) RFWorkout *workout;

- (IBAction)restartWorkout:(id)sender;

@end
