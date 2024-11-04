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
    - (id) initWithParams : (double)xinit ();
@end
