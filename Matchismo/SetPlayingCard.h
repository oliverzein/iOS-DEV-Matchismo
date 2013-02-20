//
//  SetPlayingCard.h
//  Matchismo
//
//  Created by Joe Cool on 18.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) UIColor *color;
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *shading;

+ (NSArray *) validSymbols;
+ (NSArray *) validColors;
+ (NSArray *) validShadings;
+ (NSUInteger) maxNumber;
-(NSAttributedString *)attributedContents;
-(NSUInteger)symbolComparable;
-(NSUInteger)colorComparable;
-(NSUInteger)shadingComparable;
-(NSUInteger)numberComparable;

@end
