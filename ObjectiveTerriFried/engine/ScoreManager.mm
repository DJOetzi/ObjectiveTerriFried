#include <cstdio>
#include <raylib.h>
#include <cstdlib>

#import "include/ScoreManager.hpp"
#import "utility/include/SaveManager.hpp"

@implementation ScoreManager : NSObject
    // constructors
    - (id) init {
        if ( self = [super init] ) {
            self.scoreInt = 0;
            self.highscoreInt = 0;
            self.score = "";
            self.highscore = "";
        }
        return self;
    }

    // getters
    - (int) getScoreInt {
        return self.scoreInt;
    }

    - (int) getHighscoreInt {
        return self.highscoreInt;
    }
    - (std::string) getScoreText {
        return self.score;
    }
    - (std::string) getHighscoreText {
        return self.highscore;
    }

    // setters
    - (void) setScoreInt     :  (int)scoreIntinit {
        self.scoreInt = scoreIntinit;
    }
    - (void) setHighscoreInt :  (int)highscoreIntinit {
        self.highscoreInt = highscoreIntinit;
    }
    - (void) setHighscore    :  (std::string)highscoreinit {
        self.highscore = highscoreinit;
    }
    - (void) setScore        :  (std::string)scoreinit {
        self.score = scoreinit;
    }

    // functionality
    - (void) addScore        : (int)amount {
        self.scoreInt += amount;
        
        std::string numcache = std::to_string(self.scoreInt);
        
        if (self.scoreInt < 10) {
            self.score = "00" + numcache;
        }
        else if (self.scoreInt) {
            self.score = "0" + numcache;
        }
        else {
            self.score = numcache;
        }
        
        if (self.scoreInt > self.highscoreInt) {
            self.highscoreInt = self.scoreInt;
            
            self.highscore = "BEST: " + std::to_string(self.highscoreInt);
        }
    }

    - (void) resetScore {
        self.scoreInt = 0;
        self.score = "00" + std::to_string(self.scoreInt);
        [SaveManager saveStorageValue:0 andValue:self.highscoreInt];
    }
@end

