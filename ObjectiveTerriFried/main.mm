#import <Foundation/Foundation.h>
#include <raylib.h>

#import "engine/include/Platform.hpp"
#import "engine/include/Player.hpp"
#import "engine/include/ScoreManager.hpp"
#import "engine/utility/include/Constants.hpp"
#import "engine/utility/include/SaveManager.hpp"
#import "engine/wrappers/include/NSTexture2D.hpp"
#import "engine/wrappers/include/NSSound.hpp"


auto main(int argc, const char* argv[]) -> int {
    TraceLog(LOG_DEBUG, ("Current Assets Directory: " + std::string(GetWorkingDirectory()) + "/resources").c_str());
    srand((unsigned)time(NULL));
    
    
    InitWindow([Constants SCREEN_WIDTH], [Constants SCREEN_HEIGHT], "TerriFried");
    InitAudioDevice();

    
    Font font = LoadFontEx("resources/font.otf", 64, 0, NULL);
    
    Image egg = LoadImage("resources/egg.png");
    
    @autoreleasepool {
        id<NSEngineResource> playerSprite =     [[NSTexture2D alloc] initWithPath:"resources/egg.png"];
        id<NSEngineResource> lavaSprite =       [[NSTexture2D alloc] initWithPath:"resources/lava.png"];
        id<NSEngineResource> platformSprite =   [[NSTexture2D alloc] initWithPath:"resources/platform.png"];
        id<NSEngineResource> coinSprite =       [[NSTexture2D alloc] initWithPath:"resources/coin.png"];
        id<NSEngineResource> scoreBoxSprite =   [[NSTexture2D alloc] initWithPath:"resources/scorebox.png"];
        id<NSEngineResource> logo =             [[NSTexture2D alloc] initWithPath:"resources/logo.png"];
        id<NSEngineResource> splashEggSprite =  [[NSTexture2D alloc] initWithPath:"resources/splash_egg.png"];
        
        id<NSEngineResource> fxLaunch =         [[NSSound alloc] initWithPath:"resources/launch.wav"];
        id<NSEngineResource> fxClick =          [[NSSound alloc] initWithPath:"resources/click.wav"];
        id<NSEngineResource> fxDeath =          [[NSSound alloc] initWithPath:"resources/die.wav"];
        id<NSEngineResource> fxCoin =           [[NSSound alloc] initWithPath:"resources/coin.wav"];
        id<NSEngineResource> fxSplash =         [[NSSound alloc] initWithPath:"resources/splash.wav"];
        id<NSEngineResource> fxSelect =         [[NSSound alloc] initWithPath:"resources/select.wav"];
        
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
        
        SetWindowIcon(egg);
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
        
        // De-Initialization
        //--------------------------------------------------------------------------------------
        UnloadSound(fxClick);
        UnloadSound(fxLaunch);
        UnloadSound(fxDeath);
        UnloadSound(fxCoin);
        UnloadSound(fxSplash);
        UnloadSound(fxSelect);
        UnloadFont(font);
        
        CloseAudioDevice(); // Close Miniaudio Context
        CloseWindow();        // Close window and OpenGL context
        //--------------------------------------------------------------------------------------
    }
    
    return 0;
}
