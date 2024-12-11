#pragma once

#include <raylib.h>

namespace utility {
    static auto buildVector2(int self_x, int self_y) -> Vector2 {
        return Vector2 {static_cast<float>(self_x), static_cast<float>(self_y)};
    }

    static auto buildRGBA(int self_r, int self_g, int self_b, int self_a) -> Vector4 {
        return Vector4 {static_cast<float>(self_r), static_cast<float>(self_g), static_cast<float>(self_b), static_cast<float>(self_a)};
    }
}
