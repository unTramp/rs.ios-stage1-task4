#import "FullBinaryTrees.h"

@interface Node : NSObject
@property (nonatomic, assign) NSNumber *value;
@property (nonatomic, strong) Node *left;
@property (nonatomic, strong) Node *right;
@end

@implementation Node

- (instancetype) initWithValue:(NSNumber *)value {
    if (self = [super init]) {
        self.value = value;
        self.left = nil;
        self.right = nil;
    }
    return self;
}

@end

@implementation FullBinaryTrees
- (NSString *)stringForNodeCount:(NSInteger)count {
    
    NSArray *allNodes = [self nodeCreator:count];
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSLog(@"%ld", allNodes.count);
    
    if (count == 0) {
        [resultString appendString: @"[]"];
    } else if (count == 1) {
        [resultString appendString: @"[[0]]"];
    } else if (count % 2 == 0) {
        [resultString appendString: @"[]"];
    }
    
    return resultString;
}
    
- (NSArray *)nodeCreator:(NSInteger)N {
    NSMutableArray *resultArray = [[NSMutableArray alloc]init];

    if (N == 1) {
        Node *myNode = [[Node alloc]init];
        [resultArray addObject:myNode];
    } else if (N % 2) {
        for (NSInteger i = 0; i < N; ++i) {
            NSArray *left = [self nodeCreator:i];
            NSArray *right = [self nodeCreator:N - i - 1];
            for (Node *leftChild in left) {
                for (Node *rightChild in right) {
                    Node *node = [[Node alloc]init];
                    node.left = leftChild;
                    node.right = rightChild;
                    [resultArray addObject:node];
                }
            }
        }
    }
    return [resultArray copy];
}

@end
