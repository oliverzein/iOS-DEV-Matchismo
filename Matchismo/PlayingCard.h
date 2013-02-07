//
//  PlayingCard.h
//  Matchismo
//
//  Created by Joe Cool on 2/7/13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end
