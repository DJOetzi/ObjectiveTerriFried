#pragma once

#import <Foundation/Foundation.h>
#import "../Protocols/NSEngineResource.hpp"

#include <iostream>
#include <raylib.h>

@interface NSEngineTexture2D : NSObject <NSEngineResource>
    {
        Texture2D rawTex;
    }

    // Constructors
    - (id) initWithPath : (std::string) path;

    // Destructor
    - (void) dealloc;

    // methods
    - (void* const) getResource;
@end
