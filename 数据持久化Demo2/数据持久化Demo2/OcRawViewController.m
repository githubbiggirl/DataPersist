//
//  OcRawViewController.m
//  数据持久化Demo2
//
//  Created by qingyun on 15/12/24.
//  Copyright © 2015年 qingyun. All rights reserved.
//

#import "OcRawViewController.h"

#define fileName @"QY.txt"
@interface OcRawViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textView;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation OcRawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1. 读取本地数据
    [self loadDataFromLocal];
    
    // Do any additional setup after loading the view from its nib.
}


- (NSString *)filePath{
    if (_filePath == NULL) {
        //获取沙盒路径
        NSString *directPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    //2创建文件夹
        //2.1获取文件管理器对象（单例对象）
        NSFileManager *fileManager = [NSFileManager defaultManager];
        //2.2 创建文件夹
          //2.2.1合并文件夹路径
        NSString *directoryPath = [directPath stringByAppendingPathComponent:@"test"];
        NSError *error;
          //2.3 创建文件夹
        if (![fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:0 error:&error]) {
            NSLog(@"<<<<error<<<<%@",error);
            return nil;
        }
    
    //3.创建文件
      //3.1 合并文件路径
        NSString *fPath = [directoryPath stringByAppendingString:fileName];
        
      //3.2 创建文件
        
      //3.3 判断文件是否已经存在
        
        if (![fileManager fileExistsAtPath:fPath]){
           if (![fileManager createFileAtPath:fPath contents:nil attributes:0]){
              NSLog(@"文件创造失败");
              return nil;
        };
            _filePath = fPath;
        }else{
            _filePath = fPath;
        }
    }
    return _filePath;
}

- (BOOL)saveDatas
{
    NSError *error;
    if ([_textView.text writeToFile:self.filePath atomically:YES encoding:NSUTF8StringEncoding error:&error ]) {
        NSLog(@">>..失败");
        return NO;
        
    }
    return YES;
}

- (void)loadDataFromLocal{
    //1. 读取本地文件 转成string
    NSString *content = [[NSString alloc] initWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
    //2. 更新textField
    _textView.text = content;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
