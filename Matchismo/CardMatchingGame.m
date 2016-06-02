//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Fernando Balandran on 5/27/16.
//  Copyright © 2016 Fernando Balandran. All rights reserved.
//

#import "CardMatchingGame.h"
#import "NSLogger.h"

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

@interface CardMatchingGame()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong)NSMutableArray *cards; // of Card
@property (nonatomic) NSInteger maxMatchingCards;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
                       usingCards:(NSInteger)maxMatchingCards
{
    self = [super init];
    
    if(self)
    {
        self.maxMatchingCards = maxMatchingCards;
        for(int i = 0; i < count; i++)
        {
            // Initiaize cards array with random cards
           
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            } else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}


-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched)
    {
        if(card.isChosen){
            card.chosen = NO;
        } else {
            // match against another card
            // Logic to match against two cards, goes below
            NSMutableArray *currentChosenCards = [[NSMutableArray alloc] init];
            LoggerApp(4, @"otherCards = %d, self.maxMatchingCards = %d", currentChosenCards.count, self.maxMatchingCards);
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    [currentChosenCards addObject:otherCard]; // Add otherCard of Card Obj to Array
                    LoggerApp(4, @"Card added to array");
                    LoggerApp(4, @"maxMatchingCards %d", self.maxMatchingCards);
                }
            }
            /* To implement 2 or 3 card matching, it is simply by putting
             * maxMathincCards to 2 or 3, then that gets matched to the array
             * otherCards.count
             */
            if([currentChosenCards count] == self.maxMatchingCards -1)
            {
                LoggerApp(4, @"otherCards = %d, self.maxMatchingCards = %d", currentChosenCards.count, self.maxMatchingCards);
                
                int matchScore = [card match:currentChosenCards];
                LoggerApp(4, @"matchScore %d", matchScore);
                if(matchScore)
                {
                    self.score += matchScore * MATCH_BONUS;
                    
                    for(Card *otherCard in currentChosenCards)
                    {
                        otherCard.matched = YES;
                        LoggerApp(4, @"Card was matched :)");
                    }
                    
                    card.matched = YES;
                    
                } else
                {
                    self.score -= MISMATCH_PENALTY;
                    for(Card *otherCard in currentChosenCards)
                    {
                        otherCard.chosen = NO;
                        LoggerApp(4, @"Card was not matched!");
                    }

                }

            }
    
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }

}

- (Card *)cardAtIndex:(NSUInteger)index
{
     // If true put ? self.cards[index] : otherwise nil
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init
{
    return nil;
}

@end
