//
//  RegisterViewController.m
//  Lemon
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 Demon. All rights reserved.
//

#import "RegisterViewController.h"
#import "Dem_LeanCloudData.h"
#import "Dem_UserModel.h"
#import "Dem_RongData.h"

@interface RegisterViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextfield;

@property (weak, nonatomic) IBOutlet UITextField *mailAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *makeSurePassWordTextField;

@property (weak, nonatomic) IBOutlet UITextField *identifyCodeTextField;
@property (weak, nonatomic) IBOutlet UIImageView *identifyCodeMakeTextField;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *goBackButton;

@property(nonatomic,strong)Dem_UserModel *model;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoView.userInteractionEnabled = YES;
    //轻拍手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.photoView addGestureRecognizer:tap];
    [self.registerButton addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}


-(void)registAction{
    Dem_RongData *token = [[Dem_RongData alloc]init];
    [token postRequestWithName:self.userNameTextfield.text block:^(NSString *token) {
        self.model = [[Dem_UserModel alloc]init];
        self.model.photo = self.photoView.image;
        self.model.username = self.userNameTextfield.text;
        self.model.password = self.passWordTextField.text;
        //        self.model.email = self.mailAddressTextField.text;
        self.model.token = token;
        [Dem_LeanCloudData addUserWithUser:self.model block:^(NSError *value) {
            if ([value.userInfo[@"error"] isEqualToString:@"Username has already been taken"]) {
                NSLog(@"此用户已存在");
            }else{
                NSLog(@"%@",value.userInfo[@"error"]);
            }
        }];
    }];
}

#pragma mark image的点击事件
-(void)tapAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actPhotoLibrary];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self actCamera];
    }];
    [alert addAction:cancel];
    [alert addAction:act1];
    [alert addAction:act2];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark调用相册
-(void)actPhotoLibrary{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.allowsEditing = YES;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

#pragma mark调用相机
-(void)actCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.allowsEditing = YES;
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"错误" message:@"找不到相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark imagePicker代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<NSString *,id> *)editingInfo{
    self.photoView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击结束第一响应者
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)goBackButton:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
