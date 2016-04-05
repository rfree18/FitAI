//
//  DevicesViewController.h
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MetaWear/MetaWear.h>

#import "RFWorkout.h"
#import "RFUserDataViewController.h"

@interface RFDevicesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *deviceTable;

@property (strong, nonatomic) NSMutableArray *devices;
@property (strong, nonatomic) MBLMetaWear *device;

@end
