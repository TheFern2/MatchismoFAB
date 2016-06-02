//
//  Deck.h
//  Matchismo
//
//  Created by Fernando Balandran on 5/26/16.
//  Copyright © 2016 Fernando Balandran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
