//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Fernando Balandran on 5/26/16.
//  Copyright © 2016 Fernando Balandran. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if(self)
    {
        for(NSString *suit in [PlayingCard validSuits])
        {
            for(NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++)
            {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}

@end
