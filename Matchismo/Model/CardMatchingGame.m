//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Joe Cool on 08.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSMutableString *flipResult;
@property (nonatomic) int matchCards;
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchCards:(int)i {
    self = [super init];
    
    if(self) {
        if(i < 2 || i > 3)
            return nil;
        
        self.matchCards = i;
        
        for (int i=0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(!card)
                self = nil;
            else
                self.cards[i] = card;
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < self.cards.count) ? self.cards[index] : nil;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *otherCards = [[NSMutableArray alloc] init];
    
    if(!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.flipResult = [NSMutableString stringWithFormat:@"Flipped up %@", card.contents];
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    // store other cards to match
                    [otherCards addObject:otherCard];
                    if(otherCards.count == self.matchCards - 1) {
                        int matchScore = [card match:otherCards];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            [self.flipResult appendFormat:@" and %@. Match for %d points.", otherCard.contents, matchScore * MATCH_BONUS];
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            [self.flipResult appendFormat:@" and %@. Mismatch for %d penalty.", otherCard.contents, MISMATCH_PENALTY];
                        }
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
}

@end
