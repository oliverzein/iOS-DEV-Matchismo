//
//  GameResult.m
//  Matchismo
//
//  Created by Joe Cool on 16.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "GameResult.h"

@interface GameResult()
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;
@end

@implementation GameResult

#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"
#define ALL_RESULTS_KEY @"GameResult_All"

+ (NSArray *)allGameResults {
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
    }
    
    return allGameResults;
}

- (id)init {
    self = [super init];
    
    if(self) {
        _start = [NSDate date];
        _end = _start;
    }
    
    return self;
}

- (id)initFromPropertyList:(id)list {
    self = [self init];
    
    if(self) {
        if([list isKindOfClass: [NSDictionary class]]) {
            _start = list[START_KEY];
            _end = list[END_KEY];
            _score = [list[SCORE_KEY] intValue];
            if(!_start || !_end) self = nil;
        }
    }
    
    return self;
}

- (void)synchronize {
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    if(!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)asPropertyList {
    return @{START_KEY: self.start, END_KEY:self.end, SCORE_KEY:@(self.score)};
}

-(NSTimeInterval)duration {
    return [self.end timeIntervalSinceDate:self.start];
}

-(void)setScore:(int)score {
    _score = score;
    self.end = [NSDate date];
    [self synchronize];
}

@end
