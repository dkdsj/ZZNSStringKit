//
//  NSString+Addition.h
//  GreenTomato
//
//  Created by dong on 14-5-26.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//修改默认时间 同时要修改对应的秒数 暂时不加标点的默认值先用拍卖会的吧
#define kDefaultCashDay  @" 8小时 "
#define kDefaultPmhDay   @"10分钟 "

#define kDefaultStartDay @"10分钟 "
#define kDefaultEndDay   @"10分钟 "

@interface NSString (Addition)


/**
 获取当前时间戳 （以毫秒为单位）
 */
+ (NSString *)getNowTimeTimestamp;
+ (NSString *)getNowTimeTimestamp123;
+ (NSString *)getNowTimeTimestamp456;
+ (NSString *)getNowTimeTimestamp156;


/**
 @"YYYY-MM-dd HH:mm:ss"
 */
+ (NSString *)getNowTimeString;
- (NSString *)replaceStringByParmas:(NSDictionary *)parmas;
- (NSString *)unitFromString:(NSString *)unitString;

- (NSString *)addSpaceLast;
- (NSString *)rw_strDateYear;
/**
 *  UILable + NSString calc size with font
 */
- (CGSize)na_sizeOfNSStringWithFont:(UIFont *)font;

/**
 *  string默认长度
 */
- (CGFloat)na_widthOfStringDefaultFont;

/**
 *   str1:原来的时间 str2:更改的时间
 *   str1:"2015-07-16 08:45"
 *  @return 返回日期间的秒数
 */
- (NSInteger)rw_secondsToDate:(NSString *)str2 withSS:(BOOL)SS;

/**
 *  时间戳格式字符串相减的整数
 *
 *  @param str @"1439278947000"-@"1439278947000"
 */
- (NSInteger)subStringFromString:(NSString *)str;

/**
 *  今天/明天
 * @param  fromDayStr @"08月14日"
 * @return 今天 @"1" 
 *         明天 @"2"
 *         其他 @"3"
 */
+ (NSString *)todayOrTomorrowFromDay:(NSString *)fromDayStr;

/**
 *  @"1435466640000"
 *  返回 年月日
 */
- (NSString *)rw_strToDateNOHourStr;

/**
 *  @"1435466640000" 将秒数字串转为日期字串
 *  @param SS 是否要秒数
 *  @return 返回 "2015-06-28 04:44"
 */
- (NSString *)rw_strToDateStr:(BOOL)SS;

/**
 *  @"1435466640000" 将秒数字串转为不带年份日期字串
 *  @param SS 是否要秒数
 *  @return 返回 "06月-28日 04:44"
 */
- (NSString *)rw_strToDateStrMonth:(BOOL)SS;

/**
 *  返回当前时间的 @"yyyy-MM-dd HH:mm:ss"/@"yyyy-MM-dd HH:mm"
 */
+ (NSString *)rw_strNowDateWithSecond:(BOOL)SS;

/*
 *  @[@"10分钟", @"30分钟", @"1小时", @"2小时", @"5小时", @"10小时", @"1天", @kDefaultDay]
 *  [self timeStringWithIncomingDateStr:@"2015年8月13日09:33" selectTime:@kDefaultDay];
 某个日期前xx分钟/小时的时间字串
 */
+ (NSString *)timeStringWithIncomingDateStr:(NSString *)inputStr selectTime:(NSString *)selTime;

/**
 *  根据给的秒数返回对应的时间字串
 */
+ (NSString *)getDayFromSeconds:(NSInteger)seconds;

/**
 *  金额数字转中文大写
 */
+ (NSString *)moneyStringWithDigitStr:(NSString *)digitString;

/**
 *  截取before后面 after前面的字串
 */
- (NSString *)stringRangFrom:(NSString *)before toStr:(NSString *)after;

/**
 *  UUID
 */
+ (NSString*)getUUID;

/**
 *  返回给定日期的时间戳
 */
+ (NSString *)getTimeStrFromDate:(NSDate *)date;

/**
 *  2015-12-13 格式的日期 返回对应星期
 */
- (NSString *)getWeekFromDateStr:(NSString *)dateStr;

/**
 * 金额格式转换double
 */
- (double)convertAmountToDouble;

/**
 *  金额格式转换 ¥4,445.0->445.0   $45.0 ->45.0
 *  可以为以下接受格式 45 45.31 45,987.01 ¥43 ¥45.0 ¥4,445.0 $43 $45.0 $4,445.0
 @return ¥45,314.42 ¥78.9
 */
- (NSString *)convertAmountToString;



//去掉空白 返回长度
- (NSInteger)na_stringLengthDelSpace;

@end
