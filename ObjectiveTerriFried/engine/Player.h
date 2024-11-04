//
//  player.h
//  ObjectiveTerriFried
//
//  Created by Maximilian Gabriel on 04.11.24.
//

#import <Foundation/Foundation.h>
#include <raylib.h>

@interface Player : NSObject
    @property double x;
    @property double y;
    
    @property int width;
    @property int height;
    
    @property bool onPlatform;
    @property Vector2 velocity;

    - (id) init;
    - (id) initWithParams : (double)xinit andYinit : (double)yinit andWidthinit : (int) widthinit andOnPlatforminit : (bool) onPlatforminit andVelocity : (Vector2) velocityinit;

    - (double)  getX;
    - (double)  getY;
    - (int)     getWidth;
    - (int)     getHeight;
    - (bool)    getOnPlatform;
    - (Vector2) getVelocity;

    - (void) setX          : (double)x;
    - (void) setY          : (double)y;
    - (void) setWidth      : (int)width;
    - (void) setHeight     : (int)height;
    - (void) setOnPlatform : (bool)onPlatform;
    - (void) setVelocity   : (Vector2)velocity;
@end
