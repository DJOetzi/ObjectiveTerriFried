#import "include/NSSound.hpp"

#include <raylib.h>

@implementation NSSound : NSObject
    // Constructors
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            _rawSound = LoadSound(path.c_str());
        }
        return self;
    }

    // Destructor
    - (void) dealloc {
        UnloadSound(_rawSound);
    }

    // methods
    - (void* const) getResource {
        return &_rawSound;
    }
@end
