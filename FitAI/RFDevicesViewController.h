//
//  DevicesViewController.h
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MetaWear/MetaWear.h>

@interface RFDevicesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *deviceTable;

@property (strong, nonatomic) NSMutableArray *devices;

@end
