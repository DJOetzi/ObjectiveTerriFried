#pragma once

#import <Foundation/Foundation.h>
#include <vector>
#include <raylib.h>

#import "Platform.hpp"
#import "ScoreManager.hpp"

@interface Player : NSObject
    {
        double x;
        double y;

        int width;
        int height;

        bool onPlatform;
        Vector2 velocity;
    }

    // constructors
    - (id) init;
    - (id) initWithParams : (double)xinit andYinit : (double) yinit andWidthinit : (int) widthinit andHeightinit : (int) heightinit;

    // getters
    - (double)  getX;
    - (double)  getY;
    - (int)     getWidth;   
    - (int)     getHeight;
    - (bool)    getOnPlatform;
    - (Vector2) getVelocity;

    // setters
    - (void) setX                   : (double)   xinit;
    - (void) setY                   : (double)   yinit;
    - (void) setWidth               : (int)      widthinit;
    - (void) setHeight              : (int)      heightinit;
    - (void) setOnPlatform          : (bool)     onPlatforminit;
    - (void) setVelocity            : (Vector2)  velocityinit;

    // misc methods
    - (bool) isGrounded;
    - (void) updatePosition;
    - (void) checkPlayerCollision   : (std::vector<Platform*>&) platforms andScoreManager : (ScoreManager*)scoreMan andPlayCoinFX : (bool&) playCoinFX;
@end
