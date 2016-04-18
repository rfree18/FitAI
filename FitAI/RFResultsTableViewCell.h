//
//  RFResultsTableViewCell.h
//  FitAI
//
//  Created by Ross Freeman on 4/18/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RFResultsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *avgVelLabel;
@property (weak, nonatomic) IBOutlet UILabel *avgPwrLabel;
@property (weak, nonatomic) IBOutlet UILabel *peakVelLabel;
@property (weak, nonatomic) IBOutlet UILabel *peakPwrLabel;
@property (weak, nonatomic) IBOutlet UILabel *pwrSumLabel;

@end
