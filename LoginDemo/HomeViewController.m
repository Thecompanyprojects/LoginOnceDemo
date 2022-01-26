//
//  HomeViewController.m
//  LoginDemo
//
//  Created by 王俊钢 on 2021/10/27.
//

#import "HomeViewController.h"
#import <ATAuthSDK/ATAuthSDK.h>
#import "WXApi.h"
#import "CertificationVC.h"

@interface HomeViewController ()
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *weichatBtn;
@property (nonatomic,strong) UIButton *sendBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWeixinAuthCode:) name:@"weixinAuth" object:nil];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.weichatBtn];
    [self.view addSubview:self.sendBtn];
}

/**
*  获取微信授权的code码
*/
-(void)getWeixinAuthCode:(NSNotification*)notification
{
    NSString *code=notification.object;
    NSLog(@"%@",code);
//    if (![code  isEqual:@"0"]) {
//        NSLog(@"hnnnnnnn%@",code);
//        [self sureWeixinLogin:code];
//    }
}
#pragma mark - getters

-(UIButton *)loginBtn
{
    if(!_loginBtn)
    {
        _loginBtn = [UIButton new];
        _loginBtn.frame = CGRectMake(20, 150, UIScreen.mainScreen.bounds.size.width-40, 55);
        [_loginBtn setTitle:@"一键登录" forState:normal];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:normal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _loginBtn.backgroundColor = [UIColor orangeColor];
        _loginBtn.layer.masksToBounds = true;
        _loginBtn.layer.cornerRadius = 10;
        [_loginBtn addTarget:self action:@selector(loginbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

-(UIButton *)weichatBtn
{
    if(!_weichatBtn)
    {
        _weichatBtn = [UIButton new];
        _weichatBtn.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/2-30, 300, 60, 60);
        [_weichatBtn setImage:[UIImage imageNamed:@"weichat"] forState:normal];
        [_weichatBtn addTarget:self action:@selector(weichatbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weichatBtn;
}

-(UIButton *)sendBtn
{
    if(!_sendBtn)
    {
        _sendBtn = [UIButton new];
        [_sendBtn addTarget:self action:@selector(sendbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn setTitle:@"学籍认证" forState:normal];
        [_sendBtn setTitleColor:[UIColor blackColor] forState:normal];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _sendBtn.backgroundColor = [UIColor orangeColor];
        _sendBtn.frame = CGRectMake(20, 380, UIScreen.mainScreen.bounds.size.width-40, 50);
        _sendBtn.layer.masksToBounds = true;
        _sendBtn.layer.cornerRadius = 8;
    }
    return _sendBtn;
}


#pragma mark - 跳转

-(void)loginbtnClick
{
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.navColor = UIColor.orangeColor;
    model.animationDuration = 0;
    model.navTitle = [[NSAttributedString alloc] initWithString:@"一键登录（全屏）" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor,NSFontAttributeName : [UIFont systemFontOfSize:20.0]}];
    //model.navIsHidden = NO;
    model.navBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
    //model.hideNavBackItem = NO;
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [rightBtn setTitle:@"更多" forState:UIControlStateNormal];
//    model.navMoreView = rightBtn;
    
    model.privacyNavColor = UIColor.orangeColor;
    model.privacyNavBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
    model.privacyNavTitleFont = [UIFont systemFontOfSize:20.0];
    model.privacyNavTitleColor = UIColor.whiteColor;
    model.logoImage = [UIImage imageNamed:@"mytel_app_launcher"];
    
//    model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
//        CGFloat width = 200;
//        CGFloat height = 100;
//        return CGRectMake(20, 120, width, height);
//    };
    
//    model.logoIsHidden = true;
//    model.sloganIsHidden = true;
    
    model.sloganText = [[NSAttributedString alloc] initWithString:@"一键登录slogan文案"attributes:@{NSForegroundColorAttributeName : UIColor.orangeColor,NSFontAttributeName : [UIFont systemFontOfSize:16.0]}];
    model.numberColor = UIColor.orangeColor;
    model.numberFont = [UIFont systemFontOfSize:30.0];
    model.loginBtnText = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:@{NSForegroundColorAttributeName : UIColor.whiteColor,NSFontAttributeName : [UIFont systemFontOfSize:20.0]}];
    
    //model.autoHideLoginLoading = NO;
    model.privacyOne = @[@"《隐私1》",@"https://www.taobao.com/"];
    model.privacyTwo = @[@"《隐私2》",@"https://www.taobao.com/"];
    model.privacyColors = @[UIColor.lightGrayColor, UIColor.orangeColor];
    model.privacyAlignment = NSTextAlignmentCenter;
    model.privacyFont = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0];
    model.privacyOperatorPreText = @"《";
    model.privacyOperatorSufText = @"》";
    //model.checkBoxIsHidden = NO;
    model.checkBoxWH = 17.0;
    
    model.changeBtnTitle = [[NSAttributedString alloc] initWithString:@"切换到其他方式" attributes:@{NSForegroundColorAttributeName : UIColor.orangeColor,NSFontAttributeName : [UIFont systemFontOfSize:18.0]}];
    //model.changeBtnIsHidden = NO;
    //model.prefersStatusBarHidden = NO;
    model.preferredStatusBarStyle = UIStatusBarStyleLightContent;
    //model.presentDirection = PNSPresentationDirectionBottom;
        
    //授权页默认控件布局调整
    //model.navBackButtonFrameBlock =
    //model.navTitleFrameBlock =
    model.navMoreViewFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat width = superViewSize.height;
        CGFloat height = width;
        return CGRectMake(superViewSize.width - 15 - width, 0, width, height);
    };
//        model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
//            if ([self isHorizontal:screenSize]) {
//                frame.origin.y = 20;
//                return frame;
//            }
//            return frame;
//        };
//        model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
//            if ([self isHorizontal:screenSize]) {
//                return CGRectZero; //横屏时模拟隐藏该控件
//            } else {
//                return CGRectMake(0, 140, superViewSize.width, frame.size.height);
//            }
//        };
//        model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
//            if ([self isHorizontal:screenSize]) {
//                frame.origin.y = 140;
//            }
//            return frame;
//        };
//        model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
//            if ([self isHorizontal:screenSize]) {
//                frame.origin.y = 185;
//            }
//            return frame;
//        };
//        model.changeBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
//            if ([self isHorizontal:screenSize]) {
//                return CGRectZero; //横屏时模拟隐藏该控件
//            } else {
//                return CGRectMake(10, frame.origin.y, superViewSize.width - 20, 30);
//            }
//        };
        //model.privacyFrameBlock =
        
        //添加自定义控件并对自定义控件进行布局
        __block UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [customBtn setTitle:@"这是一个自定义控件" forState:UIControlStateNormal];
        [customBtn setBackgroundColor:UIColor.redColor];
        customBtn.frame = CGRectMake(0, 0, 230, 40);
        model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
            [superCustomView addSubview:customBtn];
        };
        model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
            CGRect frame = customBtn.frame;
            frame.origin.x = (contentViewFrame.size.width - frame.size.width) * 0.5;
            frame.origin.y = CGRectGetMinY(privacyFrame) - frame.size.height - 20;
            frame.size.width = contentViewFrame.size.width - frame.origin.x * 2;
            customBtn.frame = frame;
        };
    // 横竖屏切换
   // model.supportedInterfaceOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
    // 仅支持竖屏
    model.supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
    // 仅支持横屏
    //model.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscape;
            

    [[TXCommonHandler sharedInstance] accelerateLoginPageWithTimeout:1 complete:^(NSDictionary * _Nonnull resultDic) {
       if ([PNSCodeSuccess isEqualToString:[resultDic objectForKey:@"resultCode"]] == NO)     {
           //[ProgressHUD showError:@"取号，加速授权⻚弹起失败"];
           [self showResult:resultDic];
           return ;
       }

        
       [[TXCommonHandler sharedInstance] getLoginTokenWithTimeout:1 controller:self model:model complete:^(NSDictionary * _Nonnull resultDic){

           NSString *code = [resultDic objectForKey:@"resultCode"];
           if ([PNSCodeLoginControllerPresentSuccess isEqualToString:code]) {
               //[ProgressHUD showSuccess:@"弹起授权⻚成功"];
           } else if ([PNSCodeLoginControllerClickCancel isEqualToString:code]){
              // [ProgressHUD showSuccess:@"点击了授权⻚的返回"];
           } else if ([PNSCodeLoginControllerClickChangeBtn isEqualToString:code]) {
               //[ProgressHUD showSuccess:@"点击切换其他登录⽅式按钮"];
           } else if ([PNSCodeLoginControllerClickLoginBtn isEqualToString:code]) {
               if ([[resultDic objectForKey:@"isChecked"] boolValue] == YES) {
                 //  [ProgressHUD showSuccess:@"点击了登录按钮，check box选 中，SDK内部接着    会去获取登录Token"];
               } else {
                  // [ProgressHUD showSuccess:@"点击了登录按钮，check box选 中，SDK内部不会    去获取登录Token"];
               }
           } else if ([PNSCodeLoginControllerClickCheckBoxBtn isEqualToString:code]) {
              // [ProgressHUD showSuccess:@"点击check box"];
           } else if ([PNSCodeLoginControllerClickProtocol isEqualToString:code]) {
              // [ProgressHUD showSuccess:@"点击了协议富⽂本"];
           } else if ([PNSCodeSuccess isEqualToString:code]) {
               //点击登录按钮获取登录Token成功回调
//               NSString *token = [resultDic objectForKey:@"token"];
//               //下⾯拿Token去服务器换⼿机号，下⾯仅做参考
//               [PNSVerifyTopRequest requestLoginWithToken:token complet e:^(BOOL     isSuccess, NSString * _Nonnull msg, NSDictionary * _Nonnull data) {
//                   NSString *popCode = [data objectForKey:@"code"];
//                   NSDictionary *module = [data objectForKey:@"module"] ;
//                   NSString *mobile = module[@"mobile"];
//                   if ([popCode isEqualToString:@"OK"] && mobile.length > 0) {
//                       [ProgressHUD showSuccess:@"⼀键登录成功"];
//                   } else {
//                       [ProgressHUD showSuccess:@"⼀键登录失败"];
//                   }
//                  dispatch_async(dispatch_get_main_queue(), ^{
//                       [[TXCommonHandler sharedInstance] cancelLoginVCA nimated:YES     complete:nil];
//                   });
//                   [weakSelf showResult:data];
//               }];
           } else {
               //[ProgressHUD showError:@"获取登录Token失败"];
           }
           [self showResult:resultDic];
       }];
    }];
}

-(void)showResult:(NSDictionary *)resultDic{
    
}

-(void)weichatbtnClick{
    NSLog(@"微信登录");
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"wx_oauth_authorization_state";
//    [WXApi sendReq:req completion:^(BOOL success) {
//
//    }];
    [WXApi sendReq:req];
}

-(void)sendbtnClick
{
    CertificationVC *VC = [CertificationVC new];
    [self.navigationController pushViewController:VC animated:true];
}

@end
