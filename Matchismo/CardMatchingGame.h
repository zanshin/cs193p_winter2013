//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Mark Nichols on 7/6/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) int score;

@property (nonatomic, readonly) NSString *flipResult;

@property (nonatomic) int numberOfCardsToMatch;

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;




@end
