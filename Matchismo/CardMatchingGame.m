//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mark Nichols on 7/6/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *flipResult;
@property (nonatomic) NSString *flipText;
@property (nonatomic) NSString *flipScore;
@end

@implementation CardMatchingGame

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

// synthesize numberOfMatchingCards since we overrode its mutators
@synthesize numberOfCardsToMatch = _numberOfCardsToMatch;

// Lazily instantiate numberOfMatchingCards and default it to 2 cards
- (int)numberOfCardsToMatch
{
    if (!_numberOfCardsToMatch) _numberOfCardsToMatch = 2;
    return _numberOfCardsToMatch;
}

// validity check on numberOfMatchingCards via its setter
- (void)setNumberOfCardsToMatch:(int)numberOfCardsToMatch
{
    if (numberOfCardsToMatch < 2) _numberOfCardsToMatch = 2;
    else if (numberOfCardsToMatch > 3) _numberOfCardsToMatch = 3;
    else _numberOfCardsToMatch = 2;
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

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

// flip playable card at index over
- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnplayable) {
        if (!card.isFaceUp) {            
            // track other cards & their contents
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            NSMutableArray *otherContents = [[NSMutableArray alloc] init];
            
            // see if flipping this card up creates a match
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    [otherCards addObject:otherCard];
                    [otherContents addObject:otherCard.contents];
                }
            }
            
            if ([otherCards count] < self.numberOfCardsToMatch - 1) {
                // set result to show rank/suit of card flipped up
                self.flipResult = [@"Flipped up " stringByAppendingString:card.contents];
            } else {
                int matchScore = [card match:otherCards];
                NSLog(@"%d", matchScore);
                if (matchScore) {
                    card.unplayable = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                    }
                    
                    self.score += matchScore * MATCH_BONUS;
                    self.flipResult = [NSString stringWithFormat:@"Matched %@ & %@. %d points.", card.contents,
                                       [otherContents componentsJoinedByString:@" & "], matchScore * MATCH_BONUS];
                } else {
                    for (Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }

                    self.score -= MISMATCH_PENALTY;
                    self.flipResult = [NSString stringWithFormat:@"Mismatched %@ & %@. %d point penalty.", card.contents,
                                       [otherContents componentsJoinedByString:@" & "], MISMATCH_PENALTY];

                }
            }
            
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
        
    }
}


@end
