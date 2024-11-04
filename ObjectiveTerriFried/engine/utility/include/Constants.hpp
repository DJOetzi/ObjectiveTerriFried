#pragma once

#import <Foundation/Foundation.h>
#include <math.h>
#include <stdio.h>

@interface Constants : NSObject
    + (double)  GET_PI;
    + (int)     GRAVITY;
    + (int)     SCREEN_WIDTH;
    + (int)     SCREEN_HEIGHT;
@end

@implementation Constants
    + (double)  GET_PI {
        return M_PI;
    }
    + (int)     GRAVITY {
        return 1;
    }
    + (int)     SCREEN_WIDTH {
        return 800;
    }
    + (int)     SCREEN_HEIGHT {
        return 450;
    }
@end
