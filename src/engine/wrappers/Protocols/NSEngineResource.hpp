#pragma once

#import <Foundation/Foundation.h>
#include <iostream>

@protocol NSEngineResource
    // Constructors
    - (id) initWithPath : (std::string) path;

    // Destructor
    - (void) dealloc;

    // methods
    - (void* const) getResource;
@end
