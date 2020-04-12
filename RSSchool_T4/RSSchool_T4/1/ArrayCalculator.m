#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    NSArray* checkedArray = [self filteredArray:array];
    if (checkedArray.count == 0) {
        return 0;
    }
    NSMutableArray* maxValues = [[NSMutableArray alloc] init];
    NSMutableArray* minValues = [[NSMutableArray alloc] init];
    NSMutableArray* numbersMinusMaxValue = [NSMutableArray arrayWithArray:checkedArray];
    NSMutableArray* numbersMinusMinValue = [NSMutableArray arrayWithArray:checkedArray];
    NSInteger counterMax = numberOfItems;
    NSInteger counterMin = numberOfItems;
    if (numberOfItems >= checkedArray.count) {
        NSInteger result = 1;
        for (NSNumber* element in checkedArray) {
            result *= element.integerValue;
        }
        return result;
    }
    while (counterMax > 0) {
        counterMax -= 1;
        for (NSInteger index = 0; index < numbersMinusMaxValue.count; index++) {
            NSNumber* maxValueOfArray = [numbersMinusMaxValue valueForKeyPath:@"@max.self"];
            if ([numbersMinusMaxValue[index] integerValue] == maxValueOfArray.integerValue && [numbersMinusMaxValue[index] integerValue] > 0) {
                [maxValues addObject:maxValueOfArray];
                [numbersMinusMaxValue removeObjectAtIndex:index];
                break;
            }
        }
    }
    while (counterMin > 0) {
        counterMin -= 1;
        for (NSInteger index = 0; index < numbersMinusMinValue.count; index++) {
            NSNumber* minValueOfArray = [numbersMinusMinValue valueForKeyPath:@"@min.self"];
            if ([numbersMinusMinValue[index] integerValue] == minValueOfArray.integerValue && [numbersMinusMinValue[index] integerValue] < 0) {
                [minValues addObject:minValueOfArray];
                [numbersMinusMinValue removeObjectAtIndex:index];
                break;
            }
        }
    }
    if (minValues.count > 1) {
        NSInteger multiplyOfMaxValues = ([maxValues[maxValues.count - 1] integerValue] * [maxValues[maxValues.count - 2] integerValue]);
        NSInteger multiplyOfMinValues = [minValues[0] integerValue] * [minValues[1] integerValue];
        if (multiplyOfMaxValues > multiplyOfMinValues) {
            NSInteger result = 1;
            for (NSNumber* element in maxValues) {
                result *= element.integerValue;
            }
            return result;
        } else {
            maxValues[maxValues.count - 1] = minValues[0];
            maxValues[maxValues.count - 2] = minValues[1];
            NSInteger result = 1;
            for (NSNumber* element in maxValues) {
                result *= element.integerValue;
            }
            return result;
        }
    } else {
        NSInteger result = 1;
        for (NSNumber* element in maxValues) {
            result *= element.integerValue;
        }
        return result;
    }
}


+ (NSArray*)filteredArray:(NSArray*)inputArray {
    NSMutableArray* result = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < inputArray.count; index++) {
        if ([inputArray[index] isKindOfClass:[NSNumber class]]) {
            [result addObject:inputArray[index]];
        } else {
            continue;
        }
    }
    return result;
}
@end
