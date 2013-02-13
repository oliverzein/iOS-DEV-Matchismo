//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Joe Cool on 08.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
-(id) initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck matchCards:(int)i;
-(void) flipCardAtIndex:(NSUInteger)index;
-(Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSMutableString *flipResult;

@end
