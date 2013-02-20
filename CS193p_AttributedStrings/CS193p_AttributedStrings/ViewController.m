//
//  ViewController.m
//  CS193p_AttributedStrings
//
//  Created by Joe Cool on 15.02.13.
//  Copyright (c) 2013 Creative Designs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

-(void) addLabelAttributes:(NSDictionary *)attributes range:(NSRange)range {
    if(range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
        [mat addAttributes:attributes range:range];
        self.label.attributedText = mat;
    }
}

-(void) addSelectedWordAttributes:(NSDictionary *)attributes {
    NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];
}

-(NSArray *)wordList {
    NSArray *wordList = [[self.label.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([wordList count]) {
        return wordList;
    } else {
        return @[@""];
    }
}

-(NSString *)selectedWord {
    return [self wordList][(int)self.selectedWordStepper.value];
}

- (IBAction)updateSelectedWord {
    self.selectedWordStepper.maximumValue = [[self wordList] count] - 1;
    self.selectedWordLabel.text = [self selectedWord];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateSelectedWord];
}

- (IBAction)underline {
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
}

- (IBAction)ununderline {
    [self addSelectedWordAttributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone)}];
}


- (IBAction)changeColor:(UIButton *)sender {
    [self addSelectedWordAttributes:@{NSForegroundColorAttributeName : sender.backgroundColor}];
}

- (IBAction)changeFont:(UIButton *)sender {
    CGFloat fontSize = [UIFont systemFontSize];
    NSDictionary *attributes = [self.label.attributedText attributesAtIndex:0 effectiveRange:NULL];
    UIFont *existingFont = attributes[NSFontAttributeName];
    if(existingFont) fontSize = existingFont.pointSize;
    UIFont *font = [sender.titleLabel.font fontWithSize:fontSize];
    [self addSelectedWordAttributes:@{NSFontAttributeName : font}];
}

- (IBAction)stroke {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName : @3.0}];
}

- (IBAction)unstroke {
    [self addSelectedWordAttributes:@{NSStrokeWidthAttributeName : @0.0}];
}

@end
