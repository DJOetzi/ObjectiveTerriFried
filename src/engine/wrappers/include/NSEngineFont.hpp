#pragma once

#import <Foundation/Foundation.h>
#import "../Protocols/NSEngineResource.hpp"

#include <iostream>
#include <vector>
#include <raylib.h>

@interface NSEngineFont : NSObject<NSEngineResource>
    {
        Font rawFont;
    }

    // Constructors
    - (id) initWithPath     : (std::string) path;
    - (id) initWithPathEx   : (std::string) path andFontSize : (int) fontSize andCodePoints : (std::vector<int>) codepoints;

    // Destructor
    - (void) dealloc;

    // methods
    - (void* const) getResource;
@end
