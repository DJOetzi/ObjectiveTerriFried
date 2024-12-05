#import "include/NSTexture2D.hpp"

#include <raylib.h>

@implementation NSTexture2D : NSObject
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            _rawTex = LoadTexture(path.c_str());
        }
        return self;
    }

    - (void) dealloc {
        UnloadTexture(_rawTex);
    }

    - (Texture2D&) getTexture {
        return _rawTex;
    }
@end
