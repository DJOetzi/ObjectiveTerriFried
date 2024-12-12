#import "include/Player.hpp"
#include "utility/include/Utility.hpp"
#import "utility/include/Constants.hpp"

@implementation Player

    // constructors
    - (id) init {
        if ( self = [super init] ) {
            x = 0;
            y = 0;
            
            width = 0;
            height = 0;
            onPlatform = 0;
            velocity = utility::buildVector2(0, 0);
        }
        return self;
    }

    - (id) initWithParams : (double)xinit andYinit : (double)yinit andWidthinit : (int) widthinit andHeightinit : (int) heightinit {
        if ( self = [super init] ) {
            x = xinit;
            y = yinit;
            
            width = widthinit;
            height = heightinit;
            //onPlatform = onPlatforminit;
            //velocity = velocityinit;
        }
        return self;
    }

    // getters
    - (double) getX {
        return x;
    }
    
    - (double) getY {
        return y;
    }
    
    - (int) getWidth {
        return width;
    }

    - (int) getHeight {
        return height;
    }

    - (bool) getOnPlatform {
        return onPlatform;
    }
    
    - (Vector2) getVelocity {
        return velocity;
    }

    // setters
    - (void) setX : (double)xinit {
        x = xinit;
    }
    
    - (void) setY : (double)yinit {
        y = yinit;
    }

    - (void) setWidth : (int)widthinit {
        width = widthinit;
    }

    - (void) setHeight : (int)heightinit {
        height = heightinit;
    }

    - (void) setOnPlatform : (bool)onPlatforminit {
        onPlatform = onPlatforminit;
    }

    - (void) setVelocity : (Vector2)velocityinit {
        velocity = velocityinit;
    }

    // misc methods
    - (bool) isGrounded {
        return [self getOnPlatform];
    }

    - (void) updatePosition {
        x += velocity.x;
        y += velocity.y;
        
        if (![self isGrounded])
            velocity = utility::buildVector2(velocity.x, velocity.y + [Constants GRAVITY]);
        else
            velocity = utility::buildVector2(0, 0);
        
        if (x < 0)
            velocity = utility::buildVector2(-velocity.x, velocity.y);
        
        if (x + width > 800)
            velocity = utility::buildVector2(-velocity.x, velocity.y);
    }

    - (void) checkPlayerCollision : (std::vector<Platform*>&) platforms andScoreManager : (ScoreManager*)scoreMan andPlayCoinFX : (bool&) playCoinFX {
        bool currOnPlatform = false;
        //TraceLog(LOGWARNING, "CHECK PLAYER COLLISION - START");
        
        for(int i=0; i<4; i++) {
            //TraceLog(LOGWARNING, std::tostring([platforms[i] getX]).cstr());
            //TraceLog(LOGWARNING, std::tostring([platforms[i] getY]).cstr());
            
            //TraceLog(LOGWARNING, (std::tostring([self getY] + [self getHeight]) + "<" + std::tostring([platforms[i] getY] + [platforms[i] getHeight])).cstr());
            
            if ([platforms[i] hasCoin] && [self getX] + [self getWidth] - 3 > [platforms[i] getCoinPos].x && [self getX] + 3 < [platforms[i] getCoinPos].x + 24 && [self getY] + [self getHeight] - 3 > [platforms[i] getCoinPos].y && [self getY] + 3 < [platforms[i] getCoinPos].y + 24)
            {
                [scoreMan addScore : 1];
                [platforms[i] setHasCoin : false];
                playCoinFX = true;
            }
            
            if ([self getX] + 1 < [platforms[i] getX] + [platforms[i] getWidth] && [self getX] + [self getWidth] > [platforms[i] getX] && [self getY] + [self getHeight] >= [platforms[i] getY] && [self getY] < [platforms[i] getY] + [platforms[i] getHeight])
            {
                if ([self getY] > [platforms[i] getY] + [platforms[i] getHeight]/2.0)
                {
                    [self setVelocity : utility::buildVector2([self getVelocity].x, 5)];
                }
                else if ([self getY] + [self getHeight] < [platforms[i] getY] + [platforms[i] getHeight])
                {
                    //TraceLog(LOGWARNING, "CHECK PLAYER COLLISION - DETECTION!");

                    currOnPlatform = true;
                    [self setY:[platforms[i] getY] - [self getHeight]];
                    [self setY:[self getY] + 1];
                }
            }
        }
        
        [self setOnPlatform : currOnPlatform];
        //TraceLog(LOGWARNING, onPlatform?"true":"false");
        //TraceLog(LOGWARNING, "CHECK PLAYER COLLISION - END");
    }
@end
