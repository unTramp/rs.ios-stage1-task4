#import "TelephoneFinder.h"

@implementation TelephoneFinder
- (NSArray <NSString*>*)findAllNumbersFromGivenNumber:(NSString*)number {
    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([number rangeOfCharacterFromSet:notDigits].location != NSNotFound) { return nil; }

    NSDictionary<NSNumber *, NSArray<NSNumber *>*> *comparedDigits = @{ @0: @[@8], @1: @[@2, @4], @2: @[@1, @3, @5], @3: @[@2, @6], @4: @[@1, @5, @7], @5: @[@2, @4, @6, @8], @6: @[@3, @5, @9], @7: @[@4, @8], @8: @[@0, @5, @7, @9], @9: @[@6, @8] };
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    NSInteger lenght = [number length];
    
    for (NSInteger i=0; i<lenght; i++) {
        NSRange range = NSMakeRange(i,1);
        NSString * myDigitAsString = [number substringWithRange:range];
        NSNumber *myDigitAsNSNumber = [f numberFromString:myDigitAsString];
        NSArray<NSNumber *> *neighDigits = comparedDigits[myDigitAsNSNumber];
        
        for (NSString* key in neighDigits) {
            NSString *newPhoneNumber = [number stringByReplacingCharactersInRange:range withString:[NSString stringWithFormat:@"%@", key]];
            [resultArray addObject:newPhoneNumber];
        }
    }
    
    return resultArray;
}
@end
