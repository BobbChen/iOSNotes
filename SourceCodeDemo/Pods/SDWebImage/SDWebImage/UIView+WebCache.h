/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageCompat.h"

#if SD_UIKIT || SD_MAC

#import "SDWebImageManager.h"

typedef void(^SDSetImageBlock)(UIImage * _Nullable image, NSData * _Nullable imageData);

@interface UIView (WebCache)

/**
 * 获取当前的图片下载地址.
 *
 * Note that because of the limitations of categories this property can get out of sync
 * if you use setImage: directly.
 */
- (nullable NSURL *)sd_imageURL;

/**
 * Set the imageView `image` with an `url` and optionally a placeholder image.
 *
 * 图片的下载是异步并且具有缓存的功能
 *
 * @param url            图片下载地址.
 * @param placeholder    占位图.
 * @param options        下载图片过程中的可操作功能. 在 SDWebImageOptions   可以看到可用的功能
 * @param operationKey   operation的操作关键字，没有的话默认是类名
 * @param setImageBlock  自定义设置图片
 * @param progressBlock  下载过程的回调，回调是在异步队列中完成
 * @param completedBlock 下载完成的回调，无返回值第一个参数:image.第二个：error 第三个是一个判断图像从URL现在还是从缓存中获取的布尔值，第四个是图像的url
  */
- (void)sd_internalSetImageWithURL:(nullable NSURL *)url
                  placeholderImage:(nullable UIImage *)placeholder
                           options:(SDWebImageOptions)options
                      operationKey:(nullable NSString *)operationKey
                     setImageBlock:(nullable SDSetImageBlock)setImageBlock
                          progress:(nullable SDWebImageDownloaderProgressBlock)progressBlock
                         completed:(nullable SDExternalCompletionBlock)completedBlock;

/**
 * 取消当前的下载
 */
- (void)sd_cancelCurrentImageLoad;

#if SD_UIKIT

#pragma mark - 活动指示器部分

/**
 *  Show activity UIActivityIndicatorView
 */
- (void)sd_setShowActivityIndicatorView:(BOOL)show;

/**
 *  set desired UIActivityIndicatorViewStyle
 *
 *  @param style The style of the UIActivityIndicatorView
 */
- (void)sd_setIndicatorStyle:(UIActivityIndicatorViewStyle)style;

- (BOOL)sd_showActivityIndicatorView;
- (void)sd_addActivityIndicator;
- (void)sd_removeActivityIndicator;

#endif

@end

#endif
