#import "include/NSEngineTexture2D.hpp"

#include <raylib.h>

@implementation NSEngineTexture2D : NSObject
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            rawTex = LoadTexture(path.c_str());
        }
        return self;
    }

    - (void) dealloc {
        UnloadTexture(rawTex);
    }

    - (void* const) getResource {
        return &rawTex;
    }
@end
