#import "include/NSEngineFont.hpp"

#include <raylib.h>

@implementation NSEngineFont : NSObject
    // Constructors
    - (id) initWithPath : (std::string) path {
        if ( self = [super init] ) {
            _rawFont = LoadFont(path.c_str());
        }
        return self;
    }

    - (id) initWithPathEx : (std::string) path andFontSize : (int) fontSize andCodePoints : (std::vector<int>) codepoints {
        if ( self = [super init] ) {
            _rawFont = LoadFontEx(path.c_str(), fontSize, codepoints.data(), (int)codepoints.size());
        }
        return self;
    }

    // Destructor
    - (void) dealloc {
        UnloadFont(_rawFont);
    }

    // methods
    - (void* const) getResource {
        return &_rawFont;
    }
@end

