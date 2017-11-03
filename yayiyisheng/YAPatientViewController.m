//
//  YAPatientViewController.m
//  yayiyisheng
//
//  Created by hxp on 17/6/2.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAPatientViewController.h"
#import "YAPatientDetailViewController.h"
#import "YASessionModel.h"
#import "YAPatientModel.h"
#import "YASessionHeaderView.h"
#import "YAPatientViewCell.h"
#import "YXSpritesLoadingView.h"
@interface YAPatientViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *sectionAry;
@property (nonatomic, assign)NSInteger  lastsection;

//@property (nonatomic, strong)UIView *View;
@end

@implementation YAPatientViewController

-(NSMutableArray *)sectionAry
{
    if (!_sectionAry) {
        _sectionAry = [NSMutableArray array];
    }
    return _sectionAry;

}

-(UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView   alloc] initWithFrame:CGRectMake(0, 0, SCREEN_width, SCREEN_height ) style:UITableViewStylePlain];
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
-(void)createDataSource{
    NSArray *arry = @[@"最近患者",@"治疗完成",@"根管治疗",@"矫正"];
    for (NSUInteger i = 0; i < arry.count; ++i) {
        YASessionModel *sectionModel = [[YASessionModel alloc]init];
        if (i== 0) {
            sectionModel.isExpanded = true;
        }else{
            sectionModel.isExpanded = NO;
        }
        
        sectionModel.title = arry[i];
        NSMutableArray *itemArray = [[NSMutableArray alloc]init];
        for (NSUInteger j = 0; j < 3; ++j) {
            YAPatientModel *cellModel = [[YAPatientModel alloc]init];
            cellModel.title = @"张三";
            [itemArray addObject:cellModel];
        }
        sectionModel.cellModels = itemArray;
        
        [self.sectionAry addObject:sectionModel];
    };
    [self.tableView reloadData];
   // NSLog(@"%@",self.sectionAry);

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    self.title = @"口腔诊所";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavView];
    
    [self.view addSubview:self.tableView];
    [self createDataSource];
   
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
}
-(void)createNavView{
    //UIBarButtonSystemItemFixedSpace
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 30);
    button.backgroundColor = [UIColor orangeColor];
    [button setTitle:@"🔍" forState:UIControlStateNormal];
    
    
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(30, 0, 30, 30);
    button1.backgroundColor = [UIColor redColor];
    [button1 setTitle:@"加" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:button1];
     */
     UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:nil action:nil];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    self.navigationItem.rightBarButtonItems = @[item2,item1];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YASessionModel *model = _sectionAry[section];
    return model.isExpanded ? model.cellModels.count : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"cell";
    YAPatientViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[YAPatientViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    YASessionModel *sectionModel = self.sectionAry[indexPath.section];
    YAPatientModel *model = sectionModel.cellModels[indexPath.row];
    cell.nameLab.text = model.title;
    cell.model = model;
    return cell;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *identifer = @"cell";
    YASessionHeaderView *header = [[YASessionHeaderView alloc] initWithReuseIdentifier:identifer];
    YASessionModel *model = self.sectionAry[section];
    header.model = model;
    
   
    header.callback = ^(BOOL isExpand){
    
        NSLog(@"%ld",self.lastsection);
         [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
        if (self.lastsection != section) {
            YASessionModel *lasmodel = self.sectionAry[self.lastsection];
            lasmodel.isExpanded = false;
            //[self.tableView reloadData];
            //YASessionHeaderView *lastheader = [tableView headerViewForSection:self.lastsection];
            //NSLog(@"%@",lastheader);
            //lastheader.model.isExpanded = false;
            //[self.tableView ];
           [tableView reloadSections:[NSIndexSet indexSetWithIndex:self.lastsection] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
     
        self.lastsection = section;
        
    };
    
    return header;

}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YAPatientDetailViewController *patientView = [YAPatientDetailViewController new];
    [self.navigationController pushViewController:patientView animated:YES];
}

@end
