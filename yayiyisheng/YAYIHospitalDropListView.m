//
//  YAYIHospitalDropListView.m
//  YAYIDoctor
//
//  Created by Veer on 16/6/8.
//
//

#import "YAYIHospitalDropListView.h"


static const CGFloat cellHeight = 40.0f;

@implementation YAYIHosiptalModel

@end


@implementation YAYIHospitalMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_width, cellHeight)];
        [self.contentView addSubview:self.bgView];
        
        self.point = [[UIView alloc] initWithFrame:CGRectMake(10, (cellHeight - 3)/2.0, 3, 3)];
        self.point.layer.masksToBounds = YES;
        self.point.layer.cornerRadius = 1.5;
        [self.bgView addSubview:_point];
        
        self.selectedIcon = [UIImageView new];
        self.selectedIcon.image = [UIImage imageNamed:@"check_select"];
        self.selectedIcon.frame = CGRectMake(15, (cellHeight - 11) * 0.5, 14.5, 11);
        [self.bgView addSubview:self.selectedIcon];
        self.selectedIcon.hidden = YES;
        
        self.textL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.selectedIcon.frame)+10, 0,300, cellHeight)];
        self.textL.font = [UIFont systemFontOfSize:14];
        [self.bgView addSubview:_textL];
        
    }
    return self;
}

- (void)setSetSelected:(BOOL)setSelected
{
    self.selectedIcon.hidden = !setSelected;
    self.textL.textColor = setSelected ? YAYIColor(94, 165, 237) : YAYIColor(78, 78, 78);
}

@end


@implementation YAYIHospitalDropListView
{
    UITableView *listTableView;
    CGRect orginalFrame;
    BOOL isShow;
    UIView *bgView;
    NSString *titleStr;
}


- (instancetype)initWithFrame:(CGRect)frame showOnView:(UIView*)view AllDataArr:(NSMutableArray*)arr showArr:(NSString *)showTitle
{
    if (self = [super initWithFrame:frame]) {
        self.AllDataArr = arr;
        titleStr = showTitle;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        button.tag = 100;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //            NSArray *temp = self.showArr[i];
        //            YAYIModel *model = [temp firstObject];
        
        
        button.titleLabel.font = [UIFont systemFontOfSize:16];
       
        //[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"arrow_up"] forState:UIControlStateSelected];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        CGSize strSize = [showTitle sizeWithFont:button.titleLabel.font];
        CGSize curImageSize = button.currentImage.size;
        
        if (strSize.width > button.width - curImageSize.width) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, button.width - curImageSize.width - 5, 0, -button.width + curImageSize.width + 5);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -curImageSize.width-2, 0, curImageSize.width+2);
            
        }else{
            button.imageEdgeInsets = UIEdgeInsetsMake(0, strSize.width+2 + 10, 0, -strSize.width-2);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -curImageSize.width-2 + 10, 0, curImageSize.width+2);
        }
        
        [button setTitle:showTitle forState:UIControlStateNormal];
        
        [button setTitleColor:[YAColor colorWithHexString:@"528CF5"] forState:UIControlStateNormal];
        [self addSubview:button];
        [view addSubview:self];
        

        // tableview
        listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_width, SCREEN_height - 64)];
        orginalFrame = CGRectMake(0, 64, SCREEN_width, 0);
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.hidden = YES;
        
        
        bgView = [[UIView alloc] initWithFrame:orginalFrame];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(bgViewClick:)];
        [bgView addGestureRecognizer:tap];
        bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [view addSubview:bgView];
        
        if ([ listTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [listTableView   setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
        if ([listTableView respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [listTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
            
        }
        
        [view addSubview:listTableView];
//        self.backgroundColor = [UIColor orangeColor];
    }
    
    return self;
}

- (void)refreshData:(NSMutableArray *)allDataArray
{
    self.AllDataArr = allDataArray;
    
    if (allDataArray.count == 0) {
        
        UIButton *button = [self viewWithTag:100];
        [button setTitle:titleStr forState:UIControlStateNormal];
        
        CGSize strSize = [titleStr sizeWithFont:button.titleLabel.font];
        CGSize curImageSize = button.currentImage.size;
        
        if (strSize.width > button.width - curImageSize.width) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, button.width - curImageSize.width - 5, 0, -button.width + curImageSize.width + 5);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -curImageSize.width-2, 0, curImageSize.width+2);
            
        }else{
            button.imageEdgeInsets = UIEdgeInsetsMake(0, strSize.width+2, 0, -strSize.width-2);
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -curImageSize.width-2, 0, curImageSize.width+2);
        }
    }
    
