//
//  Workout.m
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFWorkout.h"

@implementation RFWorkout

+ (NSArray *)getAvailableIds {
    static NSArray *_availableIds;
    
    if(!_availableIds) {
        _availableIds = [NSArray arrayWithObjects:@"Shoulder Press", @"Squat", @"Deadlift", nil];
    }
    
    return _availableIds;
}

@end
