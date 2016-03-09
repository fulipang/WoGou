//
//  FullTimeView.m
//  ios2688webshop
//
//  Created by wangchan on 16/2/23.
//  Copyright © 2016年 zhangzl. All rights reserved.
//

#import "FullTimeView.h"
#define screenWith  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface FullTimeView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSInteger yearRange;
    NSInteger dayRange;
    NSInteger startYear;
    
    NSInteger selectedYear;
    NSInteger selectedMonth;
    NSInteger selectedDay;
    NSInteger selectedHour;
    NSInteger selectedMinute;
    NSInteger selectedSecond;
    //    NSDateFormatter *dateFormatter;
    NSCalendar *calendar;
}
@end

@implementation FullTimeView

-(id)initWithFrame:(CGRect)frame

{
    if (self=[super initWithFrame:frame]) {
        [self config];
    }
    return self;
}
-(void)config
{
    CGFloat perWidth=self.frame.size.width;
    CGFloat height=self.frame.size.height;
    //0
    _fullPickView=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, perWidth, height)];
    _fullPickView.backgroundColor = UIColorFromRGB(WHITECOLOR);
    _fullPickView.dataSource=self;
    _fullPickView.delegate=self;
    [self addSubview:_fullPickView];

    
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar0 components:unitFlags fromDate:[NSDate date]];
    NSInteger year=[comps year];
    
    startYear=year-60 + 1;
    yearRange=60;
    selectedYear=2000;
    selectedMonth=1;
    selectedDay=1;
//    selectedHour=0;
//    selectedMinute=0;
//    selectedSecond=0;
    dayRange=[self isAllDay:startYear andMonth:1];
}
//默认时间的处理
-(void)setCurDate:(NSDate *)curDate
{
    //获取当前时间
    NSCalendar *calendar0 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags =  NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar0 components:unitFlags fromDate:curDate];
    NSInteger year=[comps year];
    NSInteger month=[comps month];
    NSInteger day=[comps day];
//    NSInteger hour=[comps hour];
//    NSInteger minute=[comps minute];
//    NSInteger second=[comps second];
    
    selectedYear=year;
    selectedMonth=month;
    selectedDay=day;
//    selectedHour=hour;
//    selectedMinute=minute;
//    selectedSecond=second;
    
    dayRange=[self isAllDay:year andMonth:month];
    
    NSInteger row = year - startYear;
    
    [_fullPickView selectRow:row inComponent:0 animated:true];
    [_fullPickView selectRow:month-1 inComponent:1 animated:true];
    [_fullPickView selectRow:day-1 inComponent:2 animated:true];
//    [fullPickView selectRow:hour inComponent:3 animated:true];
//    [fullPickView selectRow:minute inComponent:4 animated:true];
//    [fullPickView selectRow:second inComponent:5 animated:true];
    
    [_fullPickView reloadAllComponents];
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            return yearRange;
        }
            break;
        case 1:
        {
            return 12;
        }
            break;
        case 2:
        {
            return dayRange;
        }
            break;
        case 3:
        {
            return 24;
        }
            break;
        case 4:
        {
            return 60;
        }
            break;
        case 5:
        {
            return 60;
        }
            break;
            
        default:
            break;
    }
    return 0;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(screenWith*component/6.0, 0,screenWith/6.0, 30)];
    label.font=[UIFont systemFontOfSize:15.0];
    label.tag=component*100+row;
    label.textAlignment=NSTextAlignmentCenter;
    switch (component) {
        case 0:
        {
            label.frame=CGRectMake(5, 0,screenWith/4.0, 30);
            label.text=[NSString stringWithFormat:@"%ld年",(long)(startYear + row)];
        }
            break;
        case 1:
        {
            label.frame=CGRectMake(screenWith/4.0, 0, screenWith/8.0, 30);
            label.text=[NSString stringWithFormat:@"%ld月",(long)row+1];
        }
            break;
        case 2:
        {
            label.frame=CGRectMake(screenWith*3/8, 0, screenWith/8.0, 30);
            label.text=[NSString stringWithFormat:@"%ld日",(long)row+1];
        }
            break;
        case 3:
        {
            label.textAlignment=NSTextAlignmentRight;
            label.text=[NSString stringWithFormat:@"%ld时",(long)row];
        }
            break;
        case 4:
        {
            label.textAlignment=NSTextAlignmentRight;
           label.text=[NSString stringWithFormat:@"%ld分",(long)row];
        }
            break;
        case 5:
        {
            label.textAlignment=NSTextAlignmentRight;
            label.frame=CGRectMake(screenWith*component/6.0, 0, screenWith/6.0-5, 30);
            label.text=[NSString stringWithFormat:@"%ld秒",(long)row];
        }
            break;
            
        default:
            break;
    }
    return label;
}
// 监听picker的滑动
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
        {
            selectedYear=startYear + row;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [_fullPickView reloadComponent:2];
        }
            break;
        case 1:
        {
            selectedMonth=row+1;
            dayRange=[self isAllDay:selectedYear andMonth:selectedMonth];
            [_fullPickView reloadComponent:2];
        }
            break;
        case 2:
        {
            selectedDay=row+1;
        }
            break;
        case 3:
        {
            selectedHour=row;
        }
            break;
        case 4:
        {
            selectedMinute=row;
        }
            break;
        case 5:
        {
            selectedSecond=row;
        }
            break;
            
        default:
            break;
    }
    
//    NSString*string =[NSString stringWithFormat:@"%d-%.2d-%.2d %.2d:%.2d:%.2d",selectedYear,selectedMonth,selectedDay,selectedHour,selectedMinute,selectedSecond];
    NSString*string =[NSString stringWithFormat:@"%ld-%.2ld-%.2ld",(long)selectedYear,(long)selectedMonth,(long)selectedDay];
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate*inputDate = [inputFormatter dateFromString:string];
//    NSLog(@"date= %@", inputDate);
    
    //获取的GMT时间，要想获得某个时区的时间，以下代码可以解决这个问题
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: inputDate];
//    NSDate *localeDate = [inputDate  dateByAddingTimeInterval: interval];
//    NSLog(@"%@", localeDate);
    if ([self.delegate respondsToSelector:@selector(didFinishPickView:)]) {
        [self.delegate didFinishPickView:inputDate];
    }
    
    if ([self.delegate respondsToSelector:@selector(pickerViewScrolledWith:)]) {
        [self.delegate pickerViewScrolledWith:inputDate];
    }
}
-(NSInteger)isAllDay:(NSInteger)year andMonth:(NSInteger)month
{
    int day=0;
    switch(month)
    {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            day=31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year%4==0)&&(year%100!=0))||(year%400==0))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            break;
    }
    return day;
}
@end
