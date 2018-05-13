
#ifndef CGAdditions_h
#define CGAdditions_h

#include <math.h>
#include <CoreGraphics/CoreGraphics.h>

CGFloat DegreesToRadians(CGFloat degrees);
CGFloat RadiansToDegrees(CGFloat radians);

CGFloat CGFloatDistanceBetweenPoints(CGPoint p1, CGPoint p2);
CGFloat CGPointATan2(CGPoint p1, CGPoint p2);
CGPoint CGPointAddPoints(CGPoint p1, CGPoint p2);
CGPoint CGPointSubtractPoints(CGPoint p1, CGPoint p2);

#endif
