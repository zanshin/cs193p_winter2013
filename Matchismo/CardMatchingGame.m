//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Mark Nichols on 7/6/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *flipResult;
@end

@implementation CardMatchingGame

// override numberOfCardsToMatch getter to ensure it is 2 by default
- (int)numberOfCardsToMatch
{
    if (!_numberOfCardsToMatch) _numberOfCardsToMatch = 2;
    return _numberOfCardsToMatch;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

// flip playable card at index over
- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isUnplayable) {
        if (!card.isFaceUp) {
            self.flipResult = [NSString stringWithFormat:@"Flipped up %@", card.contents];
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            
            // check to see if first two cards match in three card match mode
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    if ([card match:@[otherCard]]) {
                        [otherCards addObject:otherCard];
                    } else {
                        otherCard.faceUp = NO;
                        self.flipResult = [NSString stringWithFormat:@"%@ and %@ don't match. %d point penalty",
                                           card.contents, otherCard.contents, MISMATCH_PENALTY];
                    }
                }
            }
            
            if ([otherCards count] == self.numberOfCardsToMatch - 1) {
                int matchScore = [card match:otherCards];
                if (matchScore) {
                    card.unplayable = YES;
                    self.flipResult = [NSString stringWithFormat:@"%@ ", card.contents];
                    for (Card *otherCard in otherCards) {
                        otherCard.unplayable = YES;
                        self.flipResult = [self.flipResult stringByAppendingFormat:@"%@ ", otherCard.contents];
                        if (![otherCards lastObject]) {
                            self.flipResult = [self.flipResult stringByAppendingFormat:@"& "];
                        }
                    }
                    
                    self.score += matchScore * MATCH_BONUS * self.numberOfCardsToMatch;
                    self.flipResult = [self.flipResult stringByAppendingFormat:@"match. Match Bonus!"];
                } else {
                    for (Card *otherCard in otherCards) {
                        otherCard.faceUp = NO;
                    }
                    
                    self.score -= MISMATCH_PENALTY;
                }
            }
            
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }

    
}


@end
