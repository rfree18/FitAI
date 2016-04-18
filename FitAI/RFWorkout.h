//
//  Workout.h
//  FitAI
//
//  Created by Ross Freeman on 3/27/16.
//  Copyright © 2016 Ross Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MetaWear/MetaWear.h>

@interface RFWorkout : NSObject <NSCopying>

@property (strong, nonatomic) NSArray *availableIds;
@property (strong, nonatomic) NSString *selectedId;
@property (assign, nonatomic) NSInteger weight;
@property (strong, nonatomic) MBLMetaWear *device;

@property (strong, nonatomic) NSNumber *reps;
@property (assign, nonatomic) BOOL lift;
@property (assign, nonatomic) BOOL rest;
@property (strong, nonatomic) NSMutableArray *powerPoints;
@property (strong, nonatomic) NSMutableArray *velocityPoints;
@property (strong, nonatomic) NSMutableArray *dataPoints;
@property (strong, nonatomic) NSMutableArray *rmsVals;
@property (strong, nonatomic) NSMutableArray *rmsFilteredVals;

@property (strong, nonnull) RFWorkout *previousWorkout;

+ (NSArray *)getAvailableIds;
-(float)simpleHighpassWithCurrent:(NSNumber *)curr previous:(NSNumber *)previous andFiltered:(NSNumber *)prevFilt;
-(void)findDataWithX:(NSNumber *)x y:(NSNumber*)y andZ:(NSNumber *)z;

@end
