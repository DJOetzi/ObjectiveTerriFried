#import <Foundation/Foundation.h>
#import "include/Platform.hpp"

#include "utility/include/utility.hpp"
#include "utility/include/Constants.hpp"

@implementation Platform
    // constructors
    - (id) initWithIndex : (int)index {
        if ( self = [super init] ) {
            self.width = 100;
            self.height = 32;
            
            self.x = rand() % 660 + 20;
            self.y = 0 - self.height - (index * 100);
        
            self.hasCoin = (((rand() % 4) == 0 || index == 0) ? false : true);
            self.coinPos = buildVector2(
                                        self.x + self.width/2 - 24/2,
                                        self.y - 24 - 5
                           );
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

    - (bool) hasCoin {
        return self.coinState;
    }

    - (Vector2) getCoinPos {
        return self.coinPos;
    }

    // setters
    - (void) setX : (double)xinit {
        self.x = xinit;
    }

    - (void) setY : (double)yinit {
        self.y = yinit;
    }

    - (void) setWidth:(int)widthinit {
        self.width = widthinit;
    }

    - (void) setHeight : (int)heightinit {
        self.height = heightinit;
    }

    - (void) setHasCoin : (bool)coininit {
        self.coinState = coininit;
    }

    - (void) setCoinPos : (Vector2)coinPosinit {
        self.coinPos = coinPosinit;
    }

    - (void) updatePosition {
        self.y += 1;
        
        self.coinPos = buildVector2(self.x + self.width/2 - 24/2, self.y - 24 - 5);
        
        if (self.y > [Constants SCREEN_HEIGHT]) {
            self.x = rand() % 660 + 20;
            self.y = 0 - self.height;
            
            self.hasCoin = ((rand() % 4 == 0) ? false : true);
        }
    }
@end
