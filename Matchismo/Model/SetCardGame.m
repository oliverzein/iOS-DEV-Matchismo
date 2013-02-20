//
//  SetCardGame.m
//  Matchismo
//
//  Created by Joe Cool on 18.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "SetCardGame.h"

@interface SetCardGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@end

@implementation SetCardGame

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i=0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if(!card)
                self = nil;
            else
                self.cards[i] = card;
        }
    }
    
    return self;
}

-(NSArray *) flippedCards {
    NSMutableArray *flippedCards = [[NSMutableArray alloc] init];
    
    for (Card *card in self.cards) {
        if(card.isFaceUp && !card.isUnplayable)
            [flippedCards addObject:card];
    }
    
    return flippedCards;
}

- (SetPlayingCard *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

-(void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if(!card.isUnplayable) {
        if (!card.isFaceUp) {
        }
        card.faceUp = !card.isFaceUp;
        NSLog(@"Selected: %d", [[self flippedCards] count]);
        if([[self flippedCards] count] == 3) {
            BOOL isSet = [self isSet:[self flippedCards]];
            NSLog(@"isSet: %d", isSet);
            if(isSet) {
                for (Card *card in [self flippedCards]) {
                    card.unplayable = YES;
                }
                self.score += MATCH_BONUS;
            } else {
                self.score -= MISMATCH_PENALTY;
            }
        }
    }
}

-(BOOL) isSet:(NSArray *) cardSet {
    SetPlayingCard *card1 = cardSet[0];
    SetPlayingCard *card2 = cardSet[1];
    SetPlayingCard *card3 = cardSet[2];
    
    // & > 0 : all equal
    // | = 7 : all different
    
    if(cardSet && cardSet.count == 3) {
        // match numbers
        NSUInteger matchResult = [card1 numberComparable] & [card2 numberComparable] & [card3 numberComparable];
        if(matchResult == 0) {
            matchResult = [card1 numberComparable] | [card2 numberComparable] | [card3 numberComparable];
            if(matchResult != 7) {
                NSLog(@"Failed number test.");
                return NO;
            }
        }
        
        // match symbols
        matchResult = [card1 symbolComparable] & [card2 symbolComparable] & [card3 symbolComparable];
        if(matchResult == 0) {
            matchResult = [card1 symbolComparable] | [card2 symbolComparable] | [card3 symbolComparable];
            if(matchResult != 7) {
                NSLog(@"Failed symbol test.");
                return NO;
            }
        }
        
        // match colors
        matchResult = [card1 colorComparable] & [card2 colorComparable] & [card3 colorComparable];
        if(matchResult == 0) {
            matchResult = [card1 colorComparable] | [card2 colorComparable] | [card3 colorComparable];
            if(matchResult != 7) {
                NSLog(@"Failed color test.");
                return NO;
            }
        }
        
        // match shading
        matchResult = [card1 shadingComparable] & [card2 shadingComparable] & [card3 shadingComparable];
        if(matchResult == 0) {
            matchResult = [card1 shadingComparable] | [card2 shadingComparable] | [card3 shadingComparable];
            if(matchResult != 7) {
                NSLog(@"Failed shading test.");
                return NO;
            }
        }
    }
    
    // if we reach this, all tests passed and it is a set
    return YES;
}

@end
