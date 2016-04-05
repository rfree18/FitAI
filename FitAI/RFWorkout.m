//
//  Workout.m
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFWorkout.h"

@implementation RFWorkout

float const sampleRate = 100;
float const deltaT = 1/sampleRate;
float const pwrThresh = 1;

-(id)init {
    self = [super init];
    
    if (self) {
        // Initialize all needed variables
        self.powerPoints = [[NSMutableArray alloc] init];
        self.velocityPoints = [[NSMutableArray alloc] init];
        self.dataPoints = [[NSMutableArray alloc] init];
        self.rmsVals = [[NSMutableArray alloc] init];
        self.rmsFilteredVals = [[NSMutableArray alloc] init];
        
        self.lift = false;
        self.reps = [NSNumber numberWithInteger:0];
        self.rest = true;
    }
    
    return self;
}

+ (NSArray *)getAvailableIds {
    static NSArray *_availableIds;
    
    if(!_availableIds) {
        _availableIds = [NSArray arrayWithObjects:@"Shoulder Press", @"Squat", @"Deadlift", nil];
    }
    
    return _availableIds;
}

-(float)simpleHighpassWithCurrent:(NSNumber *)curr previous:(NSNumber *)previous andFiltered:(NSNumber *)prevFilt {
    float rc = 1 / (2 * 3.14);
    float alpha = rc / (rc + deltaT);
    
    float output = alpha * ([prevFilt floatValue] + [curr floatValue] - [previous floatValue]);
    return output;
}

// Every millisecond
-(void)findDataWithX:(NSNumber *)x y:(NSNumber *)y andZ:(NSNumber *)z {
    
    float velocity = 0;
    float power = 0;
    float rmsFilt = 0;
    
    float xVal = powf([x floatValue], 2);
    float yVal = powf([y floatValue], 2);
    float zVal = powf([z floatValue], 2);
    float average = (xVal + yVal + zVal) / 3;
    
    float rms = sqrtf(average);
    
    if([self.velocityPoints count] > 0) {
        float rmsFilt = [self simpleHighpassWithCurrent:[NSNumber numberWithFloat:rms] previous:[self.rmsVals lastObject] andFiltered:[self.rmsFilteredVals lastObject]];
        
        velocity += rmsFilt * deltaT;
        power += self.weight * rmsFilt * velocity;
    }
    
    if(power > pwrThresh && !self.lift && self.rest) {
        NSLog(@"At rest");
    }
    else if(power < pwrThresh && !self.lift && self.rest) {
        NSLog(@"Midlift");
        self.lift = true;
        self.rest = false;
    }
    else if(power > pwrThresh && self.lift && !self.rest) {
        NSLog(@"Lift in progress");
    }
    else if(power < pwrThresh && !self.lift && !self.rest) {
        NSLog(@"End of lift: count as rep");
        self.lift = false;
        self.rest = true;
        float repCounter = [self.reps floatValue] + 1;
        self.reps = [NSNumber numberWithFloat:repCounter];
    }
    else if(power > pwrThresh && !self.lift && !self.rest) {
        NSLog(@"SIGNAL ARTIFACT");
    }
    else {
        NSLog(@"ERROR");
    }
    
    NSNumber *v = [NSNumber numberWithFloat:velocity];
    [self.velocityPoints addObject:v];
    
    NSNumber *rmsWrap = [NSNumber numberWithFloat:rms];
    [self.rmsVals addObject:rmsWrap];
    
    NSNumber *powerWrap = [NSNumber numberWithFloat:power];
    [self.powerPoints addObject:powerWrap];
    
    NSNumber *rmsFiltWrap = [NSNumber numberWithFloat:rmsFilt];
    [self.rmsFilteredVals addObject:rmsFiltWrap];
    
}

@end
