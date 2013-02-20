//
//  SetCardGame.h
//  Matchismo
//
//  Created by Joe Cool on 18.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetPlayingCardDeck.h"
#import "SetPlayingCard.h"

@interface SetCardGame : NSObject
@property (nonatomic, readonly) int score;

// designated initializer
-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;
-(SetPlayingCard *) cardAtIndex:(NSUInteger)index;
-(void) flipCardAtIndex:(NSUInteger)index;
@end
