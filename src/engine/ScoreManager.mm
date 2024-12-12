#include <cstdio>
#include <cstdlib>

#import "include/ScoreManager.hpp"
#import "utility/include/SaveManager.hpp"

@implementation ScoreManager : NSObject
    // constructors
    - (id) init {
        if ( self = [super init] ) {
            scoreInt = 0;
            highscoreInt = 0;
            score = "";
            highscore = "";
        }
        return self;
    }

    // getters
    - (int) getScoreInt {
        return scoreInt;
    }

    - (int) getHighscoreInt {
        return highscoreInt;
    }
    - (std::string) getScoreText {
        return score;
    }
    - (std::string) getHighscoreText {
        return highscore;
    }

    // setters
    - (void) setScoreInt     :  (int)scoreIntinit {
        scoreInt = scoreIntinit;
    }
    - (void) setHighscoreInt :  (int)highscoreIntinit {
        highscoreInt = highscoreIntinit;
    }
    - (void) setHighscore    :  (std::string)highscoreinit {
        highscore = highscoreinit;
    }
    - (void) setScore        :  (std::string)scoreinit {
        score = scoreinit;
    }

    // functionality
    - (void) addScore        : (int)amount {
        scoreInt += amount;
        
        std::string numcache = std::to_string(scoreInt);
        
        if (scoreInt < 10) {
            score = "00" + numcache;
        }
        else if (scoreInt) {
            score = "0" + numcache;
        }
        else {
            score = numcache;
        }
        
        if (scoreInt > highscoreInt) {
            highscoreInt = scoreInt;
            
            highscore = "BEST: " + std::to_string(highscoreInt);
        }
    }

    - (void) resetScore {
        scoreInt = 0;
        score = "00" + std::to_string(scoreInt);
        [SaveManager saveStorageValue:0 andValue:highscoreInt];
    }
@end

