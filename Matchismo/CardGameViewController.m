//
//  ViewController.m
//  Matchismo
//
//  Created by Joe Cool on 2/7/13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchMode;
@end

@implementation CardGameViewController

-(void)resetGame {
    _game = nil;
    self.flipCount = 0;
    if(self.game) {
        // new game started
        self.matchMode.enabled = YES;
        [self updateUI];
    }
}

-(CardMatchingGame *)game {
    if (!_game) {
        int matchCards = 2;
        if (self.matchMode.selectedSegmentIndex == 0) {
            matchCards = 2;
        } else if (self.matchMode.selectedSegmentIndex == 1) {
            matchCards = 3;
        }
        _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init] matchCards:matchCards];
    }
    
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    UIImage *cardImage = [UIImage imageNamed:@"euchre_card_back.jpg"];
    UIEdgeInsets insets = UIEdgeInsetsMake(4, 4, 4, 4);
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        cardButton.imageEdgeInsets = insets;
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled ];
        cardButton.selected = card.isFaceUp;
        if(cardButton.isSelected)
            [cardButton setImage:nil forState:UIControlStateNormal];
        else
            [cardButton setImage:cardImage forState:UIControlStateNormal];        
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipResultLabel.text = self.game.flipResult;
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"Number of flips updated to %d", self.flipCount);
}

- (IBAction)dealCards:(UIButton *)sender {
    [self resetGame];
}

- (IBAction)flipCard:(UIButton *)sender {
    if(self.matchMode.enabled) self.matchMode.enabled = NO;
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)matchModeChanged:(UISegmentedControl *)sender {
    [self resetGame];
}

@end
