#import "include/Platform.hpp"
#include "utility/include/Utility.hpp"
#include "utility/include/Constants.hpp"

@implementation Platform
    // constructors
    - (id) initWithIndex : (int)index {
        if ( self = [super init] ) {
            width = 100;
            height = 32;
            
            x = rand() % 660 + 20;
            y = 0 - height - (index * 100);
        
            coinState = (((rand() % 4) == 0 || index == 0) ? false : true);
            coinPos = utility::buildVector2(
                                        x + width/2 - 24/2,
                                        y - 24 - 5
                           );
        }
        return self;
    }
    
    // getters
    - (double) getX {
        return x;
    }

    - (double) getY {
        return y;
    }

    - (int) getWidth {
        return width;
    }

    - (int) getHeight {
        return height;
    }

    - (bool) hasCoin {
        return coinState;
    }

    - (Vector2) getCoinPos {
        return coinPos;
    }

    // setters
    - (void) setX : (double)xinit {
        x = xinit;
    }

    - (void) setY : (double)yinit {
        y = yinit;
    }

    - (void) setWidth:(int)widthinit {
        width = widthinit;
    }

    - (void) setHeight : (int)heightinit {
        height = heightinit;
    }

    - (void) setHasCoin : (bool)coininit {
        coinState = coininit;
    }

    - (void) setCoinPos : (Vector2)coinPosinit {
        coinPos = coinPosinit;
    }

    - (void) updatePosition {
        y += 1;
        
        coinPos = utility::buildVector2(x + width/2.0 - 24/2.0, y - 24.0 - 5);
        
        if (y > [Constants SCREEN_HEIGHT]) {
            x = rand() % 660 + 20;
            y = 0 - height;
            
            coinState = rand() % 4 != 0;
        }
    }
@end
