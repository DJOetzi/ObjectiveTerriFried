#ifndef TRACELOG
        #define TRACELOG(level, ...)    printf(__VA_ARGS__)
#endif

#import "include/SaveManager.hpp"

#include <cstdlib>
#include <cstdio>
#include <raylib.h>

@implementation SaveManager : NSObject
    + (std::string) getStorageDataFile {
        return "storage.data";
    }

    + (unsigned char*) loadFileData : (const char *)fileName andDataSize: (int *)dataSize {
        unsigned char *data = NULL;
            *dataSize = 0;

            if (fileName != NULL)
            {
                FILE *file = fopen(fileName, "rb");

                if (file != NULL)
                {
                    // WARNING: On binary streams SEEK_END could not be found,
                    // using fseek() and ftell() could not work in some (rare) cases
                    fseek(file, 0, SEEK_END);
                    long size = ftell(file);
                    fseek(file, 0, SEEK_SET);

                    if (size > 0)
                    {
                        data = (unsigned char *)RL_MALLOC(size*sizeof(unsigned char));

                        // NOTE: fread() returns number of read elements instead of bytes, so we read [1 byte, size elements]
                        unsigned int count = (unsigned int)fread(data, sizeof(unsigned char), size, file);
                        *dataSize = count;

                        if (count != size) TRACELOG(LOG_WARNING, "FILEIO: [%s] File partially loaded", fileName);
                        else TRACELOG(LOG_INFO, "FILEIO: [%s] File loaded successfully", fileName);
                    }
                    else TRACELOG(LOG_WARNING, "FILEIO: [%s] Failed to read file", fileName);

                    fclose(file);
                }
                else TRACELOG(LOG_WARNING, "FILEIO: [%s] Failed to open file", fileName);
            }
            else TRACELOG(LOG_WARNING, "FILEIO: File name provided is not valid");

            return data;
    }

    + (bool) saveStorageValue:(unsigned int)position andValue:(int)value {
        bool success = false;
        int dataSize = 0;
        unsigned int newDataSize = 0;
        unsigned char *fileData = [SaveManager loadFileData:[SaveManager getStorageDataFile].c_str() andDataSize:&dataSize];
        unsigned char *newFileData = NULL;

        if (fileData != NULL)
        {
            if (dataSize <= (position*sizeof(int)))
            {
                // Increase data size up to position and store value
                newDataSize = (position + 1)*sizeof(int);
                newFileData = (unsigned char *)RL_REALLOC(fileData, newDataSize);

                if (newFileData != NULL)
                {
                    // RL_REALLOC succeded
                    int *dataPtr = (int *)newFileData;
                    dataPtr[position] = value;
                }
                else
                {
                    // RL_REALLOC failed
                    TraceLog(LOG_WARNING, "FILEIO: [%s] Failed to realloc data (%u), position in bytes (%u) bigger than actual file size", [SaveManager getStorageDataFile].c_str(), dataSize, position*sizeof(int));

                    // We store the old size of the file
                    newFileData = fileData;
                    newDataSize = dataSize;
                }
            }
            else
            {
                // Store the old size of the file
                newFileData = fileData;
                newDataSize = dataSize;

                // Replace value on selected position
                int *dataPtr = (int *)newFileData;
                dataPtr[position] = value;
            }

            success = SaveFileData([SaveManager getStorageDataFile].c_str(), newFileData, newDataSize);
            RL_FREE(newFileData);

            TraceLog(LOG_INFO, "FILEIO: [%s] Saved storage value: %i", [SaveManager getStorageDataFile].c_str(), value);
        }
        else
        {
            TraceLog(LOG_INFO, "FILEIO: [%s] File created successfully", [SaveManager getStorageDataFile].c_str());

            dataSize = (position + 1)*sizeof(int);
            fileData = (unsigned char *)RL_MALLOC(dataSize);
            int *dataPtr = (int *)fileData;
            dataPtr[position] = value;

            success = SaveFileData([SaveManager getStorageDataFile].c_str(), fileData, dataSize);
            UnloadFileData(fileData);

            TraceLog(LOG_INFO, "FILEIO: [%s] Saved storage value: %i", [SaveManager getStorageDataFile].c_str(), value);
        }

        return success;
    }

    + (int) loadStorageValue : (unsigned int) position {
        int value = 0;
        int dataSize = 0;
        unsigned char *fileData = LoadFileData([SaveManager getStorageDataFile].c_str(), &dataSize);

        if (fileData != NULL)
        {
            if (dataSize < ((int)(position*4))) TraceLog(LOG_WARNING, "FILEIO: [%s] Failed to find storage position: %i", [SaveManager getStorageDataFile].c_str(), position);
            else
            {
                int *dataPtr = (int *)fileData;
                value = dataPtr[position];
            }

            UnloadFileData(fileData);

            TraceLog(LOG_INFO, "FILEIO: [%s] Loaded storage value: %i", [SaveManager getStorageDataFile].c_str(), value);
        }

        return value;
    }
@end
