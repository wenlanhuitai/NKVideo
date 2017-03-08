//
//  SMPlayViewController.m
//  HNLVideo
//
//  Created by 谢印超 on 2017/3/6.
//  Copyright © 2017年 谢印超. All rights reserved.
//

#import "SMPlayViewController.h"
#import <ZFPlayer.h>
@interface SMPlayViewController () <ZFPlayerDelegate>

@end

@implementation SMPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.playView = [[ZFPlayerView alloc] init];
    [self.view addSubview:self.playView];
    [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.playView.mas_width).multipliedBy(9.0f/16.0f);
    }];
    //初始化 控制层view,可以自定义
    ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
    //初始化模仿模型
    ZFPlayerModel *playerModel = [[ZFPlayerModel alloc] init];
    playerModel.videoURL = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    
    playerModel.title = @"测试";
    
    [self.playView playerControlView:controlView playerModel:playerModel];
    //设置代理
    self.playView.delegate = self;
    //自动播放
    [self.playView autoPlayTheVideo];
}

//ZFPlayerView 代理
-(void)zf_playerDownload:(NSString *)url {
    
}
- (void)zf_playerBackAction {
    
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
