//
//  PlayingCard.h
//  Matchismo
//
//  Created by Fernando Balandran on 5/26/16.
//  Copyright © 2016 Fernando Balandran. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

// Public methods
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
