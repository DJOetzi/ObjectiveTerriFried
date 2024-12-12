#pragma once

#import <Foundation/Foundation.h>
#include <raylib.h>

@interface Platform : NSObject
    {
        double x;
        double y;
        int width;
        int height;
        bool coinState;
        Vector2 coinPos;
    }
    // constructors
    - (id) initWithIndex : (int)index;
    
    // getters
    - (double)  getX;
    - (double)  getY;
    - (int)     getWidth;
    - (int)     getHeight;
    - (bool)    hasCoin;
    - (Vector2) getCoinPos;

    // setters
    - (void)    setX        : (double)xinit;
    - (void)    setY        : (double)yinit;
    - (void)    setWidth    : (int)widthinit;
    - (void)    setHeight   : (int)heightinit;
    - (void)    setHasCoin  : (bool)coininit;
    - (void)    setCoinPos  : (Vector2)coinPosinit;

    // misc methods
    - (void)    updatePosition;
@end;
