#import <Foundation/Foundation.h>
#import "include/Platform.hpp"

#include "utility/include/utility.hpp"

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
@end
