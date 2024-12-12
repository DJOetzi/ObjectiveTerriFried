#import "include/NSEngineSound.hpp"

#include <raylib.h>

@implementation NSEngineSound : NSObject
    // Constructors
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            rawSound = LoadSound(path.c_str());
        }
        return self;
    }

    // Destructor
    - (void) dealloc {
        UnloadSound(rawSound);
    }

    // methods
    - (void* const) getResource {
        return &rawSound;
    }
@end
