//
//  CommentCell.m
//  HomeShopping
//
//  Created by sooncong on 16/1/1.
//  Copyright © 2016年 Administrator. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"

#define COMIMAGEWIDTH ((SCREEN_WIDTH - 50)/4)

@implementation CommentCell
{
    //评论内容高度
    CGFloat _contentHeight;
    
    //商家回复高度
    CGFloat _businessReplyHeight;
    
    //评论图片点击回调
    CommentImageTapBlock _callBackBlock;
    
    Comments * _model;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {

        [self loadCustomView];
        
        _contentHeight       = 0;
        _businessReplyHeight = 0;

        self.selectionStyle  = UITableViewCellSelectionStyleNone;
    }

    return self;
}

- (void)loadCustomView
{
    _headImageView = [UIImageView new];
    [self addSubview:_headImageView];
    [_headImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.top).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.mas_equalTo(self.left).with.offset(GET_SCAlE_LENGTH(10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(25), 25));
    }];
    _headImageView.image = [UIImage imageNamed:@"mine_defaultHead"];
    
    _nickNameLabel  = [UILabel new];
    [self addSubview:_nickNameLabel];
    [_nickNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImageView.centerY).with.offset(0);
        make.left.mas_equalTo(_headImageView.right).with.offset(GET_SCAlE_LENGTH(7));
    }];
    _nickNameLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _nickNameLabel.font = [UIFont systemFontOfSize:14];
    _nickNameLabel.text = @"";
    
    _commentTimeLabel  = [UILabel new];
    [self addSubview:_commentTimeLabel];
    [_commentTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_headImageView.centerY).with.offset(0);
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-15));
    }];
    _commentTimeLabel.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    _commentTimeLabel.font = [UIFont systemFontOfSize:14];
    _commentTimeLabel.text = @"";
    
    //客服评分
    _guestClothingScoreBaseView = [UIView new];
    [self setUpScoreViewWithBaseView:_guestClothingScoreBaseView text:@"客服服务:"];
    [self addSubview:_guestClothingScoreBaseView];
    [_guestClothingScoreBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_headImageView.bottom).with.offset(GET_SCAlE_HEIGHT(15));
        make.left.mas_equalTo(_headImageView.left);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(145), GET_SCAlE_HEIGHT(15)));
    }];
    
    //描述评分
    _descriptionScroeBaseView = [UIView new];
    [self setUpScoreViewWithBaseView:_descriptionScroeBaseView text:@"描述评分:"];
    [self addSubview:_descriptionScroeBaseView];
    [_descriptionScroeBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_guestClothingScoreBaseView.top);
        make.right.mas_equalTo(self.right).with.offset(GET_SCAlE_LENGTH(-10));
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(145), GET_SCAlE_HEIGHT(15)));
    }];
    
    _commentDetailBaseView = [UIView new];
    [self addSubview:_commentDetailBaseView];
    [_commentDetailBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_guestClothingScoreBaseView.bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.centerX.mas_equalTo(self.centerX);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(300), GET_SCAlE_HEIGHT(70)));
    }];
    
    _commentLabel  = [UILabel new];
    [_commentDetailBaseView addSubview:_commentLabel];
    [_commentLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.mas_equalTo(_commentDetailBaseView);
    }];
    _commentLabel.textColor = UIColorFromRGB(BLACKFONTCOLOR);
    _commentLabel.font = [UIFont systemFontOfSize:14];
    _commentLabel.numberOfLines = 0;
    
    _businessReplyBaseView = [UIView new];
    [self addSubview:_businessReplyBaseView];
    [_businessReplyBaseView makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_commentDetailBaseView.mas_bottom).with.offset(GET_SCAlE_HEIGHT(10));
        make.left.and.right.mas_equalTo(_commentDetailBaseView);
        make.size.mas_equalTo(CGSizeMake(GET_SCAlE_LENGTH(300), 50));
    }];
    
    _businessReplyLabel  = [UILabel new];
    [_businessReplyBaseView addSubview:_businessReplyLabel];
    [_businessReplyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.mas_equalTo(_businessReplyBaseView);
    }];
    _businessReplyLabel.numberOfLines = 0;
    _businessReplyLabel.font = [UIFont systemFontOfSize:14];
    
    UILabel * line = [UILabel new];
    [self addSubview:line];
    [line makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 0.5));
    }];
    line.backgroundColor = UIColorFromRGB(LINECOLOR);
    
}

