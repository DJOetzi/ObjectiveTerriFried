#import "include/NSImage.hpp"

#include <raylib.h>

@implementation NSImage : NSObject
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            _rawImg = LoadImage(path.c_str());
        }
        return self;
    }

    - (void) dealloc {
        UnloadImage(_rawImg);
    }

    - (void* const) getResource {
        return &_rawImg;
    }
@end
