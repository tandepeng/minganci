//
//  ViewController.m
//  敏感词过滤
//
//  Created by 谭德鹏 on 2017/4/25.
//  Copyright © 2017年 中泰荣科. All rights reserved.
//
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_Height [UIScreen mainScreen].bounds.size.height
#import "ViewController.h"
#import "SensitiveWordTools.h"
@interface ViewController ()

@end

@implementation ViewController
{
    UITextField *_textField;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建输入框和发送按钮
    [self createFieldAndButton];

}

#pragma mark-创建输入框和发送按钮
- (void)createFieldAndButton{
    
    //输入框
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(50, 100, Screen_Width - 100, 50)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    _textField.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_textField];
    
    //发送按钮
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake((Screen_Width-100)/2.0f, 300, 100, 50);
    sendButton.layer.cornerRadius = 8;
    sendButton.clipsToBounds = YES;
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setBackgroundColor:[UIColor orangeColor]];
    [sendButton addTarget:self action:@selector(btnAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
}

//发送按钮的响应方法
- (void)btnAct:(UIButton *)btn{
    
    //判断输入的内容是否含有敏感词
    BOOL hasSensitive = [[SensitiveWordTools sharedInstance]hasSensitiveWord:_textField.text];
    
    if (hasSensitive) {
        
        NSString *string = [NSString stringWithFormat:@"含有敏感词汇：%@",[[SensitiveWordTools sharedInstance]filter:_textField.text]];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"将敏感词替换为‘*’" message:string preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:sureAction];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