/**
 *  设置分数
 *
 *  @param score    分数
 *  @param baseView 基视图
 */
- (void)setScoreViewWithScore:(NSInteger)score BaseView:(UIView *)baseView
{
    [baseView.subviews enumerateObjectsUsingBlock:^(__kindof UIImageView * _Nonnull star, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([star isKindOfClass:[UIImageView class]]) {
            star.image = [UIImage imageNamed:@"mine_CommentStar_selected"];
        }
        
        if (idx == score) {
            * stop = YES;
        }
        
    }];
}

/**
 *  配置基视图参数
 *
 *  @param baseView 基视图
 *  @param text     标题
 */
- (void)setUpScoreViewWithBaseView:(UIView *)baseView text:(NSString *)text
{
    UILabel * title  = [UILabel new];
    [baseView addSubview:title];
    [title makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(baseView);
        make.centerY.mas_equalTo(baseView.centerY);
    }];
    title.textColor = UIColorFromRGB(GRAYFONTCOLOR);
    title.font = [UIFont systemFontOfSize:NORMALFONTSIZE];
    title.text = text;
    
    for (NSInteger i = 0; i<5; i++) {
        UIImageView * star = [[UIImageView alloc] init];
        star.image = [UIImage imageNamed:@"mine_CommentStar"];
        star.frame = CGRectMake(60 + i * (15 + 2), 0, 15, 15);
        [baseView addSubview:star];
    }
}

// 用于求高度或宽度
- (CGSize) sizeForText:(NSString *)text WithMaxSize:(CGSize)maxSize AndWithFontSize:(CGFloat)fontSize
{
    if (text != nil && [text isKindOfClass:[NSString class]]) {
        CGRect rect = [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize: fontSize]} context:nil];
        return rect.size;

    }else{
        return CGSizeMake(0, 0);
    }
}

-(void)setCellWithModel:(Comments *)comment
{
    _model = comment;
    
    NSString * logo = [comment.comlogo stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"mine_defaultHead"]];
    _nickNameLabel.text = comment.commenter;
    _commentTimeLabel.text = comment.commenttime;
    _commentLabel.text = comment.content;
