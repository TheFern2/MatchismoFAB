//
//  ViewController.m
//  Matchismo
//
//  Created by Fernando Balandran on 5/24/16.
//  Copyright © 2016 Fernando Balandran. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "NSLogger.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *masterCard;
@property (nonatomic) int flipCount;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelector;
@property (nonatomic) NSInteger maxMatchingCards;
@end

// Will show all card content during game - useful for testing game logic
static const BOOL CARD_CONTENT_CHEAT = YES;

@implementation ViewController

- (void)resetGame
{
    self.game = nil;
    [self updateUI];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
}

- (CardMatchingGame *)game
{
    if(!_game){
 
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                                 usingCards:self.maxMatchingCards];

        [self changeModeSelector:self.modeSelector];
    }
    return _game;
    
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Additional setup after loading the view
    LoggerStart(LoggerGetDefaultLogger()); // Starts NSLogger after view is launched
    LoggerApp(4, @"App started");
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

// Card being disabled when clicked again
- (void)updateUI
{
    for(UIButton *cardButton in self.cardButtons)
    {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle: [self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    if (CARD_CONTENT_CHEAT) {
        return card.contents;
    } else {
        return card.isChosen ? card.contents : @"";
    }
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    // If card is chosen put ? frontCard : otherwise backCard
    // return [UIImage imageNamed:card.isChosen ? @"frontCard" : @"backCard"];
    
    if (CARD_CONTENT_CHEAT) {
        return [UIImage imageNamed:@"frontCard"];
    } else {
        return [UIImage imageNamed:card.chosen ? @"frontCard" : @"backCard"];
    }
}


- (IBAction)resetGameBtn{
    
    LoggerApp(4, @"Reset button pressed");
    
    // Add alert controller
    UIAlertController *resetAlert = [UIAlertController
                                     alertControllerWithTitle:@"Reset Game"
                                     message:@"Do you want to reset game?"
                                     preferredStyle:UIAlertControllerStyleAlert];
    // Add button actions
    UIAlertAction *resetAction = [UIAlertAction
                                  actionWithTitle:@"Reset"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action){
                                      
        LoggerApp(4, @"Reset action");
        [resetAlert dismissViewControllerAnimated:YES completion:nil];
                                      [self resetGame];
                                      
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action){
    
        LoggerApp(4, @"Cancel action");
        [resetAlert dismissViewControllerAnimated:YES completion:nil];
                                       
    }];
    
    // Add actions to UIAlertController view, and present alert
    [resetAlert addAction:resetAction];
    [resetAlert addAction:cancelAction];
    [self presentViewController:resetAlert animated:YES completion:nil];
}

- (IBAction)changeModeSelector:(UISegmentedControl *)sender
{
    self.maxMatchingCards = [[sender titleForSegmentAtIndex:sender.selectedSegmentIndex] integerValue];
    LoggerApp(4, @"maxMatchingCards value %d", self.maxMatchingCards);
}


@end
