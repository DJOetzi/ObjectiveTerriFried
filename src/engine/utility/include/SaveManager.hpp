#pragma once

#import <Foundation/Foundation.h>
#include <iostream>

@interface SaveManager : NSObject
    + (std::string)     getStorageDataFile;
    + (unsigned char*)  loadFileData        : (const char*) fileName andDataSize : (int*) dataSize;
    + (bool)            saveStorageValue    : (unsigned int) position andValue : (int) value;
    + (int)             loadStorageValue    : (unsigned int) position;
@end
