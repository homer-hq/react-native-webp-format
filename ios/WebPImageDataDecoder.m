#import "WebPImageDataDecoder.h"
#import <SDWebImageWebPCoder/SDWebImageWebPCoder.h>
#import "SDImageAPNGCoder.h"
#import <React/RCTAnimatedImage.h>
#import <React/RCTUtils.h>


#import "RCTImagePlugins.h"

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
    
    
//    uint8_t c;
//    [imageData getBytes:&c length:1];
//    if (c == 0x89) {
//        RCTAnimatedImage *image = [[RCTAnimatedImage alloc] initWithData:imageData scale:scale];
//        completionHandler(nil, image);
//        return ^{};
//    }
    
    // Check if the data is an APNG
    UIImage *image;
    if ([[SDImageAPNGCoder sharedCoder] canDecodeFromData:imageData]) {
        image = [[SDImageAPNGCoder sharedCoder] decodedImageWithData:imageData options:nil];
    } else {
        image = [[SDImageWebPCoder sharedCoder] decodedImageWithData:imageData options:nil];
    }
    
    
    if (!image) {
      completionHandler(nil, nil);
      return ^{};
    }
    completionHandler(nil, image);
    return ^{};
}
@end
