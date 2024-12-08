#pragma once

#import <Foundation/Foundation.h>
#import "../Protocols/NSEngineResource.hpp"

#include <iostream>
#include <raylib.h>

@interface NSEngineImage : NSObject <NSEngineResource>
    @property (nonatomic) Image rawImg;

    // Constructors
    - (id) initWithPath : (std::string) path;

    // Destructor
    - (void) dealloc;

    // methods
    - (void* const) getResource;
@end
