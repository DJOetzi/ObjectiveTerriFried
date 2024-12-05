#pragma once

#import <Foundation/Foundation.h>

#include <iostream>
#include <raylib.h>

@interface NSTexture2D : NSObject
    @property (nonatomic) Texture2D rawTex;

    // Constructors
    - (id) initWithPath : (std::string)path;

    // Destructor
    - (void) dealloc;

    // methods
    - (Texture2D&) getTexture;
@end
