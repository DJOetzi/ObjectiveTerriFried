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
        
        id<NSEngineResource> egg =            [[NSEngineImage alloc] initWithPath:"resources/egg.png"];
        
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
            BeginDrawing();
            {
                ClearBackground(RAYWHITE);

                DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);
            }
            EndDrawing();
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
    
    [player setVelocity:buildVector2(0,0)];
    [player setX:[platforms[0] getX] + [platforms[0] getWidth]/2.0 - 26/2.0];
    [player setY:[platforms[0] getY] + [player getHeight]];
}
