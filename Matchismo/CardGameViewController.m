//
//  ViewController.m
//  Matchismo
//
//  Created by Joe Cool on 2/7/13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@end

@implementation CardGameViewController

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Number of flips updated to %d", self.flipCount);
}

- (IBAction)flipCard:(UIButton *)sender {
    PlayingCard *card = (PlayingCard *)[self.deck drawRandomCard];
    NSLog(@"Your card: %@", card.contents);
    [sender setTitle:card.contents forState:UIControlStateSelected];
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

- (PlayingCardDeck *)deck {
    if(!_deck) _deck = [[PlayingCardDeck alloc] init];
    
    return _deck;
}
@end
