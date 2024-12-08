#import "include/NSEngineTexture2D.hpp"

#include <raylib.h>

@implementation NSEngineTexture2D : NSObject
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            _rawTex = LoadTexture(path.c_str());
        }
        return self;
    }

    - (void) dealloc {
        UnloadTexture(_rawTex);
    }

    - (void* const) getResource {
        return &_rawTex;
    }
@end
