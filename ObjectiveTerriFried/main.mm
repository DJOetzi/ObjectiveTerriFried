#import <Foundation/Foundation.h>
#include <raylib.h>

#import "engine/include/Platform.hpp"
#import "engine/include/Player.hpp"
#import "engine/include/ScoreManager.hpp"
#import "engine/utility/include/Constants.hpp"
#import "engine/utility/include/SaveManager.hpp"
#import "engine/wrappers/include/NSTexture2D.hpp"


auto main(int argc, const char* argv[]) -> int {
    TraceLog(LOG_DEBUG, ("Current Assets Directory: " + std::string(GetWorkingDirectory()) + "/resources").c_str());
    srand((unsigned)time(NULL));
    
    
    InitWindow([Constants SCREEN_WIDTH], [Constants SCREEN_HEIGHT], "TerriFried");
    InitAudioDevice();
    
    Sound fxLaunch = LoadSound("resources/launch.wav");
    Sound fxClick = LoadSound("resources/click.wav");
    Sound fxDeath = LoadSound("resources/die.wav");
    Sound fxCoin = LoadSound("resources/coin.wav");
    Sound fxSplash = LoadSound("resources/splash.wav");
    Sound fxSelect = LoadSound("resources/select.wav");
    
    Font font = LoadFontEx("resources/font.otf", 64, 0, NULL);
    
    Image egg = LoadImage("resources/egg.png");
    
    @autoreleasepool {
        NSTexture2D* playerSprite =     [[NSTexture2D alloc] initWithPath:"resources/egg.png"];
        NSTexture2D* lavaSprite =       [[NSTexture2D alloc] initWithPath:"resources/lava.png"];
        NSTexture2D* platformSprite =   [[NSTexture2D alloc] initWithPath:"resources/platform.png"];
        NSTexture2D* coinSprite =       [[NSTexture2D alloc] initWithPath:"resources/coin.png"];
        NSTexture2D* scoreBoxSprite =   [[NSTexture2D alloc] initWithPath:"resources/scorebox.png"];
        NSTexture2D* logo =             [[NSTexture2D alloc] initWithPath:"resources/logo.png"];
        NSTexture2D* splashEggSprite =  [[NSTexture2D alloc] initWithPath:"resources/splash_egg.png"];
        
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
