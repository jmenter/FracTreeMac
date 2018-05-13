
#import "NSImageView+Extras.h"

@implementation NSImageView (Extras)

- (void)setTintColor:(NSColor *)tintColor;
{
    NSImage *tintedImage = self.image.copy;
    [tintedImage lockFocus];
    [tintColor set];
    NSRectFillUsingOperation(NSMakeRect(0, 0, self.image.size.width, self.image.size.height), NSCompositingOperationSourceAtop);
    [tintedImage unlockFocus];
    self.image = tintedImage;
}

@end
