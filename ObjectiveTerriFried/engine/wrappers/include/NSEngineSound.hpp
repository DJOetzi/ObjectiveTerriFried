#pragma once

#import <Foundation/Foundation.h>
#import "../Protocols/NSEngineResource.hpp"

#include <iostream>
#include <raylib.h>

@interface NSEngineSound : NSObject<NSEngineResource>
    @property (nonatomic) Sound rawSound;

    // Constructors
    - (id) initWithPath : (std::string) path;

    // Destructor
    - (void) dealloc;

    // methods
    - (void* const) getResource;
@end
