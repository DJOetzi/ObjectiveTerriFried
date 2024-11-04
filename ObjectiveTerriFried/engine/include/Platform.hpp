#pragma once

#import <Foundation/Foundation.h>
#include <raylib.h>

@interface Platform : NSObject
    @property (nonatomic) double x;
    @property (nonatomic) double y;
    @property (nonatomic) int width;
    @property (nonatomic) int height;
    @property (nonatomic) bool hasCoin;
    @property (nonatomic) Vector2 coinPos;

    // constructors
    - (id) init;
    - (id) initWithIndex : (int)index;
    
    // getters
    
@end;
