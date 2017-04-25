//
//  DABaseOperation.m
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DABaseOperation.h"

@implementation DABaseOperation

- (id)initWithDelegate:(id<DAOperationDelegate>)delegate opInfo:(NSDictionary *)opInfo{
    self = [super init]; //初始化
    if (self) {
        _delegate = delegate;
        _opInfo = opInfo;
        _totalLength = 0;
    }
    
    return self;
}
//取消异步请求加载
- (void)cancelOp{
    if (_connection != nil) {
        BASE_INFO_FUN(@"_connection dealloc cancel");
        [_connection cancel];
    }
    _connection = nil;
}

-(void)dealloc{
    if (_connection != nil){
        BASE_INFO_FUN(@"_connection dealloc cancel");
        [_connection cancel];
    }
    _connection = nil;
    _delegate = nil;
}

- (NSTimeInterval)timeoutInteval{
    return DARequestTimeout;
}

- (NSMutableURLRequest *)urlRequest{
    NSString *urlString = [_opInfo objectForKey:@"url"];
    id body = [_opInfo objectForKey:@"body"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    BASE_INFO_FUN(urlString);
    
    if (body != nil) {
        [request setHTTPMethod:HTTPPOST];
        if ([body isKindOfClass:[NSString class]]) { //返回实例是否是参数的类实例
            [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]]; //返回一个给data编码的对象
            BASE_INFO_FUN(body);
        }else{
            [request setHTTPBody:body];//接受者的请求体
        }
    }else {
        [request setHTTPMethod:HTTPGET];
    }
    [request setTimeoutInterval:[self timeoutInteval]];
    
    return request;
}


- (void)executeOp{
    //这里建议我使用NSSURLSession，但是我没找到对应的方法，所以这个后面之后再修改
    _connection = [[NSURLConnection alloc] initWithRequest:[self urlRequest] delegate:self];
}

//解析数据
- (void)parseData:(NSData *)data{
    if (data.length <= 0) { //返回的长度大于0，认为成功
        [self parseSuccess:nil jsonString:nil];
        return;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [FxJsonUtility jsonValueFromString:jsonString];
    
    NSString *result = [dict objectForKey:NetResult];
    if ([result isEqualToString:NetOk]) {
        [self parseSuccess:dict jsonString:jsonString];
    }else {
        [self parseFail:dict];
    }
    
    _receiveDate = nil;
}

-(void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString{
    [_delegate opSuccess:dict];
}

- (void)parseProgress:(long long)receivedLength{
    
}

- (void)parseFail:(id)dict{
    if([dict isKindOfClass:[NSString class]]) {
        [_delegate opFail:(NSString *)dict];
        return;
    }
    
    //token失效后重新登录
    if ([[dict objectForKey:NetResult] isEqualToString:NetVallidateteToken]) {
        BASE_ERROR_FUN(NetVallidateteToken);
    }
    
    [_delegate opFail:[dict objectForKey:NetMessage]];
}


#pragma mark - NSURLConnectionDelegate methods
//接受完http协议头，开始真正接受数据时调用此方法
- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse{
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)aResponse;
    NSString *statusCode = [NSString stringWithFormat:@"%ld",(long)[response statusCode]];

    _statusCode = [statusCode intValue]; //将字符串转化为整型
    _receiveDate = [[NSMutableData alloc] init];
    
    if(_statusCode == 200 || _statusCode == 206) { //这里我的服务器应该不会返回206
        _totalLength = [response expectedContentLength];
    }
    
    BASE_INFO_FUN(statusCode);
}

//网络请求时，每接受一段数据就会调用此函数方法
- (void)connection:(NSURLConnection *)aConn didReceiveData:(NSData *)data{
    BASE_INFO_FUN(([NSString stringWithFormat:@"%lu", (unsigned long)data.length]));
    [_receiveDate appendData:data];
    [self parseProgress:_receiveDate.length];
    
}

//下载完成时，可以对一些数据进行处理，将文件保存在沙盒中
- (void)connectionDidFinishLoading:(NSURLConnection *)aConn{
    BASE_INFO_FUN(([[NSString alloc] initWithData:_receiveDate encoding:NSUTF8StringEncoding]));
    
    //成功接收：200有数据，204没有数据，206断点续传
    if (_statusCode == 200 || _statusCode == 204 || _statusCode == 206) {
        [self parseProgress:_receiveDate];
    }else {
        NSString *errorMessage = [[NSString alloc] initWithData:_receiveDate encoding:NSUTF8StringEncoding];
        
        if (errorMessage.length <= 0) {
            errorMessage = [[NSString alloc] initWithFormat:@"ResponseCode:%ld",(long)_statusCode];
        }
        
        [self parseFail:errorMessage];
    }
    //下载完成后将连接和数据清空
    _connection = nil;
    _receiveDate = nil;
}

- (void)connection:(NSURLConnection *)aConn didFailWithError:(NSError *)error{
    [self parseFail:[error localizedDescription]];
    
    _connection = nil;
    _receiveDate = nil;
}

@end