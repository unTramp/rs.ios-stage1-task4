#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    NSMutableArray* result = [self decomposer:[number integerValue] remain:[number integerValue] * [number integerValue]];
    if (result == nil) {
        return nil;
    } else {
        [result removeLastObject];
        return result;
    }
}


- (NSMutableArray*)decomposer:(NSInteger)n remain:(NSInteger)input {
    if (input == 0) {
        return [NSMutableArray arrayWithObject:[NSNumber numberWithInteger:n]];
    }
    for(NSInteger index = n - 1; index > 0; index--) {
        if ((input - index * index) >= 0) {
            NSMutableArray* r = [self decomposer:index remain:(input - (index * index))];
            if (r != nil) {
                [r addObject:[NSNumber numberWithInteger:n]];
                return r;
            }
        }
    }
    return nil;
}
@end
