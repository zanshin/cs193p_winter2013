//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Mark Nichols on 7/6/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameSelector;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation CardGameViewController

// Lazily instantiate our game
- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                          usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

// keeps the UI in sync with the model
- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.unplayable ? 0.3 : 1.0;
                
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipResultsLabel.text = self.game.flipResult;
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

// when "Deal" is tapped, start a new game
- (IBAction)dealButton
{
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
}

// the gameSelector determines if this is a 2-card match game or a 3-card match game
- (IBAction)gameSelectorChanged
{
    switch (self.gameSelector.selectedSegmentIndex) {
        case 0:
            self.game.numberOfCardsToMatch = 2;
            self.flipResultsLabel.text = @"2 card match mode selected";
            break;
            
        case 1:
            self.game.numberOfCardsToMatch = 3;
            self.flipResultsLabel.text = @"3 card match mode selected";
            break;
            
        default:
            self.game.numberOfCardsToMatch = 2;
            self.flipResultsLabel.text = @"2 card match mode selected";
            break;
    }
}


@end
