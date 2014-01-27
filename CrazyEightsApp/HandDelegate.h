//
//  HandDelegate.h
//  CrazyEightsApp
//
//  Created by Jeremy on 1/27/14.
//  Copyright (c) 2014 Jeremy-Walton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPWPlayingCard;

@protocol HandDelegate <NSObject>

- (void)didSelectCard:(JPWPlayingCard *)card;

@end
