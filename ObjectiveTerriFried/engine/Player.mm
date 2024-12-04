#import "Player.hpp"
#include "utility/include/Utility.hpp"
#import "utility/include/Constants.hpp"

@implementation Player

    // constructors
    - (id) init {
        if ( self = [super init] ) {
            _x = 0;
            _y = 0;
            
            _width = 0;
            _height = 0;
            _onPlatform = 0;
            _velocity = buildVector2(0, 0);
        }
        return self;
    }

    - (id) initWithParams : (double)xinit andYinit : (double)yinit andWidthinit : (int) widthinit andHeightinit : (int) heightinit {
        if ( self = [super init] ) {
            _x = xinit;
            _y = yinit;
            
            _width = widthinit;
            _height = heightinit;
            //_onPlatform = onPlatforminit;
            //_velocity = velocityinit;
        }
        return self;
    }

    // getters
    - (double) getX {
        return _x;
    }
    
    - (double) getY {
        return _y;
    }
    
    - (int) getWidth {
        return _width;
    }

    - (int) getHeight {
        return _height;
    }

    - (bool) getOnPlatform {
        return _onPlatform;
    }
    
    - (Vector2) getVelocity {
        return _velocity;
    }

    // setters
    - (void) setX : (double)xinit {
        _x = xinit;
    }
    
    - (void) setY : (double)yinit {
        _y = yinit;
    }

    - (void) setWidth : (int)widthinit {
        _width = widthinit;
    }

    - (void) setHeight : (int)heightinit {
        _height = heightinit;
    }

    - (void) setOnPlatform : (bool)onPlatforminit {
        _onPlatform = onPlatforminit;
    }

    - (void) setVelocity : (Vector2)velocityinit {
        _velocity = velocityinit;
    }

    // misc methods
    - (bool) isGrounded {
        return [self getOnPlatform];
    }

    - (void) updatePosition {
        _x += _velocity.x;
        _y += _velocity.y;
        
        if (![self isGrounded])
            _velocity = buildVector2(_velocity.x, _velocity.y + [Constants GRAVITY]);
        else
            _velocity = buildVector2(0, 0);
        
        if (_x < 0)
            _velocity = buildVector2(-_velocity.x, _velocity.y);
        
        if (_x + _width > 800)
            _velocity = buildVector2(-_velocity.x, _velocity.y);
    }

    - (void) checkPlayerCollision : (Platform**) platforms andScoreManager : (ScoreManager*)scoreMan andPlayCoinFX : (bool&) playCoinFX {
        bool onPlatform = false;
        
        for(int i=0; i<4; i++) {
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
                    [self setVelocity : buildVector2([self getVelocity].x, 5)];
                }
                else if ([self getY] + [self getHeight] <  [platforms[i] getY] + [platforms[i] getHeight])
                {
                    onPlatform = true;
                    [self setHeight:[platforms[i] getY] - [self getHeight]];
                    [self setY:[self getY] + 1];
                }
            }
        }
        
        [self setOnPlatform : onPlatform];
    }
@end
