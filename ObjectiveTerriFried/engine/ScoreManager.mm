#import "include/ScoreManager.hpp"

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
    - (void) addScore        : (int)amount;
@end

