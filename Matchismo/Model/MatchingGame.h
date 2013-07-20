//
//  MatchingGame.h
//  Matchismo
//
//  Created by Mark Nichols on 7/19/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface MatchingGame : NSObject
@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *flipResult;
@property (strong, nonatomic) NSMutableArray *cards;


// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;
@end
