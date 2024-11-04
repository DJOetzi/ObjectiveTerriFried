//
//  Player.m
//  ObjectiveTerriFried
//
//  Created by Maximilian Gabriel on 04.11.24.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "utility/utility.h"

@implementation Player
    - (id) init {
        if ( self = [super init] ) {
            self.x = 0;
            self.y = 0;
            
            self.width = 0;
            self.height = 0;
            self.onPlatform = 0;
            self.velocity = buildVector2(0, 0);
        }
        return self;
    }

    - (id) initWithParams : (double)xinit andYinit : (double)yinit andWidthinit : (int) widthinit andHeightinit : (int) heightinit andOnPlatforminit : (bool) onPlatforminit andVelocity : (Vector2) velocityinit {
        if ( self = [super init] ) {
            self.x = xinit;
            self.y = yinit;
            
            self.width = widthinit;
            self.height = heightinit;
            self.onPlatform = onPlatforminit;
            self.velocity = velocityinit;
        }
        return self;
    }

    - (double)  getX {
        return self.x;
    }
    
    - (double)  getY {
        return self.y;
    }
    
    - (int)     getWidth {
        return self.width;
    }

    - (int)     getHeight {
        return self.height;
    }

    - (bool)    getOnPlatform {
        return self.onPlatform;
    }
    
    - (Vector2) getVelocity {
        return self.velocity;
    }
@end
