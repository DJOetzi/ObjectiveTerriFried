#pragma once

#import <Foundation/Foundation.h>
#include <raylib.h>
#include <iostream>


@interface ScoreManager : NSObject
    @property (nonatomic) int scoreInt;
    @property (nonatomic) int highscoreInt;
    @property (nonatomic) std::string score;
    @property (nonatomic) std::string highscore;

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
@end
