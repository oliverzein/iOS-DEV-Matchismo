//
//  SetPlayingCard.m
//  Matchismo
//
//  Created by Joe Cool on 18.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "SetPlayingCard.h"

@implementation SetPlayingCard

@synthesize symbol = _symbol;

-(NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

- (void)setSymbol:(NSString *)symbol {
    if([[SetPlayingCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setColor:(UIColor *)color {
    if ([[SetPlayingCard validColors] containsObject:color]) {
        _color = color;
    }
}

-(void)setShading:(NSString *)shading {
    if ([[SetPlayingCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

-(void)setNumber:(NSUInteger)number {
    if( number <= [SetPlayingCard maxNumber]) {
        _number = number;
    }
}

-(NSUInteger)symbolComparable {
    NSUInteger resultInt = (int)pow(2.0, (double)[[SetPlayingCard validSymbols] indexOfObject:self.symbol]);
    return resultInt;
}

-(NSUInteger)colorComparable {
    NSUInteger resultInt = (int)pow(2.0, (double)[[SetPlayingCard validColors] indexOfObject:self.color]);
    return resultInt;
}

-(NSUInteger)shadingComparable {
    NSUInteger resultInt = (int)pow(2.0, (double)[[SetPlayingCard validShadings] indexOfObject:self.shading]);
    return resultInt;
}

-(NSUInteger)numberComparable {
    NSUInteger resultInt = (int)pow(2.0, (double)self.number - 1);
    return resultInt;
}

-(NSString *)contents {
    NSString *content = [NSString stringWithFormat:@"%d - %@ - %@ - %@", self.number, self.symbol, self.color, self.shading];
    return content;
}

-(NSAttributedString *)attributedContents {
    NSMutableString *symbols = [[NSMutableString alloc] init];
    for (NSInteger i=1; i<=self.number; i++) {
        [symbols appendString:self.symbol];
    }
    
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc] initWithString:symbols];
    
    NSRange range = NSMakeRange(0, self.number);
    [contents addAttributes:@{NSForegroundColorAttributeName: self.color} range:range];
    
    if([self.shading isEqualToString:@"open"]) {
        [contents addAttributes:@{NSStrokeWidthAttributeName : @8.0} range:range];
    } else if([self.shading isEqualToString:@"striped"]) {
        UIColor *colorWithAlpha = [self.color colorWithAlphaComponent:0.3];
        [contents addAttributes:@{NSStrokeWidthAttributeName : @-8.0} range:range];
        [contents addAttributes:@{NSForegroundColorAttributeName : colorWithAlpha} range:range];
        [contents addAttributes:@{NSStrokeColorAttributeName : self.color} range:range];
    }
    
    return contents;
}

+ (NSArray *) validSymbols {
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *) validColors {
    return @[[UIColor redColor], [UIColor greenColor], [UIColor purpleColor]];
}

+ (NSArray *) validShadings {
    return @[@"solid", @"open", @"striped"];
}

+ (NSUInteger) maxNumber {
    return 3;
}

- (int)match:(NSArray *)otherCards {
    int score=0;
    
    // to be implemented
    
    return score;
}

@end
