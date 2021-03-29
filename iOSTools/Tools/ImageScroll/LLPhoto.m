//
//  LLPhoto.m
//  LLPhotoBrowser
//
//  Created by zhaomengWang on 17/2/6.
//  Copyright © 2017年 MaoChao Network Co. Ltd. All rights reserved.
//

#import "LLPhoto.h"

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface LLPhoto ()<UIScrollViewDelegate>{
    UIImageView *_imageView;
    UIImage     *_currentImage;
    NSMutableArray *_images;
    CGFloat     _totalTime;
}
@end

@implementation LLPhoto

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.minimumZoomScale = MinScale;
        self.maximumZoomScale = MaxSCale;
        self.backgroundColor  = [UIColor blackColor];
        _images = [[NSMutableArray alloc] initWithCapacity:1];
        
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
        
        UITapGestureRecognizer *singleClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick:)];
        [self addGestureRecognizer:singleClick];
        
        UITapGestureRecognizer *doubleClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
        doubleClick.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleClick];
        
        [singleClick requireGestureRecognizerToFail:doubleClick];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.delegate = self;
    self.minimumZoomScale = MinScale;
    self.maximumZoomScale = MaxSCale;
    self.backgroundColor  = [UIColor blackColor];
    
    _images = [[NSMutableArray alloc] initWithCapacity:1];
    
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    
    UITapGestureRecognizer *singleClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClick:)];
    [self addGestureRecognizer:singleClick];
    
    UITapGestureRecognizer *doubleClick = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick:)];
    doubleClick.numberOfTapsRequired = 2;
    [self addGestureRecognizer:doubleClick];
    
    [singleClick requireGestureRecognizerToFail:doubleClick];
}

#pragma mark - 设置当前显示的图片
- (void)setLl_image:(id)ll_image {
    
    if (_images.count > 1) {
        _totalTime = 0;
        [_imageView stopAnimating];
        [_images removeAllObjects];
    }
    
    _ll_image = ll_image;
    _imageView.image = nil;
    
    if ([ll_image isKindOfClass:[UIImage class]]) {
        _currentImage = (UIImage *)ll_image;
        [self layoutImageView];
    }
    else if ([ll_image isKindOfClass:[NSString class]]) {
        [self setPath:(NSString *)ll_image];
    }
}

//根据路径/网址加载图片
- (void)setPath:(NSString *)path {
    
    NSURL *URL = [NSURL URLWithString:path];
    if (URL == nil) {
        URL = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if ([path rangeOfString:@"http"].location != NSNotFound) {
        [_imageView sd_setImageWithURL:URL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                _currentImage = image;
                [self layoutImageView];
            }
        }];
    }else{
        UIImage *image = [UIImage imageNamed:path];
        if (image) {
            _imageView.image = image;
            _currentImage = image;
            [self layoutImageView];
        }
    }
    
}

//自适应图片的宽高比
- (void)layoutImageView {
    CGRect imageFrame;
    if (_currentImage.size.width > self.bounds.size.width || _currentImage.size.height > self.bounds.size.height) {
        CGFloat imageRatio = _currentImage.size.width/_currentImage.size.height;
        CGFloat photoRatio = kScreenWidth/kScreenHeight;
        
        if (imageRatio > photoRatio) {
            imageFrame.size = CGSizeMake(kScreenWidth, kScreenWidth/_currentImage.size.width*_currentImage.size.height);
            imageFrame.origin.x = 0;
            imageFrame.origin.y = (kScreenHeight-imageFrame.size.height)/2.0;
        }
        else {
            imageFrame.size = CGSizeMake(kScreenHeight/_currentImage.size.height*_currentImage.size.width, kScreenHeight);
            imageFrame.origin.x = (kScreenWidth-imageFrame.size.width)/2.0;
            imageFrame.origin.y = 0;
        }
    }
    else {
        imageFrame.size = _currentImage.size;
        imageFrame.origin.x = (kScreenWidth-_currentImage.size.width)/2.0;
        imageFrame.origin.y = (kScreenHeight-_currentImage.size.height)/2.0;
    }
    _imageView.frame = imageFrame;
    _imageView.image = _currentImage;
    if (_images.count > 1) {
        [_imageView setAnimationImages:_images];
        [_imageView setAnimationDuration:_totalTime];
        [_imageView setAnimationRepeatCount:LONG_MAX];
        [_imageView startAnimating];
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat offsetX = (kScreenWidth>self.contentSize.width)?(kScreenWidth-self.contentSize.width)*0.5:0.0;
    CGFloat offsetY = (kScreenHeight>self.contentSize.height)?(kScreenHeight-self.contentSize.height)*0.5:0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width*0.5+offsetX, scrollView.contentSize.height*0.5+offsetY);
}

#pragma mark - 手势交互
//单击
- (void)singleClick:(UITapGestureRecognizer *)gestureRecognizer {
    if ([self.ll_delegate respondsToSelector:@selector(singleClickWithPhoto:)]) {
        [self.ll_delegate singleClickWithPhoto:self];
    }
    else {
        [self removeFromSuperview];
    }
}

//双击
- (void)doubleClick:(UITapGestureRecognizer *)gestureRecognizer {
    
    if (self.zoomScale > MinScale) {
        [self setZoomScale:MinScale animated:YES];
    } else {
        CGPoint touchPoint = [gestureRecognizer locationInView:_imageView];
        CGFloat newZoomScale = self.maximumZoomScale;
        CGFloat xsize = self.frame.size.width/newZoomScale;
        CGFloat ysize = self.frame.size.height/newZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x-xsize/2, touchPoint.y-ysize/2, xsize, ysize) animated:YES];
    }
}

- (void)dealloc {
    NSLog(@"释放");
}

@end
