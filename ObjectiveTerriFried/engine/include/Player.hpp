#pragma once

#import <Foundation/Foundation.h>
#include <raylib.h>

@interface Player : NSObject
    @property (nonatomic) double x;
    @property (nonatomic) double y;

    @property (nonatomic) int width;
    @property (nonatomic) int height;

    @property (nonatomic) bool onPlatform;
    @property (nonatomic) Vector2 velocity;

    // constructors
    - (id) init;
    - (id) initWithParams : (double)xinit andYinit : (double)yinit andWidthinit : (int) widthinit andHeightinit : (int) heightinit;

    // getters
    - (double)  getX;
    - (double)  getY;
    - (int)     getWidth;   
    - (int)     getHeight;
    - (bool)    getOnPlatform;
    - (Vector2) getVelocity;

    // setters
    - (void) setX          : (double)   xinit;
    - (void) setY          : (double)   yinit;
    - (void) setWidth      : (int)      widthinit;
    - (void) setHeight     : (int)      heightinit;
    - (void) setOnPlatform : (bool)     onPlatforminit;
    - (void) setVelocity   : (Vector2)  velocityinit;

    // misc methods
    - (bool) isGrounded;
    - (void) updatePosition;
@end
