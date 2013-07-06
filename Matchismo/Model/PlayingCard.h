//
//  PlayingCard.h
//  Matchismo
//
//  Created by Mark Nichols on 7/6/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

// expose some class methods publically
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
