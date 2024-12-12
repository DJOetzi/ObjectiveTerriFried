#import "include/NSEngineFont.hpp"

#include <raylib.h>
#include <vector>

@implementation NSEngineFont : NSObject
    // Constructors
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            rawFont = LoadFont(path.c_str());
        }
        return self;
    }

    - (id) initWithPathEx   : (std::string) path andFontSize : (int) fontSize andCodePoints : (std::vector<int>) codepoints {
        if ( self = [super init] ) {
            rawFont = LoadFontEx(path.c_str(), fontSize, codepoints.data(), codepoints.size());
        }
        return self;
    }

    // Destructor
    - (void) dealloc {
        UnloadFont(rawFont);
    }

    // methods
    - (void* const) getResource {
        return &rawFont;
    }
@end

