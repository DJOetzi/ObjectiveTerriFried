#pragma once

#include <raylib.h>

Vector2 buildVector2(int self_x, int self_y) {
    return (Vector2){ .x = self_x, .y = self_y};
}
