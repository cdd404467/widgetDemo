//
//  ModelTestVC.m
//  widgetDemo
//
//  Created by caidd on 2024/11/22.
//

#import "ModelTestVC.h"
#import <ARKit/ARKit.h>
#import <SceneKit/SceneKit.h>
#import <QuickLook/QuickLook.h>
#import "CustomQuickLookVC.h"

@interface ModelTestVC ()<ARSCNViewDelegate,QLPreviewControllerDataSource,QLPreviewControllerDelegate,SCNSceneRendererDelegate>
@property(nonatomic, strong)SCNView *scnView;
@property (nonatomic, strong) QLPreviewController *quickLookController;
@property (nonatomic, strong) SCNScene *scene;
@property (nonatomic, strong) SCNNode *modelNode;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@end

@implementation ModelTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.title = @"model test";
    
    if (self.type == 1) {
        [self load3dModel_scene];
    } else {
        [self load3dModel_quicklook];
    }
}

- (void)load3dModel_scene {
//    NSURL *usdzURL = [[NSBundle mainBundle] URLForResource:@"widgetModel" withExtension:@"usdz"];
//                self.scene = [SCNScene sceneWithURL:usdzURL options:nil error:nil];
    
//    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    self.activityIndicator.frame = CGRectMake(0, 0, 100, 100);
//    self.activityIndicator.center = self.view.center;
//    [self.view addSubview:self.activityIndicator];
//    self.activityIndicator.hidesWhenStopped = YES;
//    [self.activityIndicator startAnimating];
    
    self.scnView = [[SCNView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.width)];
    self.scnView.delegate = self;
    self.scnView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.scnView];
    

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.scene = [SCNScene sceneNamed:@"widgetModel.usdz" inDirectory:nil options:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.scene) {
                self.scnView.scene = self.scene;

        //        // 设置环境光
                SCNNode *lightNode = [SCNNode node];
                lightNode.light = [SCNLight light];
                lightNode.light.type = SCNLightTypeAmbient;
                lightNode.light.color = [UIColor whiteColor];
                lightNode.position = SCNVector3Make(10, 10, 0); // 设置灯光位置，从上方照射
                [self.scene.rootNode addChildNode:lightNode];
                
            }
            
            self.scnView.allowsCameraControl = YES;
        });
    });
    
    UIButton *left_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [left_btn setTitle:@"Rotate left" forState:UIControlStateNormal];
    [left_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    left_btn.backgroundColor = UIColor.blackColor;
    left_btn.titleLabel.font = [UIFont systemFontOfSize:18];
    left_btn.layer.cornerRadius = 10;
    [left_btn addTarget:self action:@selector(leftControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:left_btn];
    left_btn.frame = CGRectMake(50, 200 + self.view.frame.size.width, (self.view.frame.size.width - 150) / 2, 50);
    
    UIButton *right_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [right_btn setTitle:@"Rotate right" forState:UIControlStateNormal];
    [right_btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    right_btn.backgroundColor = UIColor.blackColor;
    right_btn.titleLabel.font = [UIFont systemFontOfSize:18];
    right_btn.layer.cornerRadius = 10;
    [right_btn addTarget:self action:@selector(rightControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right_btn];
    right_btn.frame = CGRectMake((self.view.frame.size.width - 150)/2 + 100, 200 + self.view.frame.size.width, (self.view.frame.size.width - 150)/2, 50);
}

- (void)leftControl {
    SCNNode *modelNode = self.scnView.scene.rootNode;
    if (modelNode) {
        SCNAction *rotateLeft = [SCNAction rotateByX:0 y:-M_PI_4 / 2 z:0 duration:1.0];
        [modelNode runAction:rotateLeft];
    }
}

- (void)rightControl {
    SCNNode *modelNode = self.scnView.scene.rootNode;
    if (modelNode) {
        SCNAction *rotateRight = [SCNAction rotateByX:0 y:M_PI_4 / 2 z:0 duration:1.0];
        [modelNode runAction:rotateRight];
    }
}


//            SCNNode *modelRootNode = self.scene.rootNode;
//                // 设置缩放比例为0.5（缩小为原来的一半）
//                modelRootNode.scale = SCNVector3Make(0.5, 0.5, 0.5);
//    NSURL *usdzURL = [[NSBundle mainBundle] URLForResource:@"widgetModel" withExtension:@"usdz"];
//            self.scene = [SCNScene sceneWithURL:usdzURL options:nil error:nil];
//        // 设置相机位置
//        SCNNode *cameraNode = [SCNNode node];
//        cameraNode.camera = [SCNCamera camera];
//        cameraNode.position = SCNVector3Make(0, 0, 5);
//        [self.scene.rootNode addChildNode:cameraNode];

- (void)load3dModel_quicklook {
    QLPreviewController *quickLookController = [[QLPreviewController alloc] init];
    quickLookController.dataSource = self;
    [self presentViewController:quickLookController animated:YES completion:nil];
}


- (void)renderer:(id <SCNSceneRenderer>)renderer didRenderScene:(SCNScene *)scene atTime:(NSTimeInterval)time {
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (self.activityIndicator.isAnimating) {
//            [self.activityIndicator stopAnimating];
//        }
    });
}


- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}

- (id<QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSURL *usdzURL = [[NSBundle mainBundle] URLForResource:@"widgetModel" withExtension:@"usdz"];
    return usdzURL;
}
@end
