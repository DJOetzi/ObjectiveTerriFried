#pragma once

#import <Foundation/Foundation.h>
#include <raylib.h>

@interface Platform : NSObject
    @property (nonatomic) double x;
    @property (nonatomic) double y;
    @property (nonatomic) int width;
    @property (nonatomic) int height;
    @property (nonatomic) bool coinState;
    @property (nonatomic) Vector2 coinPos;

    // constructors
    - (id) init;
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
    - (void)    setCoinPos  : (Vector2)coinposinit;

    // misc methods
    - (void)    updatePosition;
@end;
