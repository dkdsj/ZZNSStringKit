//
//  NSString+Addition.m
//  GreenTomato
//
//  Created by dong on 14-5-26.
//  Copyright (c) 2014年 Jan Lion. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

+ (NSString *)getNowTimeTimestamp {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    NSString *timeSp = [NSString stringWithFormat:@"%ld000", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}

+ (NSString *)getNowTimeString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeStr = [NSString stringWithFormat:@"%@", [formatter stringFromDate:datenow]];
    //    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeStr;
}

- (NSString *)safeString:(NSString *)safeString {
    if (!safeString || safeString.length == 0) {
       return @"";
    }
    return safeString;
}

- (NSString *)replaceStringByParmas:(NSDictionary *)parmas {
    NSString *resultString = self;
    if (parmas) {
        NSArray *allKeys = [parmas allKeys];
        for (int i = 0; i < allKeys.count; i++) {
            NSString *replaceString = [parmas objectForKey:allKeys[i]];
            replaceString  = ([replaceString isEqualToString:@""]) ? @"" : replaceString;
            resultString = [resultString stringByReplacingOccurrencesOfString:allKeys[i] withString:replaceString];
        }
    }
    
    return resultString;
}

- (NSString *)unitFromString:(NSString *)unitString {
    NSString *resultUnit;
    NSInteger distance = [self integerValue];
    if (distance > 10000) {
        float unit = distance / 10000;
        resultUnit = [NSString stringWithFormat:@"%fkm", unit];
    } else {
        resultUnit = [NSString stringWithFormat:@"%ldm", (long)[self integerValue]];
    }
    return resultUnit;
}

- (NSString *)addSpaceLast {
    return [NSString stringWithFormat:@"%@  ", self];
}

/**
 *  UILable + NSString calc size with font
 */
- (CGSize)na_sizeOfNSStringWithFont:(UIFont *)font {
    CGSize sizes = [self sizeWithAttributes:@{NSFontAttributeName:font}];
    CGSize adjustedSize = CGSizeMake(ceilf(sizes.width), ceilf(sizes.height));//向上取整
    return adjustedSize;
}

