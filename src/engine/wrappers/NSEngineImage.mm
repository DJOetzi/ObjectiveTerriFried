#import "include/NSEngineImage.hpp"

#include <raylib.h>

@implementation NSEngineImage : NSObject
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            rawImg = LoadImage(path.c_str());
        }
        return self;
    }

    - (void) dealloc {
        UnloadImage(rawImg);
    }

    - (void* const) getResource {
        return &rawImg;
    }
@end
