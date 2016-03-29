//
//  Workout.h
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RFWorkout : NSObject

@property (strong, nonatomic) NSArray *availableIds;
@property (strong, nonatomic) NSString *selectedId;
@property (assign, nonatomic) NSInteger weight;

+ (NSArray *)getAvailableIds;

@end