//    [self realShow];
}


- (void)realShow
{
    listTableView.hidden = YES;
    listTableView.height = cellHeight * [_AllDataArr count];
    [listTableView reloadData];
    
    bgView.height = SCREEN_height - CGRectGetMaxY(self.frame);
    
    listTableView.frame = orginalFrame;
    listTableView.hidden = NO;
    
    UIButton *btn = [self viewWithTag:100];
    
    [UIView animateWithDuration:0.2 animations:^{
        if (cellHeight * _AllDataArr.count > SCREEN_height-CGRectGetMaxY(self.frame)) {
            listTableView.height = SCREEN_height - CGRectGetMaxY(self.frame);
        }else{
            listTableView.height = cellHeight * [_AllDataArr count];
        }
        
        btn.selected = YES;
        //        btn.imageView.transform = CGAffineTransformMakeRotation(0);
    }];
}

- (void)hideCurrent
{
    
    UIButton *btn = [self viewWithTag:100];//self.subviews[currentSelect];
    btn.selected = NO;
    [UIView animateWithDuration:0.2 animations:^{
        listTableView.frame = orginalFrame;
        //        btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    bgView.frame = orginalFrame;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:CGRectMake(56, frame.origin.y , SCREEN_width - 140, frame.size.height)];
}


#pragma mark - 点击事件
- (void)bgViewClick:(UITapGestureRecognizer*)tap
{
    [self hideCurrent];
    isShow = NO;
    bgView.frame = orginalFrame;
}


- (void)buttonClick:(UIButton *)button
{
    if (isShow) {
        [self hideCurrent];
    }else{
        [self showIndex:0];
    }
    isShow = !isShow;
}

- (void)showIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(selectColum:)]) {
        [self.delegate selectColum:0];
    }
    
    [self realShow];
}


- (void)selectRow:(NSInteger)row
{
    //默认选中第一个
    NSArray *temp = self.AllDataArr;
    for (int i=0; i<temp.count; i++) {
        YAYIHosiptalModel *model = temp[i];
        if (i == row) {
            model.isSelect = YES;
        }else{
            model.isSelect = NO;
        }
    }
    //[ChdTable reloadData];
    
    UIButton *btn = [self viewWithTag:100];//(UIButton *)arr[colum];
    YAYIHosiptalModel *model = self.AllDataArr[row];
    
    // 最后一项不改变按钮文字
    [btn setTitle:model.name forState:UIControlStateNormal];
    
    CGSize strSize = [model.name sizeWithFont:btn.titleLabel.font];
    CGSize curImageSize = btn.currentImage.size;
    if (strSize.width > btn.width - curImageSize.width) {
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, btn.width - curImageSize.width - 5, 0, -btn.width + curImageSize.width + 5);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -curImageSize.width-2, 0, curImageSize.width+2);
        
    }else{
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, strSize.width+2, 0, -strSize.width-2);
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, -curImageSize.width-2, 0, curImageSize.width+2);
    }
}


#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_AllDataArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *chdResuseID = @"CHD_RESUSE";
    
    YAYIHospitalMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:chdResuseID];
    
    if (cell == nil) {
        cell = [[YAYIHospitalMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:chdResuseID];
    }
    
    YAYIHosiptalModel *model = [_AllDataArr objectAtIndex:indexPath.row];
    cell.textL.text = model.name;
    
    if (model.isSelect) {
        cell.setSelected = YES;
    }else{
        cell.setSelected = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //*************  本段代码用于选择相同选项时不在回调，不需要可注掉  ****************
    YAYIHosiptalModel *modelLast = self.AllDataArr[indexPath.row];
    if (modelLast.isSelect) {
        [self hideCurrent];
        isShow = NO;
        
        return;
    }
    //*************  本段代码用于选择相同选项时不在回调，不需要可注掉  ****************
    [self selectRow:indexPath.row];
    
    [self hideCurrent];
    isShow = NO;
    YAYIHosiptalModel *model = self.AllDataArr[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectRow:Model:)]) {
        [self.delegate selectRow:indexPath.row Model:model];
    }
    
}


@end
