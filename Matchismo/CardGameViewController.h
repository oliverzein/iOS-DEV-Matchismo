//
//  ViewController.h
//  Matchismo
//
//  Created by Joe Cool on 2/7/13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCardDeck.h"

@interface CardGameViewController : UIViewController
@property (strong, nonatomic) PlayingCardDeck *deck;
@end
