//
//  ViewController.m
//  Bsdiff_Demo
//
//  Created by Laomeng on 2017/12/10.
//  Copyright © 2017年 Laomeng. All rights reserved.
//

#import "ViewController.h"
#import "Test_Bsdiff.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self Bsdiff];
    
    [self Bspatch];
}

#pragma Mark - Bsdiff
- (void)Bsdiff
{
    const char *argv[4];
    argv[0] = "bsdiff";
    // oldPath
    NSString *path1 = [NSString stringWithFormat:@"/%@/%@",[NSBundle mainBundle].bundlePath, @"old.zip"];
    argv[1] = [path1 UTF8String];
    // newPath
    NSString *path2 = [NSString stringWithFormat:@"/%@/%@",[NSBundle mainBundle].bundlePath, @"new.zip"];
    //    argv[2] = argv[1] = [[NSString stringWithFormat:@"file://%@", path2] UTF8String];
    argv[2] = [path2 UTF8String];
    // patchPath
    argv[3] = [[self createFileWithFileName:@"bsdiff_Test"] UTF8String];
    
    int result = BsdiffUntils_bsdiff(4, argv);
    
}

#pragma Mark - Bspatch
- (void)Bspatch
{
    const char *argv[4];
    argv[0] = "bspatch";
    // oldPath
    NSString *path1 = [NSString stringWithFormat:@"/%@/%@",[NSBundle mainBundle].bundlePath, @"old.zip"];
    argv[1] = [path1 UTF8String];
    // newPath
    argv[2] = [[self createFileWithFileName:@"Test_Result.zip"] UTF8String];
    // patchPath
    argv[3] = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"bsdiff_Test"] UTF8String];
    int result = BsdiffUntils_bspatch(4, argv);
    
}

-(NSString *)createFileWithFileName:(NSString *)fileName
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    NSLog(@"%@", filePath);
    return filePath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
