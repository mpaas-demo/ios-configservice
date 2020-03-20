//
//  DemoViewController.m
//  test
//
//  Created by mPaaS on 16/11/21.
//  Copyright © 2016年 Alibaba. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"ConfigDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, 150, [UIScreen mainScreen].bounds.size.width-60, 44);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"开关配置信息" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(fetchConfig) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectOffset(button.frame, 0, 80);
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"强制拉取开关配置" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(forceLoad) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchConfig {
    NSString *value = [[MPConfigInterface sharedService] stringValueForKey:@"BillEntrance"];
    AUNoticeDialog *alert = [[AUNoticeDialog alloc] initWithTitle:@"配置信息" message:value delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)configChangedForKey:(NSString *)key value:(NSString *)value
{
    if ([key isEqualToString:@"BillEntrance"]) {
        [self fetchConfig];
    }
}

- (void)forceLoad
{
    [[MPConfigInterface sharedService] forceLoadConfig];
}

- (void)dealloc
{
    [[MPConfigInterface sharedService] removeObserver:self];
}

@end
