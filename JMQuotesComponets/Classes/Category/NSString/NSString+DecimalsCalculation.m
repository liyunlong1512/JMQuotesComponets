//
//  NSString+DecimalsCalculation.m
//  EveryDayFresh
//
//  Created by 李云龙 on 2021/3/23.
//

#import "NSString+DecimalsCalculation.h"

// CalculationType
typedef NS_ENUM(NSInteger,CalculationType){
    CalculationAdding,
    CalculationSubtracting,
    CalculationMultiplying,
   CalculationDividing,
};

@implementation NSString (DecimalsCalculation)

// Adding
- (NSString *)yxy_stringByAdding:(NSString *)stringNumber {
    return [self yxy_stringByAdding:stringNumber withRoundingMode:NSRoundPlain scale:2];
}

- (NSString *)yxy_stringByAdding:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel {
    return [self yxy_stringByAdding:stringNumber withRoundingMode:roundingModel scale:2];
}

- (NSString *)yxy_stringByAdding:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale {
    return [self stringByCalculationType:CalculationAdding by:stringNumber roundingMode:roundingModel scale:scale];
}

// Substracting
- (NSString *)yxy_stringBySubtracting:(NSString *)stringNumber {
    return [self  yxy_stringBySubtracting:stringNumber withRoundingMode:NSRoundPlain scale:2];
}

- (NSString *)yxy_stringBySubtracting:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel {
    return [self  yxy_stringBySubtracting:stringNumber withRoundingMode:roundingModel scale:2];
}

- (NSString *)yxy_stringBySubtracting:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale {
    return [self stringByCalculationType:CalculationSubtracting by:stringNumber roundingMode:roundingModel scale:scale];
}

// Multiplying
- (NSString *)yxy_stringByMultiplyingBy:(NSString *)stringNumber {
    return [self yxy_stringByMultiplyingBy:stringNumber withRoundingMode:NSRoundPlain scale:2];
}

- (NSString *)yxy_stringByMultiplyingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel {
    return [self yxy_stringByMultiplyingBy:stringNumber withRoundingMode:roundingModel scale:2];
}

- (NSString *)yxy_stringByMultiplyingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale {
    return [self stringByCalculationType:CalculationMultiplying by:stringNumber roundingMode:roundingModel scale:scale];
}

// Dividing
- (NSString *)yxy_stringByDividingBy:(NSString *)stringNumber {
    return [self yxy_stringByDividingBy:stringNumber withRoundingMode:NSRoundPlain scale:2];
}

- (NSString *)yxy_stringByDividingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel {
    return [self yxy_stringByDividingBy:stringNumber withRoundingMode:roundingModel scale:2];
}

- (NSString *)yxy_stringByDividingBy:(NSString *)stringNumber withRoundingMode:(NSRoundingMode)roundingModel scale:(NSInteger)scale {
    return [self stringByCalculationType:CalculationDividing by:stringNumber roundingMode:roundingModel scale:scale];
}


- (NSString *)stringByCalculationType:(CalculationType)type by:(NSString *)stringNumber roundingMode:(NSRoundingMode)roundingModel scale:(NSUInteger)scale{

    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *calcuationNumber = [NSDecimalNumber decimalNumberWithString:stringNumber];
    NSDecimalNumberHandler *handler = [[NSDecimalNumberHandler alloc] initWithRoundingMode:roundingModel scale:scale raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    
    NSDecimalNumber *result = nil;
    switch (type) {
        case CalculationAdding:
            result = [selfNumber decimalNumberByAdding:calcuationNumber withBehavior:handler];
            break;
        case CalculationSubtracting:
            result =  [selfNumber decimalNumberBySubtracting:calcuationNumber withBehavior:handler];
            break;
        case CalculationMultiplying:
            result = [selfNumber decimalNumberByMultiplyingBy:calcuationNumber withBehavior:handler];
            break;
        case CalculationDividing:
            result =[selfNumber decimalNumberByDividingBy:calcuationNumber withBehavior:handler];
            break;
    }
    
    // 如果自定义了结果格式化工具使用自定义formatter
    NSNumberFormatter *numberFormatter = [self numberFormatterWithScale:scale];
    return [numberFormatter stringFromNumber:result];
}

- (NSNumberFormatter *)numberFormatterWithScale:(NSInteger)scale{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.alwaysShowsDecimalSeparator = YES;
    numberFormatter.minimumIntegerDigits = 1;
    numberFormatter.numberStyle = kCFNumberFormatterNoStyle;
    numberFormatter.minimumFractionDigits = scale;
    return numberFormatter;
}

/**
 比较两个字符串大小
 @return 返回结果
 */
-(NSComparisonResult )yxy_comparey:(NSString *)stringNumber {
    NSDecimalNumber *selfNumber = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *calcuationNumber = [NSDecimalNumber decimalNumberWithString:stringNumber];
    NSComparisonResult type = [selfNumber compare:calcuationNumber];
    
    return type;
}

/** 不四舍五入 */
- (NSString *)yxy_notRoundingAfterPoint:( NSInteger )position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:position raiseOnExactness: NO  raiseOnOverflow: NO  raiseOnUnderflow: NO  raiseOnDivideByZero: NO ];
    NSDecimalNumber *ouncesDecimal = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber* roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return roundedOunces.stringValue;
}

@end
