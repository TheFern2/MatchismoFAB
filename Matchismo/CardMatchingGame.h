//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Fernando Balandran on 5/27/16.
//  Copyright © 2016 Fernando Balandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;


- (instancetype)initWithCardCount:(NSUInteger)count usingDeck: (Deck *)deck;  // Designated initializer
-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@end
