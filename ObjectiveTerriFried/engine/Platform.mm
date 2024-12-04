#import "include/Platform.hpp"
#include "utility/include/Utility.hpp"
#include "utility/include/Constants.hpp"

@implementation Platform
    // constructors
    - (id) initWithIndex : (int)index {
        if ( self = [super init] ) {
            _width = 100;
            _height = 32;
            
            _x = rand() % 660 + 20;
            _y = 0 - _height - (index * 100);
        
            _coinState = (((rand() % 4) == 0 || index == 0) ? false : true);
            _coinPos = buildVector2(
                                        _x + _width/2 - 24/2,
                                        _y - 24 - 5
                           );
        }
        return self;
    }
    
    // getters
    - (double) getX {
        return _x;
    }

    - (double) getY {
        return _y;
    }

    - (int) getWidth {
        return _width;
    }

    - (int) getHeight {
        return _height;
    }

    - (bool) hasCoin {
        return _coinState;
    }

    - (Vector2) getCoinPos {
        return _coinPos;
    }

    // setters
    - (void) setX : (double)xinit {
        _x = xinit;
    }

    - (void) setY : (double)yinit {
        _y = yinit;
    }

    - (void) setWidth:(int)widthinit {
        _width = widthinit;
    }

    - (void) setHeight : (int)heightinit {
        _height = heightinit;
    }

    - (void) setHasCoin : (bool)coininit {
        _coinState = coininit;
    }

    - (void) setCoinPos : (Vector2)coinPosinit {
        _coinPos = coinPosinit;
    }

    - (void) updatePosition {
        _y += 1;
        
        _coinPos = buildVector2(_x + _width/2 - 24/2, _y - 24 - 5);
        
        if (_y > [Constants SCREEN_HEIGHT]) {
            _x = rand() % 660 + 20;
            _y = 0 - _height;
            
            _coinState = ((rand() % 4 == 0) ? false : true);
        }
    }
@end
