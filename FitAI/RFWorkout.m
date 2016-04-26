//
//  Workout.m
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import "RFWorkout.h"

@implementation RFWorkout

float const sampleRate = 10;
float const deltaT = 1/sampleRate;

// used to decide how much of the signal should be considered as noise
float const num_sec = 2.;

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
    
    float const pwrThresh = 0.20 * self.weight/45.0;  // Watts

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
    
    // i = self.velocityPoint count
    if ( (!self.exercise) && ([self.velocityPoints count] > (num_sec * sampleRate)) ){
        //float noise_max = max(self.powerPoints);
        float noise_max = [[self.powerPoints valueForKeyPath:@"@max.self"] floatValue];
        float noise_min = [[self.powerPoints valueForKeyPath:@"@min.self"] floatValue];  // may not be necessary
        
        NSExpression *expression = [NSExpression expressionForFunction:@"stddev:" arguments:@[[NSExpression expressionForConstantValue:self.powerPoints]]];
        float noise_std = [[expression expressionValueWithObject:nil context:nil] floatValue];
        //float noise_std = std(self.powerPoints);  // standard deviation
        
        if ( power > (noise_max + 3. * noise_std) ) {
            // Once this triggers, the signal will get passed through the rep counter
            self.exercise = true;
            // Track this for use on plot later (maybe?)
            int exercise_iter = [self.velocityPoints count];
        }
    }
    else {
        // display to user that the exercise has NOT started yet. Any incoming signal is stored,
        // but not considered for processing towards rep count
        // should probably restrict the summary numbers on the workout summary screen to exclude
        // any time point that is here - in the pre-lift phase (e.g. when self.exercise = False)
        NSLog(@"pre lift");
    }
    
    if (self.exercise) {
        
        if(power < pwrThresh && !self.lift && self.rest) {
            NSLog(@"Exercise in progress");
        }
        else if(power > pwrThresh && !self.lift && self.rest) {
            NSLog(@"Midlift");
            self.lift = true;
            self.rest = false;
        }
        else if(power > pwrThresh && self.lift && !self.rest) {
            NSLog(@"Lift in progress");
        }
        else if(power < pwrThresh && self.lift && !self.rest) {
            NSLog(@"End of lift: count as rep");
            self.lift = false;
            self.rest = true;
            float repCounter = [self.reps floatValue] + 0.5;
            self.reps = [NSNumber numberWithFloat:repCounter];
        }
        else if(power > pwrThresh && !self.lift && !self.rest) {
            NSLog(@"SIGNAL ARTIFACT");
        }
        else {
            NSLog(@"ERROR");
        }
        
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

#pragma mark - copy
- (id)copyWithZone:(NSZone *)zone {
    RFWorkout *copy = [[RFWorkout alloc] init];
    
    copy.weight = self.weight;
    copy.reps = self.reps;
    copy.powerPoints = self.powerPoints;
    copy.velocityPoints = self.velocityPoints;
    copy.dataPoints = self.dataPoints;
    copy.rmsVals = self.rmsVals;
    copy.rmsFilteredVals = self.rmsFilteredVals;
    
    return copy;
}

@end
