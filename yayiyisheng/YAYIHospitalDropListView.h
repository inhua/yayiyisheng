//
//  YAYIHospitalDropListView.h
//  YAYIDoctor
//
//  Created by Veer on 16/6/8.
//
//  医院下拉菜单

#import <UIKit/UIKit.h>


//定义数据模型
@interface YAYIHosiptalModel : NSObject

@property (nonatomic,copy) NSString *hospitalid;
@property (nonatomic,copy) NSString *wpid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *id;
@property BOOL isSub;
@property BOOL isSelect;
@end


//自定义下拉cell
@interface YAYIHospitalMenuCell : UITableViewCell

@property (nonatomic,retain) UIView *bgView;
@property (nonatomic,retain) UIView *point;
@property (nonatomic,retain) UILabel *textL;

@property (nonatomic,strong)UIImageView *selectedIcon;

@property (nonatomic, assign) BOOL setSelected;

@end


@protocol YAYIHospitalDropListViewDelegate <NSObject>

- (void)selectRow:(NSInteger)row Model:(YAYIHosiptalModel *)model;
- (void)selectColum:(NSInteger)colum;

@end

@interface YAYIHospitalDropListView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSMutableArray *AllDataArr;
@property (nonatomic, retain) NSMutableArray *showArr;
@property (nonatomic, weak) id<YAYIHospitalDropListViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame showOnView:(UIView*)view AllDataArr:(NSMutableArray*)arr showArr:(NSString *)showTitle;
// 使某列某行被选中,默认均选中第0行。 可调用此方法更改默认。
- (void)selectRow:(NSInteger)row;

- (void)refreshData:(NSMutableArray *)allDataArray;

@end
