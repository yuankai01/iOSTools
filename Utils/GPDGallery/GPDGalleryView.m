//
//  GPDGalleryView.m
//  ThumbPicturesDemo
//
//  Created by Jason Hu on 12-8-6.
//  Copyright (c) 2012年 Magic Point. All rights reserved.
//

#import "GPDGalleryView.h"

@implementation GPDGalleryView
@synthesize photos=_photos;
@synthesize scrollView=_scrollView;
@synthesize thumbArray=_thumbArray;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        NSMutableArray *oneArray=[[NSMutableArray alloc] init];
        self.thumbArray=oneArray;
        [oneArray release];
    }
    return self;
}
 
-(void)setPhotos:(NSArray *)photos
{
    if (_photos != photos) {
        [_photos release];
        [photos retain];
        _photos = photos;
    }//此处的属性不加self，否则回引起嵌套
    [self loadThumbArray];
//    [self performThumbPictures];
}

- (void)dealloc
{
    if (_thumbArray) {
        [_thumbArray release];
        _thumbArray = nil;
    }
    if (_scrollView) {
        [_scrollView release];
        _scrollView = nil;
    }
    if (_photos) {
        [_photos release];
        _photos = nil;
    }
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)loadThumbArray
{
    UIScrollView *oneScrollView=[[UIScrollView alloc]init];//初始化底层UIScrollView
    self.scrollView=oneScrollView;
    [oneScrollView release];
    self.scrollView.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);//scrollView的布局大小
    self.scrollView.backgroundColor=[UIColor whiteColor];
    
    UIButton *oneImageButton;
    for (int i=0; i<self.photos.count; i++) {
        MWPhoto *onePhoto=(MWPhoto*)[self.photos objectAtIndex:i];
        NSString *pictureName=onePhoto.thumbName;
        oneImageButton=[UIButton buttonWithType:UIButtonTypeCustom];
        oneImageButton.tag=i;

        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docu=[paths objectAtIndex:0];
        NSString *thePath=[docu stringByAppendingPathComponent:pictureName];

        UIImage *buttonImage=[UIImage imageWithContentsOfFile:thePath];
        [oneImageButton setImage:buttonImage forState:UIControlStateNormal];
        [oneImageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:oneImageButton];
        [self.thumbArray addObject:oneImageButton];
    }
    [self addSubview:self.scrollView];
}

-(void)performThumbPicturesForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
//    NSLog(@"orientation: %i",orientation);
    int viewWidth=self.bounds.size.width;//绘图区域的宽
//    int viewHeight=self.bounds.size.height;//绘图区域的高
    self.scrollView.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    int edgeTop;//顶边距
    int edgeLeft;//左边距
    int spacerColumn;//列距
    int spacerRow;//行距
    int rectWidth;//缩略图宽
    int rectHeight;//缩略图高
    int rectY;//缩略图的Y坐标
    int columnCount;//列数
    if (([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPhone)) {//iPhone布局
        edgeTop=10;
        edgeLeft=10;
        spacerColumn=10;
        spacerRow=8;
        rectY=edgeTop;
        columnCount=2;
        rectWidth=(viewWidth-edgeLeft*2-spacerColumn*(columnCount-1))/columnCount;//145;
        rectHeight=107;
    }
    else {
        if (UIInterfaceOrientationIsPortrait(orientation)) {//iPad纵向布局
            edgeTop=35;
            edgeLeft=25;
            spacerColumn=14;
            spacerRow=10;
            rectWidth=230;
            rectHeight=170;
            rectY=edgeTop;
            columnCount=3;
        }
        else {//iPad横向布局
            edgeTop=35;
            edgeLeft=25;
            spacerColumn=18;
            spacerRow=10;
            rectWidth=230;
            rectHeight=170;
            rectY=edgeTop;
            columnCount=4;
        }
    }
    int rowCount=self.photos.count/columnCount;//行数
    if (self.photos.count%columnCount!=0) {
        rowCount+=1;
    }
    int pictureIndex=0;
    int mainHeight=edgeTop*3+rectHeight*rowCount+spacerRow*(rowCount-1);//总视图高
    self.scrollView.contentSize=CGSizeMake(self.bounds.size.width, (mainHeight>(self.bounds.size.height+1))?mainHeight:(self.bounds.size.height+1));//scrollView的内容页大小
//    NSLog(@"mainHeight: %i",mainHeight);
//    NSLog(@"self.bounds.size.height: %f",self.bounds.size.height);
//    NSLog(@"self.scrollView.contentSize: %f",self.scrollView.contentSize.height);
//    NSLog(@"self.scrollView.frame.size.height: %f",self.scrollView.frame.size.height);
//    NSLog(@"self.bounds.size.width: %f",self.bounds.size.width);
    UIButton *oneImageButton;
    for (int i=0; i<rowCount; i++) {//遍历所有行
        int rectX=0;//每行起始处，将X坐标归零
        rectX+=edgeLeft;
        rectY+=spacerRow;
        for (int j=0; j<columnCount; j++) {//遍历单行中的列
            oneImageButton=(UIButton*)[self.thumbArray objectAtIndex:pictureIndex];
            oneImageButton.frame=CGRectMake(rectX, rectY, rectWidth, rectHeight);
            rectX+=rectWidth;
            rectX+=spacerColumn;
            if ((pictureIndex+1)==self.photos.count) {
                break;
            }
            pictureIndex++;
        }
        rectY+=rectHeight;
    }
}

-(void)imageButtonPressed:(UIButton*)sender
{
    if ([_delegate respondsToSelector:@selector(galleryImageButtonMethod:)]) {
        [_delegate galleryImageButtonMethod:sender];
    }
}

@end
