//
//  SetPlayingCardDeck.m
//  Matchismo
//
//  Created by Joe Cool on 18.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"

@implementation SetPlayingCardDeck

- (id)init {
    self = [super init];
    
    if(self) {
        for (NSString *symbol in [SetPlayingCard validSymbols]) {
            for (NSString *shading in [SetPlayingCard validShadings]) {
                for (UIColor *color in [SetPlayingCard validColors]) {
                    for (NSUInteger number=1; number <= [SetPlayingCard maxNumber]; number++) {
                        SetPlayingCard *card = [[SetPlayingCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card atTop:YES];
                        NSLog(@"%@", [card contents]);
                    }
                }
            }
        }
    }
    
    return self;
}

@end
