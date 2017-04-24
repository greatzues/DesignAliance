//
//  DABaseOperation.h
//  DesignAliance
//
//  Created by zues on 17/4/23.
//  Copyright © 2017年 zues. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DAOperationDelegate;
@interface DABaseOperation : NSObject{
    id<DAOperationDelegate> _delegate;
    
    NSURLConnection         *_connection;
    NSMutableData           *_receiveDate;
    NSInteger               _statusCode;
    long long               _totalLength;
    
    
@public
    NSDictionary            *_opInfo;
}

- (id)initWithDelegate:(id<DAOperationDelegate>)delegate
                opInfo:(NSDictionary *)opInfo;
- (NSMutableURLRequest *)urlRequest;
- (void)executeOp;
- (void)cancelOp;
- (void)parseData:(id)date;
- (void)parseSuccess:(NSDictionary *)dict jsonString:(NSString *)jsonString;
- (void)parseFail:(id)dict;
- (void)parseProgress:(long long)receivedLength;
- (NSTimeInterval)timeoutInteval;

@end

@protocol DAOperationDelegate <NSObject>

- (void)opSuccess:(id)data;
- (void)opFail:(NSString *)errorMessage;

@optional
- (void)opSuccessEx:(id)data opinfo:(NSDictionary *)dictInfo;
- (void)opFailEx:(NSString *)errorMessage opinfo:(NSDictionary *)dictInfo;
- (void)opSuccessMatch:(id)data;
- (void)opUploadSuccess;

@end
