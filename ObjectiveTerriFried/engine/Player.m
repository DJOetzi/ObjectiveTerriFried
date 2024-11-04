//
//  Player.m
//  ObjectiveTerriFried
//
//  Created by Maximilian Gabriel on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "player.h"

@implementation Player
    - (id) init {
        if ( self = [super init] ) {
            self.x = 0;
            self.y = 0;
            
            self.width = 0;
            self.height = 0;
            self.onPlatform = 0;
            self.velocity = (Vector2){ .x = 0, .y = 0};
        }
        return self;
    }
@end
