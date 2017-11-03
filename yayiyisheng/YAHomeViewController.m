//
//  YAHomeViewController.m
//  yayiyisheng
//
//  Created by hxp on 17/6/1.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAHomeViewController.h"
#import "YAWorkViewCell.h"
#import "YAWorkModel.h"
#import "YAYIHospitalDropListView.h"
#import "YAHeaderViewCell.h"

#import "YAPatientViewController.h" //患者


@interface YAHomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, weak)YAYIHospitalDropListView *dropMenu;
@property (nonatomic, strong)NSMutableArray *dataArry;
@property (nonatomic, strong)NSMutableArray *hospitalArray;

@property (nonatomic, strong)UIView *navView;
@end

@implementation YAHomeViewController
-(NSMutableArray *)hospitalArray
{
    if (!_hospitalArray) {
        _hospitalArray= [NSMutableArray array];
    }
    return _hospitalArray;
}
-(NSMutableArray *)dataArry
{
    if (!_dataArry) {
        self.dataArry = [NSMutableArray array];
    }
    return _dataArry;

}

-(UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView   alloc] initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height -64-50) style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.tableView.backgroundColor = [YAColor YABackgroundColor];
        self.tableView.tableFooterView = [UIView new];
    }
    return _tableView;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [YAColor YABackgroundColor];
    //[self createNavigationBarSubView];
    [self.view addSubview:self.tableView];
    [self createdata];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //[self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)createNavigationBarSubView{
    
    UIView *navView = [UIView new];
    navView.frame = CGRectMake(0, 0, SCREEN_width, 64);
    navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navView];
    
    
    UIImageView *imageView = [UIImageView new];
    imageView.frame = CGRectMake(10, 22, 36,36);
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 18;
    imageView.image = [UIImage imageNamed:@"yayiSelected"];
    [navView addSubview:imageView];
    
    YAYIHospitalDropListView *dropMenu = [[YAYIHospitalDropListView alloc] initWithFrame:CGRectMake(56, 22, SCREEN_width - 70 * 2, 36) showOnView:self.view AllDataArr:self.hospitalArray showArr:@"选择医院"];
    //dropMenu.delegate = self;
    
    self.dropMenu = dropMenu;
    [navView addSubview:dropMenu];;

}
-(void)createdata{
    [self.dataArry removeAllObjects];
    NSArray *arry = @[@"患者",@"预约",@"排班",@"回访",@"学习",@"同事",@"活动",@"商城",@"营销"];
    for (int i = 0; i < arry.count; i++) {
        YAWorkModel *model = [YAWorkModel new];
        model.title = arry[i];
        model.name = @"homeIcon5";
        model.deClass = [YAPatientViewController class];
        [self.dataArry addObject:model];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static  NSString *identifer = @"identifer1";
        YAHeaderViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
        if (cell == nil) {
            cell = [[YAHeaderViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;

    }else {
        static  NSString *identifer2 = @"identifer2";
        YAWorkViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer2];
        cell.controller = self;
        if (cell == nil) {
            cell = [[YAWorkViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer2];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataAry = self.dataArry;
        return cell;
        
    }
    
   
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    return 0.01;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 400;
    }
    return 250;
}

@end
