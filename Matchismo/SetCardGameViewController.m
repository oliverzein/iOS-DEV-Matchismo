//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Joe Cool on 18.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetPlayingCardDeck.h"
#import "SetCardGame.h"
#import "SetPlayingCard.h"
#import <QuartzCore/QuartzCore.h>

@interface SetCardGameViewController ()
@property (strong, nonatomic) SetCardGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@end

@implementation SetCardGameViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

-(SetCardGame *)game {
    if (!_game) {
        _game = [[SetCardGame alloc] initWithCardCount:24 usingDeck:[[SetPlayingCardDeck alloc] init]];
    }
    
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons {
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI {
    if(self.game) {
        for (UIButton *cardButton in self.cardButtons) {
            SetPlayingCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
            
            cardButton.selected = card.isFaceUp;
            cardButton.enabled = !card.isUnplayable;
            cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
            
            // Set Button border
            CALayer *btnLayer = [cardButton layer];
            //[btnLayer setMasksToBounds:YES];
            //[btnLayer setCornerRadius:5.0f];
            [btnLayer setBorderWidth:1.0f];
            [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
            
            // set background
            if(card.isFaceUp) {
                cardButton.backgroundColor = [UIColor grayColor];
            } else {
                cardButton.backgroundColor = nil;
            }
            [cardButton setAttributedTitle:card.attributedContents forState:UIControlStateSelected];
            [cardButton setAttributedTitle:card.attributedContents forState:UIControlStateNormal];
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

- (IBAction)flipCard:(UIButton *)sender {
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
}

- (IBAction)deal {
    self.game = nil;
    [self updateUI];
}
@end
