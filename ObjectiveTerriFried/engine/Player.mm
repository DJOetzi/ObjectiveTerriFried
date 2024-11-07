#import <Foundation/Foundation.h>
#import "Player.hpp"
#include "utility/include/utility.hpp"
#import "utility/include/Constants.hpp"

@implementation Player

    // constructors
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

    - (id) initWithParams : (double)xinit andYinit : (double)yinit andWidthinit : (int) widthinit andHeightinit : (int) heightinit {
        if ( self = [super init] ) {
            self.x = xinit;
            self.y = yinit;
            
            self.width = widthinit;
            self.height = heightinit;
            //self.onPlatform = onPlatforminit;
            //self.velocity = velocityinit;
        }
        return self;
    }

    // getters
    - (double) getX {
        return self.x;
    }
    
    - (double) getY {
        return self.y;
    }
    
    - (int) getWidth {
        return self.width;
    }

    - (int) getHeight {
        return self.height;
    }

    - (bool) getOnPlatform {
        return self.onPlatform;
    }
    
    - (Vector2) getVelocity {
        return self.velocity;
    }

    // setters
    - (void) setX : (double)xinit {
        self.x = xinit;
    }
    
    - (void) setY : (double)yinit {
        self.y = yinit;
    }

    - (void) setWidth : (int)widthinit {
        self.width = widthinit;
    }

    - (void) setHeight : (int)heightinit {
        self.height = heightinit;
    }

    - (void) setOnPlatform : (bool)onPlatforminit {
        self.onPlatform = onPlatforminit;
    }

    - (void) setVelocity : (Vector2)velocityinit {
        self.velocity = velocityinit;
    }

    // misc methods
    - (bool) isGrounded {
        return [self getOnPlatform];
    }

    - (void) updatePosition {
        self.x += self.velocity.x;
        self.y += self.velocity.y;
        
        if (![self isGrounded])
            self.velocity = buildVector2(self.velocity.x, self.velocity.y + [Constants GRAVITY]);
        else
            self.velocity = buildVector2(0, 0);
        
        if (self.x < 0)
            self.velocity = buildVector2(-self.velocity.x, self.velocity.y);
        
        if (self.x + self.width > 800)
            self.velocity = buildVector2(-self.velocity.x, self.velocity.y);
    }

@end
