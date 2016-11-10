//
//  ViewController.m
//  ASScrollCountView
//
//  Created by haohao on 16/11/7.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "ASScrollCountView.h"
@interface ViewController ()
@property (nonatomic, strong) ASScrollCountView *countView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) int index;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.index = 0;
    self.countView = [[ASScrollCountView alloc]initWithFrame:CGRectMake(20, 100, 250, 40)];
    self.countView.duration = 0.5f;
    self.countView.textColor = [UIColor redColor];
    self.countView.characterWidth = 20;
    self.countView.style = ASScrollDirectionStyleDown;
    self.countView.textFont = [UIFont systemFontOfSize:17];
    [self.view addSubview:self.countView];
    self.countView.numberText = @"78940561306";
}

-(NSArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"123456", @"45687", @"95487", @"987456358", @"12", nil];
    }
    return _dataArray;
}

- (IBAction)btnCLick:(id)sender {
    self.index++;
    if (self.index == self.dataArray.count) {
        self.index = 0;
    }
    self.countView.numberText = self.dataArray[self.index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
