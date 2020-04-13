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
    NSMutableArray *allNodes = [[NSMutableArray alloc] initWithArray:[self nodeCreator:(count)]];
    _counter = count-1;
    NSMutableString *resultString = [[NSMutableString alloc] initWithString:@"[0,"];
    _resultNodeValuesArray = [[NSMutableArray alloc] init];
    NSLog(@"%ld", allNodes.count);
    
    if (count == 0) {
        return @"[]";
    } else if (count == 1) {
        return @"[[0]]";
    } else if (count % 2 == 0) {
        return  @"[]";
    }
    
    for (NSInteger i = 0; i < allNodes.count; i++) {
        Node *myNode = allNodes[i];
        [self stringToResult:myNode];
        [self stringToResult:myNode.left];
        [self stringToResult:myNode.right];
        [self stringToResult:myNode.left.left];
        [self stringToResult:myNode.left.right];
        [self stringToResult:myNode.right.left];
        [self stringToResult:myNode.right.right];
        [resultString appendString:[_resultNodeValuesArray componentsJoinedByString:@","]];
        [resultString appendString:@"]"];
        _counter = count-1;
        [_resultNodeValuesArray removeAllObjects];
        [resultString appendString:@"[0,"];
    }
    
    
    
    resultString = [resultString substringToIndex:[resultString length] - 3];
    return resultString;
}

- (void)stringToResult: (Node*) node {
    if (_counter != 0 && node != nil) {
        if (node.left != nil && node.right != nil) {
            [_resultNodeValuesArray addObject:@"0"];
            [_resultNodeValuesArray addObject:@"0"];
            _counter -= 2;
        } else {
            [_resultNodeValuesArray addObject:@"null"];
            [_resultNodeValuesArray addObject:@"null"];
        }
    }
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