- (CGFloat)na_widthOfStringDefaultFont {
    CGSize sizes = [self sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
    CGSize adjustedSize = CGSizeMake(ceilf(sizes.width), ceilf(sizes.height));//向上取整
    return adjustedSize.width;
}

/**
 *  str1:原来的时间 str2:更改的时间
 *  str1:"2015-07-16 08:45"
 *  返回日期间的秒数
 */
- (NSInteger)rw_secondsToDate:(NSString *)str2 withSS:(BOOL)SS{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    
    if (SS) {
        [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else {
        [fm setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    //[fm setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    NSDate *date1 = [fm dateFromString:self];
    NSDate *date2 = [fm dateFromString:str2];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitSecond fromDate:date1 toDate:date2 options:0];
    
    return ABS([comps second]);
}

/**
 *  时间戳格式字符串相减的整数
 *
 *  @param str @"1439278947000"-@"1439278947000"
 */
- (NSInteger)subStringFromString:(NSString *)str {
    return ABS([[NSNumber numberWithLongLong:[self longLongValue]/1000] integerValue] - 
               [[NSNumber numberWithLongLong:[str longLongValue]/1000] integerValue]);
}

/**
 *  今天/明天
 * @return 今天 @"1"
 *         明天 @"2"
 *         其他 @"3"
 */
+ (NSString *)todayOrTomorrowFromDay:(NSString *)fromDayStr {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"MM月dd日"];

    NSString *today = [fm stringFromDate:[NSDate date]];

    //month
    NSString *monthInput = [fromDayStr substringToIndex:2];
    NSString *monthToday = [today substringToIndex:2];

    //day
    NSString *dayInput = [fromDayStr substringWithRange:NSMakeRange(3, 2)];
    NSString *dayToday = [today substringWithRange:NSMakeRange(3, 2)];

    if (monthInput.intValue != monthToday.intValue) {
        return @"3";//非本月
    }

    if (dayInput.intValue > dayToday.intValue+1) {
        return @"3";//非明天
    }

    if (dayInput.intValue == dayToday.intValue+1) {
        return @"2";//明天
    }

    if (dayInput.intValue == dayToday.intValue) {
        return @"1";//今天
    }
    
    return @"3";//昨天或更早
}

/**
 *  @"1435466640000"
 *  返回 年月日
 */
- (NSString *)rw_strToDateNOHourStr {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];

    [fm setDateFormat:@"yyyy年MM月dd日"];

    //[fm setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];

    long long num = (long long)[self longLongValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];//去掉后面3个0 2015-07-16 06:44:54 +0000
    NSString *confromTimespStr = [fm stringFromDate:confromTimesp];//confromTimespStr = 2015年07月16日06:44
    //NSLog(@"confromTimesp:%@ confromTimespStr:%@", confromTimesp, confromTimespStr);
    //NSLog(@"rw_turnSecondStrToDateStr:%@", confromTimespStr);

    return confromTimespStr;
}
- (NSString *)rw_strDateYear{
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    
    [fm setDateFormat:@"yyyy-MM-dd"];
    
    //[fm setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    long long num = (long long)[self longLongValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];//去掉后面3个0 2015-07-16 06:44:54 +0000
    NSString *confromTimespStr = [fm stringFromDate:confromTimesp];//confromTimespStr = 2015年07月16日06:44
    //NSLog(@"confromTimesp:%@ confromTimespStr:%@", confromTimesp, confromTimespStr);
    //NSLog(@"rw_turnSecondStrToDateStr:%@", confromTimespStr);
    
    return confromTimespStr;
}
/**
   @"1435466640000"
   @param SS 是否要秒数
   返回 "2015-06-28 04:44"
 */
- (NSString *)rw_strToDateStr:(BOOL)SS {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];

    if (SS) {
        [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else {
        [fm setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    //[fm setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    long long num = (long long)[self longLongValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];//去掉后面3个0 2015-07-16 06:44:54 +0000
    NSString *confromTimespStr = [fm stringFromDate:confromTimesp];//confromTimespStr = 2015年07月16日06:44
    //NSLog(@"confromTimesp:%@ confromTimespStr:%@", confromTimesp, confromTimespStr);
    //NSLog(@"rw_turnSecondStrToDateStr:%@", confromTimespStr);
    
    return confromTimespStr;
}

/**
 *  @"1435466640000"
 *  @param SS 是否要秒数
 *  返回 "06月-28日 04:44"
 */
- (NSString *)rw_strToDateStrMonth:(BOOL)SS {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    
    if (SS) {
        [fm setDateFormat:@"MM月dd日 HH:mm:ss"];
    }
    else {
        [fm setDateFormat:@"MM月dd日 HH:mm"];
    }
    //[fm setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    
    long long num = (long long)[self longLongValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];//去掉后面3个0 2015-07-16 06:44:54 +0000
    NSString *confromTimespStr = [fm stringFromDate:confromTimesp];//confromTimespStr = 2015年07月16日06:44
    //NSLog(@"confromTimesp:%@ confromTimespStr:%@", confromTimesp, confromTimespStr);
    //NSLog(@"rw_turnSecondStrToDateStr:%@", confromTimespStr);
    
    return confromTimespStr;
}

/**
 *  返回当前时间的
 */
+ (NSString *)rw_strNowDateWithSecond:(BOOL)SS {
    NSDate *dateNow = [NSDate date];
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    if (SS) {
        [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    else {
        [fm setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    
    NSString *dateNowStr = [fm stringFromDate:dateNow];
    return dateNowStr;
}

/*
 *  @[@"10分钟", @"30分钟", @"1小时", @"2小时", @"5小时", @"10小时", @"1天", kDefaultDay]
 *  [self timeStringWithIncomingDateStr:@"2015年8月13日09:33" selectTime:kDefaultDay];
 */
+ (NSString *)timeStringWithIncomingDateStr:(NSString *)inputStr selectTime:(NSString *)selTime {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //[fm setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:8]];
    NSLog(@"-------inputStr:%@ select:%@", inputStr, selTime);
    
    NSDate *newDate = [fm dateFromString:[NSString stringWithFormat:@"%@", inputStr]];
//    NSLog(@"befor--:strDate:%@", [fm stringFromDate:[NSString stringWithFormat:@"%@", newDate]]);
    
    NSInteger seconds = 0;
    if ([selTime isEqualToString:kDefaultCashDay]) {//公告详情 保证金 默认8小时
        seconds = 8*3600;//18000
    } else if ([selTime isEqualToString:kDefaultPmhDay]) {//公告详情 pmh 默认10分钟
        seconds = 10*60;//60
    } else if ([selTime isEqualToString:kDefaultStartDay]) {//pmh/goods 开始 默认10分钟
        seconds = 10*60;//60
    } else if ([selTime isEqualToString:kDefaultEndDay]) {//pmh/goods 结束 默认10分钟
        seconds = 10*60;//60
    } 
    
    else if ([selTime isEqualToString:@"10分钟"]) {
        seconds = 10*60;//600
    }
    else if ([selTime isEqualToString:@"30分钟"]) {
        seconds = 30*60;//1800
    }
    else if ([selTime isEqualToString:@"1小时"]) {
        seconds = 1*3600;//3600
    }
    else if ([selTime isEqualToString:@"2小时"]) {
        seconds = 2*3600;//7200
    }
    else if ([selTime isEqualToString:@"5小时"]) {
        seconds = 5*3600;//18000
    }
    else if ([selTime isEqualToString:@"8小时"]) {
        seconds = 8*3600;//18000
    }
    else if ([selTime isEqualToString:@"10小时"]) {
        seconds = 10*3600;//36000
    }
    else if ([selTime isEqualToString:@"24小时"]) {
        seconds = 1*24*3600;//86400
    }
    else if ([selTime isEqualToString:@"1天"]) {
        seconds = 1*24*3600;//86400
    }
    else if ([selTime isEqualToString:@"1分钟"]) {
        seconds = 60;//86400
    } else {
        seconds = 0;//当前时间
    }
    
    newDate = [newDate dateByAddingTimeInterval:0-seconds];
    
    NSString *rnDate = [fm stringFromDate:newDate];
    NSLog(@"after---newDate:%@", rnDate);
    
    return rnDate;
}

/**
 *  根据给的秒数返回对应的时间字串
 */
+ (NSString *)getDayFromSeconds:(NSInteger)seconds {
    NSString *day;;
    //NSLog(@"相差%d秒 min:%f", seconds, seconds/60.0);
    if (seconds == 2*24*3600) {//172800 2天
        day = @"2天";
    }
    else if (seconds == 10*60){
        day = @"10分钟";
    }
    else if (seconds == 30*60){
        day = @"30分钟";
    }
    else if (seconds == 60){
        day = @"1分钟";
    }
    else if (seconds == 1*3600){
        day = @"1小时";
    }
    else if (seconds == 2*3600){
        day = @"2小时";
    }
    else if (seconds == 5*3600){//18000
        day = @"5小时";
    }
    else if (seconds == 8*3600){//18000
        day = @"8小时";
    }
    else if (seconds == 10*3600){//36000
        day = @"10小时";
    }
    else if (seconds == 1*24*3600){//86400
        day = @"24小时";
    }
    else {
        day = [NSString stringWithFormat:@"%d天", (int)(seconds/3600/24.0)];
    }
    
    return day;
}

/**
 *  金额数字转中文大写
 */
+ (NSString *)moneyStringWithDigitStr:(NSString *)digitString {
    NSLog(@"The begin string:%@",digitString);
    NSArray *datas = @[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    NSArray *infos = @[@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"万"];
    
    NSMutableString *processString = [[NSMutableString alloc] initWithString:digitString];
    
    //去掉前面的0
    while (processString.length != 0) {
        NSString *specifiedNumberStrAtIndex = [processString substringWithRange:NSMakeRange(0, 1)];
        int specifiedNumber = [specifiedNumberStrAtIndex intValue];
        
        //若不为数字return @"000"
        if (0 < specifiedNumber) {
            break;
        }
        
        [processString deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    // str:165047523
    // 1亿 6仟 5佰 0拾 4万 7仟 5佰 2拾 3分 ——> 壹亿 陆仟 伍佰 零拾 肆万 柒仟 伍佰 贰拾 叁分
    // creat a new mutable string
    NSMutableString *resultString = [NSMutableString string];
    int i = 0;
    int j = (int)processString.length;
    
    while (processString.length != 0) {
        
        // Add location tags after each number
        [resultString insertString:[infos objectAtIndex:i] atIndex:0];
        i++;
        
        // Obtain a character (a number), then the number corresponding uppercase characters restructuring to the ‘resultString’
        j--;
        NSString *specifiedNumberStrAtIndex = [processString substringWithRange:NSMakeRange(j, 1)];
        int specifiedNumber = [specifiedNumberStrAtIndex intValue];
        int number = specifiedNumber % 10;
        
        [resultString insertString:[datas objectAtIndex:number] atIndex:0];
        [processString deleteCharactersInRange:NSMakeRange(j, 1)];
    }
    
    NSString *moneyString = [NSString stringWithFormat:@"%@",resultString];
    if ([@"" isEqualToString:moneyString]) {
        return @"";
    }
    
    // To use regular expressions to replace specific characters
    NSError *error=nil;
    NSArray *expressions = @[@"零[拾佰仟]", @"零+亿", @"零+万", @"零+分", @"零+",@"亿万"];
    NSArray *changes = @[@"零", @"亿",@"万",@"",@"零",@"亿"];
    
    for (int k = 0; k < 6; k++) {
        NSRegularExpression *reg=[[NSRegularExpression alloc] initWithPattern:[expressions objectAtIndex:k] options:NSRegularExpressionCaseInsensitive error:&error];
        
        moneyString = [reg stringByReplacingMatchesInString:moneyString options:0 range:NSMakeRange(0, moneyString.length) withTemplate:[changes objectAtIndex:k]];
        
        //NSLog(@"moneyString = %@",moneyString);
    }
    
    NSString *tmp = moneyString;
    
    if ([[tmp substringFromIndex:moneyString.length-2] isEqualToString:@"零元"]) {
        NSMutableString *strTmp = [NSMutableString stringWithString:[tmp substringToIndex:moneyString.length-2]];
        moneyString = [strTmp stringByAppendingString:@"元"];
    }
    
    return moneyString;
}

/**
 *  截取before后面 after前面的字串
 
     NSString *keyppp = @"a_12_b_18_bidRecordCount";
     NSRange bef = [keyppp rangeOfString:@"_b_"];
     NSRange aft = [keyppp rangeOfString:@"_bidRecordCount"];
     NSString *sstr = [keyppp substringWithRange:NSMakeRange(bef.length+bef.location, aft.location-bef.length-bef.location)];
     ---->18
 */
- (NSString *)stringRangFrom:(NSString *)before toStr:(NSString *)after {
    NSRange bef = [self rangeOfString:before];
    NSRange aft = [self rangeOfString:after];
    
    return [self substringWithRange:NSMakeRange(bef.length+bef.location, aft.location-bef.length-bef.location)];
}

+ (NSString*)getUUID {  
    CFUUIDRef puuid = CFUUIDCreate(nil);  
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);  
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    
    CFRelease(puuid);  
    CFRelease(uuidString); 
    
    return result;  
}

+ (NSString *)getTimeStrFromDate:(NSDate *)date {
    NSDate *dateNow = date?:[NSDate date];
    
    NSTimeInterval time = [dateNow timeIntervalSince1970];
    
    return [NSString stringWithFormat:@"%@000", @((NSInteger)time)];
}

/**
 *  2015-12-13 格式的日期 返回星期日为第一天的对应星期
 */
- (NSString *)getWeekFromDateStr:(NSString *)dateStr {
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:@"YYYY-MM-dd"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    
    NSDate *date = [fm dateFromString:dateStr];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay) fromDate:date];
    
    NSArray *days = [@"星期日,星期一,星期二,星期三,星期四,星期五,星期六" componentsSeparatedByString:@","];
    return days[comp.weekday-1];
}

//金额格式转换double
- (double)convertAmountToDouble {
    //去掉格式
    NSMutableString *price = [NSMutableString stringWithFormat:@"%@", self];
    //NSSLogs(@"before price %@", price);
    
    if ([price containsString:@","]) {
        [price replaceOccurrencesOfString:@"," withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, price. length)];
    }
    
    if ([price containsString:@"$"]) {
        [price replaceOccurrencesOfString:@"$" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, price. length)];
    }
    
    if ([price containsString:@"¥"]) {
        [price replaceOccurrencesOfString:@"¥" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, price. length)];
    }
    
    if ([price containsString:@" "]) {
        [price replaceOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, price. length)];
    }
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"¥ ###,##0.00;"];
    NSNumber *pp = [numberFormatter numberFromString:price];
    
    return pp.doubleValue;
}

//金额格式转换
- (NSString *)convertAmountToString {
    //去掉格式
    NSMutableString *price = [NSMutableString stringWithFormat:@"%@", self];
    //NSSLogs(@"before price %@", price);
    
    if ([price containsString:@","]) {
        [price replaceOccurrencesOfString:@"," withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, price. length)];
    }
    
    if ([price containsString:@"$"]) {
        [price replaceOccurrencesOfString:@"$" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, price. length)];
    }
    
    if ([price containsString:@"¥"]) {
        [price replaceOccurrencesOfString:@"¥" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, price. length)];
    }
    //NSSLogs(@"after price %@", price);
    
    //    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    //    [numFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    //    NSString *priceStr = [numFormatter stringFromNumber:@(price.floatValue)];
    NSMutableString *priceStr = [NSMutableString stringWithString:[NSNumberFormatter localizedStringFromNumber:@(price.doubleValue) numberStyle:NSNumberFormatterCurrencyStyle]];//这一步就加了¥在前面 千位数带了,
    
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    // 设置格式
    [numberFormatter setPositiveFormat:@"¥ ###,##0.00;"];
    priceStr = [numberFormatter stringFromNumber:@(self.doubleValue)];

    
//    //$49.00
//    //将开头的$换成¥
//    if ([priceStr containsString:@"$"]) {
//        [priceStr replaceOccurrencesOfString:@"$" withString:@"¥" options:NSCaseInsensitiveSearch range:NSMakeRange(0, priceStr.length)];
//    }
    
    /** 去掉空格 ￥ 124.00  -> ￥124.00 */

    
    return priceStr;
}


- (NSInteger)na_stringLengthDelSpace {
    return [[self stringByReplacingOccurrencesOfString:@" " withString:@""] length];
}

@end
