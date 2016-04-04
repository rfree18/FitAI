//
//  RFRepData.h
//  FitAI
//
//  Created by Ross Freeman on 4/4/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFRepData : NSObject

@property (strong, nonatomic) NSDate *timestamp;
@property (assign, nonatomic) int x;
@property (assign, nonatomic) int y;
@property (assign, nonatomic) int z;

@end
