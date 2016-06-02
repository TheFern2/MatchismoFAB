//
//  Card.h
//  Matchismo
//
//  Created by Fernando Balandran on 5/26/16.
//  Copyright © 2016 Fernando Balandran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
