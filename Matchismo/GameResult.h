//
//  GameResult.h
//  Matchismo
//
//  Created by Joe Cool on 16.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject

@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;
@property (nonatomic) int score;

+ (NSArray *)allGameResults;

@end
