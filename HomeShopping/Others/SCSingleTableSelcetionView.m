//
//  SCSingleTableSelcetionView.m
//  HomeShopping
//
//  Created by sooncong on 16/1/13.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "SCSingleTableSelcetionView.h"

@implementation SCSingleTableSelcetionView

{
    //cell高度
    CGFloat _cellHeight;
    
    //数据源
    NSArray * _dataSource;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self loadCustomViewWithFrame:frame];
        _cellHeight = GET_SCAlE_HEIGHT(32);
    }
    
    return self;
}

- (void)loadCustomViewWithFrame:(CGRect)frame
{
    _selectionTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self addSubview:_selectionTableView];
    [_selectionTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, frame.size.height));
    }];
    _selectionTableView.dataSource = self;
    _selectionTableView.delegate = self;
    _selectionTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHeight;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
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
        
        
        for (id subView in cell.selectedBackgroundView.subviews) {
            
            [subView removeFromSuperview];
        }
        
        [cell.selectedBackgroundView addSubview:[self createSeletedBackgroundView:indexPath]];

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate seletedAtIndex:indexPath.row Title:_dataSource[indexPath.row]];
}

- (UIView *)createContentViewWithIndexPath:(NSIndexPath *)indexPath WithTableView:(UITableView *)tableView
{
    UIView * contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _cellHeight)];
    
    
        contentView.backgroundColor = UIColorFromRGB(WHITECOLOR);
        UILabel * line = [UILabel new];
        [contentView addSubview:line];
        [line makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView.mas_bottom);
            make.centerX.mas_equalTo(contentView.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
        }];
        
        line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
    UILabel * titleLabel  = [UILabel new];
    [contentView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contentView.centerY).with.offset(0);
        make.left.mas_equalTo(contentView.left).with.offset(GET_SCAlE_LENGTH(10));
    }];
    titleLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    titleLabel.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    
    //修改内容
        if (_dataSource.count > 0) {
            titleLabel.text = _dataSource[indexPath.row];
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
    _dataSource = [NSArray arrayWithArray:dataSource];
}


@end