//    _commentLabel.text = @"阿里开始的放假拉开始减肥了京东方阿斯顿路口附近阿里肯定是交罚款的设计费阿斯顿离开发了啥地方科技阿里山的开发金额放假阿斯蒂芬";
    
    _contentHeight = [self sizeForText:_commentLabel.text WithMaxSize:CGSizeMake(GET_SCAlE_LENGTH(300), 1000) AndWithFontSize:14].height;
    
    for (UIImageView * star in _guestClothingScoreBaseView.subviews) {
        if ([star isKindOfClass:[UIImageView class]]) {
            star.image = [UIImage imageNamed:@"mine_CommentStar"];
        }
    }
    
    for (UIImageView * star in _descriptionScroeBaseView.subviews) {
        if ([star isKindOfClass:[UIImageView class]]) {
            star.image = [UIImage imageNamed:@"mine_CommentStar"];
        }
    }

    
    if ([comment.kfstars isKindOfClass:[NSString class]]) {
        NSInteger guestClothingScore = [[comment.kfstars substringToIndex:1] integerValue];
        [self setScoreViewWithScore:guestClothingScore BaseView:_guestClothingScoreBaseView];
    }
    
    if ([comment.remarkstars isKindOfClass:[NSString class]]) {
        NSInteger descriptionScore = [[comment.remarkstars substringToIndex:1] integerValue];
        [self setScoreViewWithScore:descriptionScore BaseView:_descriptionScroeBaseView];
    }
    
    
    for (UIImageView * pic in _commentDetailBaseView.subviews) {
        if ([pic isKindOfClass:[UIImageView class]]) {
            [pic removeFromSuperview];
        }
    }
    
    if ([comment.comimagelist isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary * dic = (NSDictionary *)comment.comimagelist;
        
        NSString * url = dic[@"comimage"];
        
        UIImageView * picture = [[UIImageView alloc] init];
        
        if ([url isKindOfClass:[NSString class]]) {
            [picture sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"headimage"]];
        }
        picture.frame = CGRectMake(10, _contentHeight + 10, COMIMAGEWIDTH, GET_SCAlE_HEIGHT(45));
        [_commentDetailBaseView addSubview:picture];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentImageTaped)];
        [picture addGestureRecognizer:tap];
        
    }else{
        if (comment.comimagelist.count > 0) {
            
            NSInteger count = (comment.comimagelist.count > 4)?4:comment.comimagelist.count;
            
            for (NSInteger i = 0; i < count; i++) {
                
                UIImageView * picture = [[UIImageView alloc] init];
                
                if ([comment.comimagelist[i] isKindOfClass:[NSString class]]) {
                    [picture sd_setImageWithURL:[NSURL URLWithString:comment.comimagelist[i]] placeholderImage:[UIImage imageNamed:@"headimage"]];
                }
                picture.frame = CGRectMake(i * (COMIMAGEWIDTH + 10), _contentHeight + 10, COMIMAGEWIDTH, GET_SCAlE_HEIGHT(45));
                [_commentDetailBaseView addSubview:picture];
                
                UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentImageTaped)];
                [picture addGestureRecognizer:tap];
                picture.userInteractionEnabled = YES;
            }
        }
    }
    


    
    [_commentDetailBaseView updateConstraints:^(MASConstraintMaker *make) {
        
        if ([comment.comimagelist isKindOfClass:[NSArray class]]) {
            if (comment.comimagelist.count > 0) {
                make.height.mas_equalTo(@(_contentHeight + GET_SCAlE_HEIGHT(55)));
            }else{
                make.height.mas_equalTo(@(_contentHeight));
            }
        }
        else if ([comment.comimagelist isKindOfClass:[NSDictionary class]])
        {
            make.height.mas_equalTo(@(_contentHeight + GET_SCAlE_HEIGHT(55)));
        }
        else
        {
            make.height.mas_equalTo(@(_contentHeight + GET_SCAlE_HEIGHT(55)));
        }
    }];

//    NSString * reply = @"商家回复:你把评论撤了，我给你退钱啊删了的发生看得见法拉克就发L发动机阿迪飞拉萨剪短发拉伸的咖啡机啊删了的开发建安大姐夫拉克丝的减肥拉伸的减肥拉丝级东方拉伸的咖啡机！";
    
    _businessReplyLabel.hidden = YES;
    
    if ([comment.reback isKindOfClass:[NSString class]]) {
        if (comment.reback.length > 1) {
            _businessReplyLabel.hidden = NO;
            NSString * reply = [NSString stringWithFormat:@"商家回复:%@",comment.reback];
            _businessReplyHeight = [self sizeForText:reply WithMaxSize:CGSizeMake(GET_SCAlE_LENGTH(300), 1000) AndWithFontSize:14].height;
            [_businessReplyBaseView updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(_businessReplyHeight));
            }];
            NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:reply];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(REDFONTCOLOR) range:NSMakeRange(0, 5)];
            [AttributedStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(GRAYFONTCOLOR) range:NSMakeRange(5, reply.length - 5)];
            _businessReplyLabel.attributedText = AttributedStr;
        }
    }
    
    self.cellHeight = (GET_SCAlE_HEIGHT(40) + 25 + _contentHeight + _businessReplyHeight);
}

- (void)commentImageTaped
{
    NSLog(@"%s", __func__);
    if (_callBackBlock) {
        _callBackBlock(_model);
    }
}

-(void)imageTaped:(CommentImageTapBlock)block
{
    _callBackBlock = block;
}

@end
