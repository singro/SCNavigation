//
//  SCViewController.m
//  SCNavigation
//
//  Created by Singro on 8/15/14.
//  Copyright (c) 2014 Singro. All rights reserved.
//

#import "SCViewController.h"

static NSInteger pushedCount = 0;

@interface SCViewController ()

@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *switchLabel = [[UILabel alloc] initWithFrame:(CGRect){20, 153, 100, 44}];
    switchLabel.font = [UIFont systemFontOfSize:15];
    switchLabel.text = @"navi hidden:";
    [self.view addSubview:switchLabel];
    
    UISwitch *aSwitch = [[UISwitch alloc] initWithFrame:(CGRect){160, 160, 90, 44}];
    [aSwitch addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:aSwitch];
    aSwitch.on = NO;
    
    UIButton *pushButton = [[UIButton alloc] initWithFrame:(CGRect){20, 230, 200, 44}];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pushButton.backgroundColor = [UIColor grayColor];
    [pushButton addTarget:self action:@selector(pushToVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
    
    self.sc_navigationItem.title = [NSString stringWithFormat:@"navi %d", pushedCount];
    
    __weak typeof(SCViewController) *weakSelf = self;
    
    if (pushedCount > 0) {
        self.sc_navigationItem.leftBarButtonItem = [[SCBarButtonItem alloc] initWithTitle:@"back" style:SCBarButtonItemStylePlain handler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    
    self.sc_navigationItem.rightBarButtonItem = [[SCBarButtonItem alloc] initWithTitle:[NSString stringWithFormat:@"%d", pushedCount] style:SCBarButtonItemStylePlain handler:^(id sender) {
        [weakSelf pushToVC];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)pushToVC {
    
    SCViewController *vc = [[SCViewController alloc] init];
    pushedCount ++;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)switchChange:(UISwitch *)aSwitch {
    
    if (aSwitch.isOn) {
        [self sc_setNavigationBarHidden:YES animated:YES];
    } else {
        [self sc_setNavigationBarHidden:NO animated:YES];
    }
}

@end
