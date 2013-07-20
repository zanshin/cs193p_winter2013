//
//  MatchingGame.m
//  Matchismo
//
//  Created by Mark Nichols on 7/19/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "MatchingGame.h"

@interface MatchingGame()
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *flipResult;
@property (nonatomic) NSString *flipText;
@property (nonatomic) NSString *flipScore;
@end

@implementation MatchingGame

// Lazily instantiate cards
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

// Lazily instantiate result string
- (NSString *)flipResult
{
    if (!_flipResult) _flipResult = [[NSString alloc] init];
    return _flipResult;
}

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

// return card at index
- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)flipCardAtIndex:(NSUInteger)index
{
    // implenetation to be done in sub-classes as matching rules will
    // vary from game to game.
}

@end
