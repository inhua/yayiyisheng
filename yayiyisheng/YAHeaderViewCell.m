//
//  YAHeaderViewCell.m
//  yayiyisheng
//
//  Created by hxp on 17/6/2.
//  Copyright © 2017年 achego. All rights reserved.
//

#import "YAHeaderViewCell.h"

@implementation YAHeaderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createView];
    }
    return self;
    
}
-(void)createView{

    YAHomeheaderView * view = [[YAHomeheaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_width, 200)];
    [self.contentView  addSubview:view];
    
    UIButton *todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.todayBtn = todayBtn;
   
    [todayBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    self.todayBtn.titleLabel.numberOfLines = 0;
    self.todayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.todayBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.todayBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:todayBtn];
    
    UIButton *tomorrowdayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.tomorrowBtn = tomorrowdayBtn;
    self.tomorrowBtn.titleLabel.numberOfLines = 0;
    //[tomorrowdayBtn setBackgroundImage:[UIImage new] forState:UIControlStateSelected];
    [tomorrowdayBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    self.tomorrowBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.tomorrowBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.tomorrowBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:tomorrowdayBtn];
    
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.historyBtn = historyBtn;
    self.historyBtn.titleLabel.numberOfLines = 0;
    //[historyBtn setBackgroundImage:[UIImage new] forState:UIControlStateSelected];
    [historyBtn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    self.historyBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.historyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [self.historyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:historyBtn];
    
    
    UILabel *vLine1 = [UILabel new];
    vLine1.backgroundColor = [YAColor YALineColor];
    self.vLine1 = vLine1;
    [self.contentView addSubview:vLine1];
    UILabel *vLine2 = [UILabel new];
    vLine2.backgroundColor = [YAColor YALineColor];
    self.vLine2 = vLine2;
    [self.contentView addSubview:vLine2];
    
    
    
    
    
    
    NSMutableAttributedString *str1 = [self title:@"今日工作" content:@"6"];
    NSMutableAttributedString *str2 = [self title:@"昨日工作" content:@"66"];
    NSMutableAttributedString *str3 = [self title:@"历史欠款" content:@"666"];

     [self.todayBtn setAttributedTitle:str1 forState:UIControlStateNormal];
    
     [self.tomorrowBtn setAttributedTitle:str2 forState:UIControlStateNormal];
    
     [self.historyBtn setAttributedTitle:str3 forState:UIControlStateNormal];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = (SCREEN_width - 2) / 3.0;
    [self.todayBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(@200);
        make.size.mas_equalTo(CGSizeMake(width, 50));
    }];
    
    [self.vLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(viewHeight + 12));
        make.left.equalTo(self.todayBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(0.5, 26));
    } ];
    
    
    [self.tomorrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.todayBtn.mas_right).offset(1);
        make.top.mas_equalTo(self.todayBtn.mas_top);
        make.size.mas_equalTo(CGSizeMake(width, 50));
    }];
    
    
    [self.vLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(viewHeight + 12));
        make.left.equalTo(self.tomorrowBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(0.5, 26));
    } ];
    
    
    [self.historyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tomorrowBtn.mas_right).offset(1);
        make.top.mas_equalTo(self.todayBtn.mas_top);;
        make.size.mas_equalTo(CGSizeMake(width, 50));
    }];
   
}


-(NSMutableAttributedString *)title:(NSString *)title content:(NSString *)content{
    NSString *str = [NSString stringWithFormat:@"%@\n%@",content,title];
    NSMutableAttributedString  *mStr = [[NSMutableAttributedString alloc] initWithString:str];
    //
    [mStr addAttribute:NSFontAttributeName value:[UIFont italicSystemFontOfSize:16] range:NSMakeRange(0, content.length)];
    [mStr addAttribute:NSForegroundColorAttributeName value:[YAColor colorWithHexString:@"528CF5"] range:NSMakeRange(0,content.length)];
    [mStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(content.length +1, title.length)];
    [mStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(content.length+1, title.length)];
    return mStr;

}

//-(UIButton *)button:(NSString *)content title:(NSString *)title frame:(Rect)rect{
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    UILabel *titleLab = [UILabel new];
//    titleLab.textAlignment = NSTextAlignmentCenter;
//    titleLab.frame = CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
//    
//    
//    
//    
//    return button;
//
//
//}
@end
