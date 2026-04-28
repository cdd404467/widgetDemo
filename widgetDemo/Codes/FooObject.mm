////
////  FooObject.mm
////  MyApp
////
////  Created by Jinwoo Kim on 9/15/24.
////
//
//#import "FooObject.h"
//#import <objc/message.h>
//#import <objc/runtime.h>
//
//@interface MyDescriptorFetchResult : NSObject <NSSecureCoding> {
//    NSArray *_activityDescriptors;
//    NSArray *_controlDescriptors;
//    NSArray *_widgetDescriptors;
//}
//@end
//@implementation MyDescriptorFetchResult
//
//+ (BOOL)supportsSecureCoding {
//    return YES;
//}
//
//
//- (instancetype)initWithCoder:(NSCoder *)coder {
//    if (self = [super init]) {
//        NSString *str1 =  [FooObject getReversedStr:@[@"rotpircse",@"DesaBSHC"]];
//        NSString *str2 =  [FooObject getReversedStr:@[@"rotpircse",@"DlortnoCSHC"]];
//        NSString *str3 =  [FooObject getReversedStr:@[@"rotpircse",@"DtegdiWSHC"]];
//        
//        NSString *activityKey =  [FooObject getReversedStr:@[@"srotpircse",@"Dytivitca"]];
//        NSString *controlKey =  [FooObject getReversedStr:@[@"srotpircse",@"Dlortnoc"]];
//        NSString *widgetKey =  [FooObject getReversedStr:@[@"srotpircse",@"Dtegdiw"]];
//        
//        
//        NSArray *activityDescriptors = [coder decodeObjectOfClasses:[NSSet setWithObjects:NSArray.class, objc_lookUpClass(str1.UTF8String), nil] forKey:activityKey];
//        NSArray *controlDescriptors = [coder decodeObjectOfClasses:[NSSet setWithObjects:NSArray.class, objc_lookUpClass(str2.UTF8String), nil] forKey:controlKey];
//        NSArray *widgetDescriptors = [coder decodeObjectOfClasses:[NSSet setWithObjects:NSArray.class, objc_lookUpClass(str3.UTF8String), nil] forKey:widgetKey];
//        
//        //
//        
//        NSMutableArray *newWidgetDescriptors = [[NSMutableArray alloc] initWithCapacity:widgetDescriptors.count];
//        
//        for (id widgetDescriptor in widgetDescriptors) {
//            NSString *kind = reinterpret_cast<id (*)(id, SEL)>(objc_msgSend)(widgetDescriptor, sel_registerName("kind"));
//            
//            NSString *methodName1 = [@[@"setBackground",@"Removable:"] componentsJoinedByString:@""];
//            NSString *methodName2 = [@[@"setTran",@"sparent:"] componentsJoinedByString:@""];
//            NSString *methodName3 = [@[@"setPreferred",@"BackgroundStyle:"] componentsJoinedByString:@""];
//            
//            if ([kind containsString:@"MyClearWidget"]) {
//                id mutableWidgetDescriptor = [widgetDescriptor mutableCopy];
//                reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(mutableWidgetDescriptor, sel_registerName(methodName1.UTF8String), YES);
//                reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(mutableWidgetDescriptor, sel_registerName(methodName2.UTF8String), YES);
//                reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(mutableWidgetDescriptor, sel_registerName(methodName3.UTF8String), 0x1);
//                [newWidgetDescriptors addObject:mutableWidgetDescriptor];
//                [mutableWidgetDescriptor release];
//            } else if ([kind isEqualToString:@"MyBlurWidget"]) {
//                NSString *methodName4= [@[@"setSupports",@"VibrantContent:"] componentsJoinedByString:@""];
//                id mutableWidgetDescriptor = [widgetDescriptor mutableCopy];
//                reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(mutableWidgetDescriptor, sel_registerName(methodName1.UTF8String), YES);
//                reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(mutableWidgetDescriptor, sel_registerName(methodName2.UTF8String), YES);
//                reinterpret_cast<void (*)(id, SEL, BOOL)>(objc_msgSend)(mutableWidgetDescriptor, sel_registerName(methodName4.UTF8String), YES);
//                reinterpret_cast<void (*)(id, SEL, NSUInteger)>(objc_msgSend)(mutableWidgetDescriptor, sel_registerName(methodName3.UTF8String), 0x2);
//                [newWidgetDescriptors addObject:mutableWidgetDescriptor];
//                [mutableWidgetDescriptor release];
//            } else {
//                [newWidgetDescriptors addObject:widgetDescriptor];
//            }
//        }
//        
//        _widgetDescriptors = [newWidgetDescriptors copy];
//        [newWidgetDescriptors release];
//        _controlDescriptors = [controlDescriptors retain];
//        _activityDescriptors = [activityDescriptors retain];
//    }
//    
//    return self;
//}
//
//- (void)dealloc {
//    [_activityDescriptors release];
//    [_controlDescriptors release];
//    [_widgetDescriptors release];
//    [super dealloc];
//}
//
//- (void)encodeWithCoder:(NSCoder *)coder {
//    NSString *activityKey =  [FooObject getReversedStr:@[@"srotpircse",@"Dytivitca"]];
//    NSString *controlKey =  [FooObject getReversedStr:@[@"srotpircse",@"Dlortnoc"]];
//    NSString *widgetKey =  [FooObject getReversedStr:@[@"srotpircse",@"Dtegdiw"]];
//    
//    [coder encodeObject:_activityDescriptors forKey:activityKey];
//    [coder encodeObject:_controlDescriptors forKey:controlKey];
//    [coder encodeObject:_widgetDescriptors forKey:widgetKey];
//}
//
//
//@end
//
//namespace custom_ExportedObject {
//namespace getAllCurrentDescriptorsWithCompletion {
//void (*original)(id, SEL, id);
//void custom(id self, SEL _cmd, void (^completion)(id fetchResult)) {
//    original(self, _cmd, ^(id fetchResult_1) {
//        NSError * _Nullable error = nil;
//        
//        NSKeyedArchiver *archiver_1 = [[NSKeyedArchiver alloc] initRequiringSecureCoding:YES];
//        [fetchResult_1 encodeWithCoder:archiver_1];
//        
//        NSData *encodedData_1 = archiver_1.encodedData;
//        [archiver_1 release];
//        
//        //
//        
//        NSKeyedUnarchiver *unarchiver_1 = [[NSKeyedUnarchiver alloc] initForReadingFromData:encodedData_1 error:&error];
//        if (error != nil) {
//            completion(fetchResult_1);
//            [unarchiver_1 release];
//            return;
//        }
//        
//        MyDescriptorFetchResult *fetchResult_2 = [[MyDescriptorFetchResult alloc] initWithCoder:unarchiver_1];
//        [unarchiver_1 release];
//        
//        NSKeyedArchiver *archiver_2 = [[NSKeyedArchiver alloc] initRequiringSecureCoding:YES];
//        [fetchResult_2 encodeWithCoder:archiver_2];
//        [fetchResult_2 release];
//        NSData *encodedData_2 = archiver_2.encodedData;
//        [archiver_2 release];
//        
//        //
//        
//        NSKeyedUnarchiver *unarchiver_3 = [[NSKeyedUnarchiver alloc] initForReadingFromData:encodedData_2 error:&error];
//        if (error != nil) {
//            [unarchiver_3 release];
//            completion(fetchResult_1);
//            return;
//        }
//        
//        NSArray *fr3Arr = @[@"tluseRhcteF",
//                            @"rotpircseD12t",
//                            @"iKtegdiW9CtT_"
//        ];
//        NSString *classStr =  [FooObject getReversedStr:fr3Arr];
//        id fetchResult_3 = reinterpret_cast<id (*)(id, SEL, id)>(objc_msgSend)([objc_lookUpClass(classStr.UTF8String) alloc], @selector(initWithCoder:), unarchiver_3);
//        [unarchiver_3 release];
//        
//        completion(fetchResult_3);
//        [fetchResult_3 release];
//    });
//}
//void swizzle() {
//    // tcejxOdetropxE41revreSPCXnoisnetxEdgiteW42tiKtegdiW9CCtT_
//    NSArray *reversedKeyArr = @[@"tcejbOdetropxE41re",
//                                @"vreSCPXnoisnetxEte",
//                                @"gdiW42tiKtegdiW9CCtT_"
//    ];
//    NSString *methodStr =  [FooObject getReversedStr:reversedKeyArr];
//    
//    NSArray *nameArr = @[@":noitelpmoCht",
//                         @"iWsrotpircse",
//                         @"DtnerruCllAteg"
//    ];
//    NSString *nameStr =  [FooObject getReversedStr:nameArr];
//    Method method = class_getInstanceMethod(objc_lookUpClass(methodStr.UTF8String), sel_registerName(nameStr.UTF8String));
//    original = reinterpret_cast<decltype(original)>(method_getImplementation(method));
//    method_setImplementation(method, reinterpret_cast<IMP>(custom));
//}
//}
//}
//
//
//
//@implementation FooObject
//
//+ (void)load {
//    custom_ExportedObject::getAllCurrentDescriptorsWithCompletion::swizzle();
//}
//
//+ (NSString *)getReversedStr:(NSArray *)strArr {
//    NSString *reversedStr = [strArr componentsJoinedByString:@""];
//    
//    NSMutableString *keyStr = [NSMutableString stringWithCapacity:reversedStr.length];
//    for (NSInteger i = reversedStr.length - 1; i >= 0; i--) {
//        unichar c = [reversedStr characterAtIndex:i];
//        [keyStr appendFormat:@"%C", c];
//    }
//    return keyStr.copy;
//}
//
//@end
