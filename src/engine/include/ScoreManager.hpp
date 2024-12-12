#pragma once

#import <Foundation/Foundation.h>
#include <raylib.h>
#include <iostream>


@interface ScoreManager : NSObject
    {
        int scoreInt;
        int highscoreInt;
        std::string score;
        std::string highscore;
    }

    // constructors
    - (id) init;

    // getters
    - (int)         getScoreInt;
    - (int)         getHighscoreInt;
    - (std::string) getScoreText;
    - (std::string) getHighscoreText;

    // setters
    - (void) setScoreInt     :  (int)scoreIntinit;
    - (void) setHighscoreInt :  (int)highscoreIntinit;
    - (void) setHighscore    :  (std::string)highscoreinit;
    - (void) setScore        :  (std::string)scoreinit;

    // functionality
    - (void) addScore        : (int)amount;
    - (void) resetScore;
@end
