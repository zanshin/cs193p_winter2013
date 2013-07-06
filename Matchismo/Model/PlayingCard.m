//
//  PlayingCard.m
//  Matchismo
//
//  Created by Mark Nichols on 7/6/13.
//  Copyright (c) 2013 Mark Nichols. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit; // required since we provide setter and getter

// use setter to only valid suits are used
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

// use the getter to return "?" for index 0, i.e., nil
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

// use rank setter to ensure rank is always valid
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

// class method to return array of valid suits
+ (NSArray *)validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

// class method to return array of valid rank strings
+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

// return the maxiumum number of ranks (typically 13)
+ (NSUInteger)maxRank { return [self rankStrings].count - 1; }

// method to retun contenst of PlayingCard, rank and suit
- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}


// a specific match implementation for PlayingCard, works on suit & rank
// matching rank is 4x harder than matching suit, so it gets more points
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if (otherCards.count == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    }
    
    return score;
}
@end
