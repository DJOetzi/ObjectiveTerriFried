#include <cstdio>
#include <cstdlib>

#import "include/ScoreManager.hpp"
#import "utility/include/SaveManager.hpp"

@implementation ScoreManager : NSObject
    // constructors
    - (id) init {
        if ( self = [super init] ) {
            _scoreInt = 0;
            _highscoreInt = 0;
            _score = "";
            _highscore = "";
        }
        return self;
    }

    // getters
    - (int) getScoreInt {
        return _scoreInt;
    }

    - (int) getHighscoreInt {
        return _highscoreInt;
    }
    - (std::string) getScoreText {
        return _score;
    }
    - (std::string) getHighscoreText {
        return _highscore;
    }

    // setters
    - (void) setScoreInt     :  (int)scoreIntinit {
        _scoreInt = scoreIntinit;
    }
    - (void) setHighscoreInt :  (int)highscoreIntinit {
        _highscoreInt = highscoreIntinit;
    }
    - (void) setHighscore    :  (std::string)highscoreinit {
        _highscore = highscoreinit;
    }
    - (void) setScore        :  (std::string)scoreinit {
        _score = scoreinit;
    }

    // functionality
    - (void) addScore        : (int)amount {
        _scoreInt += amount;
        
        std::string numcache = std::to_string(_scoreInt);
        
        if (_scoreInt < 10) {
            _score = "00" + numcache;
        }
        else if (_scoreInt) {
            _score = "0" + numcache;
        }
        else {
            _score = numcache;
        }
        
        if (_scoreInt > _highscoreInt) {
            _highscoreInt = _scoreInt;
            
            _highscore = "BEST: " + std::to_string(_highscoreInt);
        }
    }

    - (void) resetScore {
        _scoreInt = 0;
        _score = "00" + std::to_string(_scoreInt);
        [SaveManager saveStorageValue:0 andValue:_highscoreInt];
    }
@end

