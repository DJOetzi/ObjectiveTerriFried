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
@end
