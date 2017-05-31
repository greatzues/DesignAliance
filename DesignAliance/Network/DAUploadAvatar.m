//
//  DAUploadAvatar.m
//  DesignAliance
//
//  Created by zues on 17/5/5.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAUploadAvatar.h"

@implementation DAUploadAvatar

static NSString *boundary=@"GreatZuesPostRequest";

+ (void)upload:(UIImage *)photo
{
    
    NSURL *url = [NSURL URLWithString:UploadAvatar];
    
    // 2.生成可变的NSURLMutableRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // 3.修改请求方式
    request.HTTPMethod = @"POST";
    
    // 4。设置请求头
    NSString *boundary = @"Adifadlfzxfoiasdfqwer";// 这里是可以值是可以随便修改的
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];// 这些值不能乱修改
    
    // 5. 设置要上传的数据 拼接请求体
    request.HTTPBody = [self setHTTPBodyWithImage:photo boundary:boundary];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];// 那些值是官方的不能乱修的
    
    // 6.利用NSURLConnection连接网络，上传头像
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError) {
            NSLog(@"connectionError:%@",connectionError);
        }else {
            
            // 先调试一下结果：看服务器返回的结果，然后，在解析！
            NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            // 解析
            NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *message = jsonData[@"message"];
            NSString *code = [jsonData[@"code"] stringValue];
            
            if ([code isEqualToString:@"20000"]) {
                // 头像上传成功
                NSLog(@"头像上传成功");
            }else
            {
                // 头像上传失败
                NSLog(@"头像上传失败！");
            }
            
        }
    }];
}


+ (NSData *)setHTTPBodyWithImage:(UIImage *)image boundary:(NSString *)boundary
{
    // 创建第一行 \r\n
    NSString *line = [NSString stringWithFormat:@"--%@\r\n",boundary];
    
    // 追加第2行
    line = [line stringByAppendingFormat:@"Content-Disposition: form-data; name=avatar; filename=headimage.png\r\n"];
    
    // 追加第3行
    line = [line stringByAppendingFormat:@"Content-Type: image/png\r\n"];
    
    // 追加第4行
    line = [line stringByAppendingFormat:@"\r\n"];
    
    // 把以上内容转化为可变的NSMutaleData
    // 生成一个不可变的 NSData
    NSData *data = [line dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData *bufData = [[NSMutableData alloc] initWithData:data];
    
    // 把图片变成 NSData
    NSData *imgData = UIImagePNGRepresentation(image);
    
    // 追加第5行
    [bufData appendData:imgData];
    
    // 追加换行符 \r\n
    [bufData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // 追加第6行
    [bufData appendData:[[NSString stringWithFormat:@"--%@--",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return bufData;
}


@end
