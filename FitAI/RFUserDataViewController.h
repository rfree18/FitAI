//
//  RFUserDataViewController.h
//  FitAI
//
//  Created by Ross Freeman on 3/29/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RFWorkout.h"

@interface RFUserDataViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *weightTextField;

@property (strong, nonatomic) RFWorkout *workout;

- (IBAction)submitData:(id)sender;

@end
