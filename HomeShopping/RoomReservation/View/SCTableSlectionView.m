//
//  SCTableSlectionView.m
//  HomeShopping
//
//  Created by sooncong on 16/1/3.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "SCTableSlectionView.h"
#import "Areas.h"
#import "Subareas.h"

@implementation SCTableSlectionView
{
    //cell高度
    CGFloat _cellHeight;
    
    //数据源
    NSArray * _dataSource;
    NSArray * _subDataSource;
    
    //记录当前商圈
    NSInteger _index;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self loadCustomViewWithFrame:frame];
        _cellHeight = GET_SCAlE_HEIGHT(32);
        _index = 0;
    }
    
    return self;
}

- (void)loadCustomViewWithFrame:(CGRect)frame
{
    _fatherTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width/2.0, frame.size.height) style:UITableViewStylePlain];
    [self addSubview:_fatherTableView];
    [_fatherTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, frame.size.height));
    }];
    _fatherTableView.dataSource = self;
    _fatherTableView.delegate = self;
    _fatherTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    _subTableView = [[UITableView alloc] initWithFrame:CGRectMake(frame.size.width/2.0, 0, frame.size.width/2.0, frame.size.height) style:UITableViewStylePlain];
    [self addSubview:_subTableView];
    [_subTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.right.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/2, frame.size.height));
    }];
    _subTableView.delegate = self;
    _subTableView.dataSource = self;
    _subTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (tableView == _fatherTableView)?_dataSource.count:(_subDataSource.count +1);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (cell) {
        for (id subView in cell.contentView.subviews) {
            
            if ([subView isKindOfClass:[UIView class]]) {
                
                UIView *vie = (UIView *)subView;
                [vie removeFromSuperview];
            }
        }
        
        [cell.contentView addSubview:[self createContentViewWithIndexPath:indexPath WithTableView:tableView]];
        
        if (tableView == _fatherTableView) {
            
            for (id subView in cell.selectedBackgroundView.subviews) {
                
                [subView removeFromSuperview];
            }
            
            [cell.selectedBackgroundView addSubview:[self createSeletedBackgroundView:indexPath]];
        }else{
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _fatherTableView) {
        
        if (indexPath.row == 0) {
            [self.delegate seletedArea:_dataSource[indexPath.row] subArea:nil];
        }else{
            _index = indexPath.row;
            Areas * area = _dataSource[indexPath.row];
            _subDataSource = [NSArray arrayWithArray:area.subareas];
            
            [_subTableView reloadData];
        }
    }else{
//        [self.delegate seletedFinishedWithIndex:indexPath.row];
        
        if (indexPath.row == 0) {
            [self.delegate seletedArea:_dataSource[_index] subArea:nil];
        }else{
            [self.delegate seletedArea:_dataSource[_index] subArea:_subDataSource[indexPath.row - 1]];
        }
    }
}

- (UIView *)createContentViewWithIndexPath:(NSIndexPath *)indexPath WithTableView:(UITableView *)tableView
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _cellHeight)];
    
    if (tableView == _fatherTableView) {
        
        contentView.backgroundColor = UIColorFromRGB(WHITECOLOR);
        UILabel * line = [UILabel new];
        [contentView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView.mas_bottom);
            make.centerX.mas_equalTo(contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        
        line.backgroundColor = UIColorFromRGB(LINECOLOR);
    }else{
        contentView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    }
    
    UILabel * titleLabel  = [UILabel new];
    [contentView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(10));
    }];
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];

    //修改内容
    if (_fatherTableView == tableView) {
        if (_dataSource.count > 0) {
            Areas * model = _dataSource[indexPath.row];
            titleLabel.text = model.title;
        }
    }
    else
    {
        if (_subDataSource.count > 0) {
            
            if (indexPath.row == 0) {
                titleLabel.text = @"全部";
            }else{
            
            Subareas * model = _subDataSource[indexPath.row - 1];
            titleLabel.text = model.subtitle;
            }
        }
    }
    
    return contentView;
}

- (UIView *)createSeletedBackgroundView:(NSIndexPath *)indexPath
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _cellHeight)];
    contentView.backgroundColor = UIColorFromRGB(GRAYBGCOLOR);
    
    UILabel * line = [UILabel new];
    [contentView addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.top);
        make.centerX.mas_equalTo(contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    return contentView;
}

#pragma mark - method

-(void)setParameterWithDataSource:(NSArray *)dataSource
{
    NSMutableArray * tempArr = [NSMutableArray array];
    [tempArr addObjectsFromArray:dataSource];
    
    if (tempArr.count == 2) {
        for (Areas * model in dataSource) {
            if ([model.areaid integerValue] == 99) {
                [tempArr removeObject:model];
            }
        }
    }
    
    _dataSource = [NSArray arrayWithArray:tempArr];
    
    if (_dataSource.count > 0) {
        
        [_fatherTableView reloadData];
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_fatherTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        
        Areas * area = _dataSource[0];
        _subDataSource = [NSArray arrayWithArray:area.subareas];
        [_subTableView reloadData];
    }
}

@end
