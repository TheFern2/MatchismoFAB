//
//  PlayingCard.m
//  Matchismo
//
//  Created by Fernando Balandran on 5/26/16.
//  Copyright © 2016 Fernando Balandran. All rights reserved.
//

#import "PlayingCard.h"
#import "NSLogger.h"

@implementation PlayingCard
@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for(PlayingCard *otherCard in otherCards)
    {
        if(otherCard.rank == self.rank)
        {
            score += 5;
            LoggerApp(4, @"Adding 5");
            
        } else if ([otherCard.suit isEqualToString:self.suit])
            {
                score += 2;
                LoggerApp(4, @"Adding 2");
            }
    }
    
    // TODO Work on a better scoring system.
    // The below makes sure that if the first card, doesn't match the next two
    // Still results in matching points, when the next two matched.
    // I.e. First card is 9 hearts, and next two are 4 diamonds, 3 diamonds.
    // Also if only two matched, it results in less matching points.
    
    NSMutableArray *otherCardsCollection = [otherCards mutableCopy];
    
    for(PlayingCard *otherCard in otherCards)
    {
        [otherCardsCollection removeObject:otherCard];
        
        for(PlayingCard *otherCardInOtherCardCollection in otherCardsCollection)
        {
            if(otherCard.rank == otherCardInOtherCardCollection.rank){
                
                score += 4;
                LoggerApp(4, @"Adding 4");
                
            } else if([otherCard.suit isEqualToString:otherCardInOtherCardCollection.suit]){
                score += 1;
                LoggerApp(4, @"Adding 1");
            }
        }
    }
    
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♥", @"♣", @"♦", @"♠"];
}

- (void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3",@"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings]count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
