
#include "CGAdditions.h"

CGFloat DegreesToRadians(CGFloat degrees) {
    return degrees * M_PI / 180.f;
}

CGFloat RadiansToDegrees(CGFloat radians) {
    return radians * 180.f / M_PI;
}

CGFloat CGFloatDistanceBetweenPoints(CGPoint p1, CGPoint p2) {
    return sqrt((p2.x - p1.x) * (p2.x - p1.x) + (p2.y - p1.y) * (p2.y - p1.y));
}

CGFloat CGPointATan2(CGPoint p1, CGPoint p2) {
    return atan2(p1.x - p2.x, p1.y - p2.y);
}

CGPoint CGPointAddPoints(CGPoint p1, CGPoint p2) {
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

CGPoint CGPointSubtractPoints(CGPoint p1, CGPoint p2) {
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

