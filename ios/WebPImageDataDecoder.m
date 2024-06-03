#import "WebPImageDataDecoder.h"
#import <SDWebImageWebPCoder/SDWebImageWebPCoder.h>
#import "SDImageAPNGCoder.h"

@implementation WebPImageDataDecoder

RCT_EXPORT_MODULE()
- (BOOL)canDecodeImageData:(NSData *)imageData
{
    return [[SDImageAPNGCoder sharedCoder] canDecodeFromData:imageData] || [[SDImageWebPCoder sharedCoder] canDecodeFromData:imageData];
}
- (RCTImageLoaderCancellationBlock)decodeImageData:(NSData *)imageData
                                              size:(CGSize)size
                                             scale:(CGFloat)scale
                                        resizeMode:(RCTResizeMode)resizeMode
                                 completionHandler:(RCTImageLoaderCompletionBlock)completionHandler
{
    uint8_t c;
    [imageData getBytes:&c length:1];
    UIImage *image = c == 0x89
        ? [[SDImageAPNGCoder sharedCoder] decodedImageWithData:imageData options:nil]
        : [[SDImageWebPCoder sharedCoder] decodedImageWithData:imageData options:nil];
    if (!image) {
      completionHandler(nil, nil);
      return ^{};
    }
    completionHandler(nil, image);
    return ^{};
}
@end
