#import <Foundation/Foundation.h>
#include <raylib.h>

#import "engine/include/Platform.hpp"
#import "engine/include/Player.hpp"
#import "engine/include/ScoreManager.hpp"

#import "engine/utility/include/Constants.hpp"
#import "engine/utility/include/SaveManager.hpp"
#include "engine/utility/include/Utility.hpp"

#import "engine/wrappers/include/NSEngineTexture2D.hpp"
#import "engine/wrappers/include/NSEngineSound.hpp"
#import "engine/wrappers/include/NSEngineFont.hpp"
#import "engine/wrappers/include/NSEngineImage.hpp"

bool titleScreen = true, playCoinFX = false;

auto resetGame(ScoreManager*, std::vector<Platform*>&, Player*) -> void;

auto main(int argc, const char* argv[]) -> int {
    TraceLog(LOG_DEBUG, ("Current Assets Directory: " + std::string(GetWorkingDirectory()) + "/resources").c_str());
    srand((unsigned)time(NULL));
    
    
    InitWindow([Constants SCREEN_WIDTH], [Constants SCREEN_HEIGHT], "TerriFried");
    InitAudioDevice();

    @autoreleasepool {
        id<NSEngineResource> playerSprite =     [[NSEngineTexture2D alloc] initWithPath:"resources/egg.png"];
        id<NSEngineResource> lavaSprite =       [[NSEngineTexture2D alloc] initWithPath:"resources/lava.png"];
        id<NSEngineResource> platformSprite =   [[NSEngineTexture2D alloc] initWithPath:"resources/platform.png"];
        id<NSEngineResource> coinSprite =       [[NSEngineTexture2D alloc] initWithPath:"resources/coin.png"];
        id<NSEngineResource> scoreBoxSprite =   [[NSEngineTexture2D alloc] initWithPath:"resources/scorebox.png"];
        id<NSEngineResource> logo =             [[NSEngineTexture2D alloc] initWithPath:"resources/logo.png"];
        id<NSEngineResource> splashEggSprite =  [[NSEngineTexture2D alloc] initWithPath:"resources/splash_egg.png"];
        
        id<NSEngineResource> fxLaunch =         [[NSEngineSound alloc] initWithPath:"resources/launch.wav"];
        id<NSEngineResource> fxClick =          [[NSEngineSound alloc] initWithPath:"resources/click.wav"];
        id<NSEngineResource> fxDeath =          [[NSEngineSound alloc] initWithPath:"resources/die.wav"];
        id<NSEngineResource> fxCoin =           [[NSEngineSound alloc] initWithPath:"resources/coin.wav"];
        id<NSEngineResource> fxSplash =         [[NSEngineSound alloc] initWithPath:"resources/splash.wav"];
        id<NSEngineResource> fxSelect =         [[NSEngineSound alloc] initWithPath:"resources/select.wav"];
        
        id<NSEngineResource> font =             [[NSEngineFont alloc] initWithPathEx:"resources/font.otf" andFontSize:64 andCodePoints:{}];
        
        id<NSEngineResource> egg =              [[NSEngineImage alloc] initWithPath:"resources/egg.png"];
        
        std::vector<Platform*> platforms = {
            [[Platform alloc] initWithIndex:0],
            [[Platform alloc] initWithIndex:1],
            [[Platform alloc] initWithIndex:2],
            [[Platform alloc] initWithIndex:3]
        };
        
        // to port: [platforms[0] getX] + [platforms[0] getWidth]/2 - 26/2, [platforms[0] getY] - [player getHeight], 26, 32
        Player* player = [
            [Player alloc]
            initWithParams: [platforms[0] getX] + [platforms[0] getWidth]/2.0 - 26/2.0
            andYinit:       [platforms[0] getY] - 32
            andWidthinit:   26
            andHeightinit:  32
        ];
        
        ScoreManager* scoreMan = [[ScoreManager alloc] init];
        [scoreMan setHighscoreInt: [SaveManager loadStorageValue:0]];
        [scoreMan resetScore];
        
        int mouseDownX = 0;
        int mouseDownY = 0;
        double lavaY = [Constants SCREEN_HEIGHT] - 32;
        double timer = 0;
        double splashTimer = 0;
        bool firstTime = true;
        bool playedSplash = false;
        bool playedSelect = false;
        
        SetWindowIcon(*(Image*)[egg getResource]);
        SetMasterVolume(0.3f);

        SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
        //--------------------------------------------------------------------------------------
        

        // Main game loop
        while (!WindowShouldClose())    // Detect window close button or ESC key
        {
            // Draw
            //----------------------------------------------------------------------------------
            if(titleScreen) {
                if(splashTimer > 120) {
                    if(!playedSelect) {
                        PlaySound(*(Sound*)[fxSelect getResource]);
                        playedSelect = true;
                    }
                    
                    BeginDrawing();
                    {
                        ClearBackground(ColorFromNormalized((Vector4){0.933, 0.894, 0.882, 1.0}));
                        //ClearBackground(ColorFromNormalized(utility::buildRGBA(.933, .894, .882, 1.0)));
                        
                        DrawTexture(*(Texture2D*)[logo getResource], [Constants SCREEN_WIDTH]/4.0, [Constants SCREEN_HEIGHT]/2.0 - 45.0 - 30.0, WHITE);
                        DrawTextEx(*(Font*)[font getResource], [scoreMan getHighscoreText].c_str(), utility::buildVector2([Constants SCREEN_WIDTH]/2.0 - 37.0, [Constants SCREEN_HEIGHT]/2.0 + 10), 32, 0, BLACK);
                        DrawTextEx(*(Font*)[font getResource], "CLICK ANYWHERE TO BEGIN", utility::buildVector2([Constants SCREEN_WIDTH]/2.0 - 134.0, [Constants SCREEN_HEIGHT]/2.0 + 10), 32, 0, /*ColorFromNormalized(utility::buildRGBA(.698, .588, .49, 0.4))*/ColorFromNormalized((Vector4){.698, .588, .49, 0.4}));
                    }
                    EndDrawing();
                    
                    if(IsMouseButtonDown(MOUSE_LEFT_BUTTON)) {
                        PlaySound(*(Sound*)[fxSelect getResource]);
                        titleScreen = false;
                        mouseDownX = GetMouseX();
                        mouseDownY = GetMouseY();
                    }
                }
                else {
                    if(!playedSplash) {
                        PlaySound(*(Sound*)[fxSplash getResource]);
                        playedSplash = true;
                    }
                    
                    BeginDrawing();
                    {
                        ClearBackground(ColorFromNormalized((Vector4){0.933, 0.894, 0.882, 1.0}));
                        //ClearBackground(ColorFromNormalized(utility::buildRGBA(.933, .894, .882, 1.0)));
                        DrawTextEx(*(Font*)[font getResource], "POLYMARS", utility::buildVector2([Constants SCREEN_WIDTH]/2.0 - 54.0, [Constants SCREEN_HEIGHT]/2.0 + 3.0), 32, 0, ColorFromNormalized((Vector4){.835, .502, .353, 1.0}));
                        DrawTexture(*(Texture2D*)[splashEggSprite getResource], [Constants SCREEN_WIDTH]/2.0 - 16.0, [Constants SCREEN_HEIGHT]/2.0 - 16.0 - 23.0, WHITE);
                    }
                    EndDrawing();
                    ++splashTimer;
                }
            }
            else {
                if(playCoinFX) {
                    PlaySound(*(Sound*)[fxCoin getResource]);
                    playCoinFX = false;
                }
                
                if(IsMouseButtonPressed(MOUSE_LEFT_BUTTON) && [player isGrounded]) {
                    PlaySound(*(Sound*)[fxClick getResource]);
                    mouseDownX = GetMouseX();
                    mouseDownY = GetMouseY();
                }
                
                if(IsMouseButtonReleased(MOUSE_LEFT_BUTTON) && [player isGrounded]) {
                    if(firstTime)
                        firstTime = false;
                    else {
                        PlaySound(*(Sound*)[fxLaunch getResource]);
                        
                        if([player onPlatform])
                            [player setY:[player getY]-1.0];
                        
                        [player setVelocity:utility::buildVector2((GetMouseX() - mouseDownX)*.08, (GetMouseY() - mouseDownY)*.08)];
                    }
                }
                
                [player checkPlayerCollision:platforms andScoreManager:scoreMan andPlayCoinFX:playCoinFX];
                [player updatePosition];
                
                if([player getY] > [Constants SCREEN_HEIGHT]) {
                    PlaySound(*(Sound*)[fxDeath getResource]);
                    resetGame(scoreMan, platforms, player);
                }
                
                for(int i=0; i<4; i++)
                    [platforms[i] updatePosition];
                
                lavaY = [Constants SCREEN_HEIGHT] - 32 - sin(timer) * 5;
                timer += .05;
                
                BeginDrawing();
                {
                    ClearBackground(ColorFromNormalized((Vector4){0.933, 0.894, 0.882, 1.0}));
                    //ClearBackground(ColorFromNormalized(utility::buildRGBA(.933, .894, .882, 1.0)));
                    if(IsMouseButtonDown(MOUSE_LEFT_BUTTON) && [player isGrounded]) {
                        DrawLineEx(
                                   utility::buildVector2(
                                                         mouseDownX+([player getX] - mouseDownX) + ([player getWidth]/2.0),
                                                         (mouseDownY + ([player getY] - mouseDownY) + ([player getHeight]/2.0))
                                   ),
                                   utility::buildVector2(
                                                         GetMouseX() + ([player getX] - mouseDownX) + ([player getWidth]/2.0),
                                                         GetMouseY() + ([player getY] - mouseDownY) + ([player getHeight]/2.0)
                                   ),
                                   3.0,
                                   ColorFromNormalized((Vector4){.698, .588, .49, 1.0})
                        );
                    }
                    
                    for(int i=0; i<4; i++) {
                        DrawTexture(*(Texture2D*)[platformSprite getResource], [platforms[i] getX], [platforms[i] getY], /*ColorFromNormalized(utility::buildRGBA(.698, .588, .49, 1.0))*/ColorFromNormalized((Vector4){.698, .588, .49, 1.0}));
                        
                        if([platforms[i] hasCoin])
                            DrawTexture(*(Texture2D*)[coinSprite getResource], [platforms[i] getCoinPos].x, [platforms[i] getCoinPos].y, WHITE);
                    }
                    
                    DrawTexture(*(Texture2D*)[playerSprite getResource], [player getX], [player getY], WHITE);
                    DrawTexture(*(Texture2D*)[lavaSprite getResource], 0, lavaY, WHITE);
                    DrawTexture(*(Texture2D*)[scoreBoxSprite getResource], 17, 17, WHITE);
                    
                    DrawTextEx(*(Font*)[font getResource], [scoreMan score].c_str(), utility::buildVector2(28, 20), 64, 0, BLACK);
                    DrawTextEx(*(Font*)[font getResource], [scoreMan highscore].c_str(), utility::buildVector2(17, 90), 32, 0, BLACK);
                }
                EndDrawing();
            }
            //----------------------------------------------------------------------------------
        }
        
        
        CloseAudioDevice();     // Close Miniaudio Context
        CloseWindow();          // Close window and OpenGL context
        //--------------------------------------------------------------------------------------
    }
    
    return 0;
}

auto resetGame(ScoreManager* scoreMan, std::vector<Platform*>& platforms, Player* player) -> void {
    [scoreMan resetScore];
    
    for(int i=0; i<4; i++)
        platforms[i] = [[Platform alloc] initWithIndex:i];
    
    [player setVelocity:utility::buildVector2(0,0)];
    [player setX:[platforms[0] getX] + [platforms[0] getWidth]/2.0 - 26.0/2.0];
    [player setY:[platforms[0] getY] - [player getHeight]];
}
