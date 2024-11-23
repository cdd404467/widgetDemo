//
//  HomeVC.m
//  widgetDemo
//
//  Created by caidd on 2024/11/20.
//

#import "HomeVC.h"
#import "ModelTestVC.h"

@interface HomeVC ()

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupUI];
}

- (void)setupUI {
    UILabel *welcomeLabel = [[UILabel alloc] init];
    welcomeLabel.text = @"Welcome to widget demo";
    welcomeLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    welcomeLabel.textColor = UIColor.grayColor;
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:welcomeLabel];
    welcomeLabel.frame = CGRectMake(0, 260, self.view.frame.size.width, 60);
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = @"Add widget to home screen";
    tipLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    tipLabel.textColor = UIColor.lightGrayColor;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    tipLabel.frame = CGRectMake(0, 300, self.view.frame.size.width, 100);
    
    UIButton *jumpBtn_page = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn_page setTitle:@"go model page" forState:UIControlStateNormal];
    [jumpBtn_page setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    jumpBtn_page.backgroundColor = UIColor.blackColor;
    jumpBtn_page.titleLabel.font = [UIFont systemFontOfSize:18];
    jumpBtn_page.layer.cornerRadius = 10;
    jumpBtn_page.tag = 11;
    [jumpBtn_page addTarget:self action:@selector(goModelPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn_page];
    jumpBtn_page.frame = CGRectMake(50, 450, self.view.frame.size.width - 100, 50);
    
    UIButton *jumpBtn_q = [UIButton buttonWithType:UIButtonTypeCustom];
    [jumpBtn_q setTitle:@"go model quicklook(真机)" forState:UIControlStateNormal];
    [jumpBtn_q setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    jumpBtn_q.backgroundColor = UIColor.blackColor;
    jumpBtn_q.titleLabel.font = [UIFont systemFontOfSize:18];
    jumpBtn_q.layer.cornerRadius = 10;
    jumpBtn_q.tag = 12;
    [jumpBtn_q addTarget:self action:@selector(goModelPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpBtn_q];
    jumpBtn_q.frame = CGRectMake(50, 550, self.view.frame.size.width - 100, 50);
}

- (void)goModelPage:(UIButton *)sender {
    ModelTestVC *vc = [[ModelTestVC alloc] init];
    vc.type = sender.tag - 10;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
