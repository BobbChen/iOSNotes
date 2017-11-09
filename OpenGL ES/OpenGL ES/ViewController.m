//
//  ViewController.m
//  OpenGL ES
//
//  Created by 侨品汇 on 2017/11/9.
//  Copyright © 2017年 陈博. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>

@interface ViewController ()
@property (nonatomic, strong) EAGLContext * context;
@property (nonatomic , strong) GLKBaseEffect* mEffect;
@property (weak, nonatomic) IBOutlet GLKView *contextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createBase];
    [self uploadVertexArray];
    [self uploadTexture];
}
- (void)createBase
{
    // EAGLContext对象用于管理 OpenGL ES渲染的上下文
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    GLKView * view = (GLKView*)self.contextView;
    view.context = self.context;
    
    /*
     drawableColorFormat:OpenGL的上下文有一个缓冲区，用来存储将要在屏幕中显示的颜色格式
     GLKViewDrawableColorFormatRGBA8888: 缓冲区中最小的颜色组成部分使用8个bit，更广的颜色范围
     GLKViewDrawableColorFormatRGB565：颜色范围小，消耗的资源少
     **/
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    [EAGLContext setCurrentContext:self.context];
    
}
- (void)uploadVertexArray
{
    GLfloat squareVertyData[] =
    {
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        0.5, 0.5, -0.0f,    1.0f, 1.0f, //右上
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        
        0.5, -0.5, 0.0f,    1.0f, 0.0f, //右下
        -0.5, 0.5, 0.0f,    0.0f, 1.0f, //左上
        -0.5, -0.5, 0.0f,   0.0f, 0.0f, //左下
    };
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(squareVertyData), squareVertyData, GL_STATIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 0);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0); //纹理
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 5, (GLfloat *)NULL + 3);
}
- (void)uploadTexture {
    //纹理贴图
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"for_test" ofType:@"jpg"];

    
    NSDictionary* options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];//GLKTextureLoaderOriginBottomLeft 纹理坐标系是相反的
    GLKTextureInfo* textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    //着色器
    self.mEffect = [[GLKBaseEffect alloc] init];
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = textureInfo.name;
}
/**
 *  渲染场景代码
 */
- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.3f, 0.6f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //启动着色器
    [self.mEffect prepareToDraw];
    glDrawArrays(GL_TRIANGLES, 0, 6);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
