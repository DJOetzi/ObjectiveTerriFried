#import <Foundation/Foundation.h>
#include <raylib.h>

#import "engine/include/Platform.hpp"
#import "engine/include/Player.hpp"

Platform* platforms[4] = {
    [[Platform alloc] initWithIndex:1],
    
};

// to port: [platforms[0] getX] + [platforms[0] getWidth]/2 - 26/2, [platforms[0] getY] - [player getHeight], 26, 32
Player* player [[Player alloc] initWithParams:<#(double)#> andYinit:<#(double)#> andWidthinit:<#(int)#> andHeightinit:<#(int)#> andOnPlatforminit:<#(bool)#> andVelocity:<#(Vector2)#>];

auto main(int argc, const char * argv[]) -> int {
    const int screenWidth = 800;
    const int screenHeight = 450;
    
    srand((unsigned)time(NULL));
    
    @autoreleasepool {
        InitWindow(screenWidth, screenHeight, "TerriFried");

        SetTargetFPS(60);               // Set our game to run at 60 frames-per-second
        //--------------------------------------------------------------------------------------

        // Main game loop
        while (!WindowShouldClose())    // Detect window close button or ESC key
        {
            // Update
            //----------------------------------------------------------------------------------
            // TODO: Update your variables here
            //----------------------------------------------------------------------------------

            // Draw
            //----------------------------------------------------------------------------------
            BeginDrawing();

                ClearBackground(RAYWHITE);

                DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

            EndDrawing();
            //----------------------------------------------------------------------------------
        }

        // De-Initialization
        //--------------------------------------------------------------------------------------
        CloseWindow();        // Close window and OpenGL context
        //--------------------------------------------------------------------------------------
    }
    
    return 0;
}
