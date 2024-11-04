#pragma once

#include <raylib.h>

auto buildVector2(int self_x, int self_y) -> Vector2 {
    return Vector2 {static_cast<float>(self_x), static_cast<float>(self_y)};
}
