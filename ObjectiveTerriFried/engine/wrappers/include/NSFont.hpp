#pragma once

#import <Foundation/Foundation.h>
#import "../Protocols/NSEngineResource.hpp"

#include <iostream>
#include <raylib.h>

@interface NSFont : NSObject<NSEngineResource>
    @property (nonatomic) Font rawFont;

    // Constructors
    - (id) initWithPath     : (std::string) path;
    - (id) initWithPathEx   : (std::string) path andFontSize : (int) fontSize andCodePoints : (std::vector<int>) codepoints;

    // Destructor
    - (void) dealloc;

    // methods
    - (void* const) getResource;
@end
