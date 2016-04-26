//
//  RFSummaryViewController.h
//  FitAI
//
//  Created by Ross Freeman on 4/5/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RFWorkout.h"
#import "RFResultsTableViewCell.h"

@interface RFSummaryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) RFWorkout *workout;
@property (weak, nonatomic) IBOutlet UITableView *resultsTable;

- (IBAction)restartWorkout:(id)sender;

@end
