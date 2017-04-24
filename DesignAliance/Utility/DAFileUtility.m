//
//  DAFileUtility.m
//  DesignAliance
//
//  Created by zues on 17/4/24.
//  Copyright © 2017年 zues. All rights reserved.
//

#import "DAFileUtility.h"
#import <sys/stat.h>
#import <dirent.h>

@implementation DAFileUtility

+ (BOOL)isFileExist:(NSString *)filePath{
    NSFileManager *fm = [NSFileManager defaultManager];
    return [fm fileExistsAtPath:filePath];
}

+ (BOOL)createPath:(NSString *)filePath{
    if ([DAFileUtility isFileExist:filePath]){
        return YES;
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    
    [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error != nil) {
        BASE_ERROR_FUN([error localizedDescription]);
        return NO;
    }
    
    return YES;
}

+ (BOOL)renameFile:(NSString *)filePath toFile:(NSString *)toPath{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    if ([DAFileUtility isFileExist:toPath]) {
        [fm removeItemAtPath:filePath error:&error];
        if (error != nil) {
            BASE_ERROR_FUN([error localizedDescription]); //包含错误的本地化描述的字符串
        }
    }
    
    [fm moveItemAtPath:filePath toPath:toPath error:&error];
    if (error != nil) {
        BASE_ERROR_FUN([error localizedDescription]);
        return NO;
    }
    
    return YES;
}

+ (BOOL)deleteFile:(NSString *)filePath{
    //检查是否存在这个问文件
    if (![DAFileUtility isFileExist:filePath]) {
        return YES;
    }
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    
    [fm removeItemAtPath:filePath error:&error];
    if (error != nil) {
        BASE_ERROR_FUN([error localizedDescription]);
        return NO;
    }
    
    return YES;
}

+ (BOOL)copyFromPath:(NSString *)fromPath toPath:(NSString *)toPath isReplace:(BOOL)isReplace{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    
    if ([DAFileUtility isFileExist:toPath] && isReplace) {
        [DAFileUtility deleteFile:toPath];
    }
    
    [fm copyItemAtPath:fromPath toPath:toPath error:&error];
    if (error != nil) {
        BASE_ERROR_FUN([error localizedDescription]);
        return NO;
    }
    
    return YES;
}

+ (BOOL)moveContentsFromPath:(NSString *)fromPath toPath:(NSString *)toPath isReplace:(BOOL)isReplace{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError *error = nil;
    
    NSArray *contents = [fm contentsOfDirectoryAtPath:fromPath error:&error];
    if (error != nil) {
        BASE_ERROR_FUN([error localizedDescription]);
    }
    
    NSString *toFilePath = nil, *fromFilePath = nil;
    for (NSString *path in contents) {
        toFilePath = [toPath stringByAppendingPathComponent:path];
        fromFilePath = [fromPath stringByAppendingPathComponent:path];
        
        if ([DAFileUtility isFileExist:toFilePath] && isReplace) {
            [DAFileUtility deleteFile:toFilePath];
        }
        //给error引用指针，在arc中更容易管理
        [fm moveItemAtPath:fromFilePath toPath:toFilePath error:&error];
        if (error != nil) {
            BASE_ERROR_FUN([error localizedDescription]);
        }
    }
    
    return YES;
}

+ (double)calculteFileSzie:(NSString *)filePath{
    double fSize = 0.0f;
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:filePath error:nil];
    
    if (dirContents == nil) {
        NSDictionary *dirAttr = [fm attributesOfItemAtPath:filePath error:nil];
        fSize += [[dirAttr objectForKey:NSFileSize] floatValue];
    }else {
        for (NSString *dirName in dirContents) {
            fSize += [DAFileUtility calculteFileSzie:[filePath stringByAppendingPathComponent:dirName]];
        }
    }
    return fSize;
}

+ (double)calculteFileSizeAtPath:(const char*)folderPath
{
    double folderSize = 0;
    DIR* dir = opendir(folderPath);
    
    if (dir != NULL) {
        struct dirent* child;
        struct stat st;
        NSInteger folderPathLength = 0;
        char childPath[1024] = {0};
        
        while ((child = readdir(dir))!=NULL) {
            // 忽略目录 .
            if (child->d_type == DT_DIR && (child->d_name[0] == '.' && child->d_name[1] == 0)) {
                continue;
            }
            
            // 忽略目录 ..
            if (child->d_type == DT_DIR && (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0))
                continue;
            
            folderPathLength = strlen(folderPath);
            stpcpy(childPath, folderPath);
            
            if (folderPath[folderPathLength-1] != '/'){
                childPath[folderPathLength] = '/';
                folderPathLength++;
            }
            
            stpcpy(childPath+folderPathLength, child->d_name);
            childPath[folderPathLength + child->d_namlen] = 0;
            
            // 递归计算子目录
            if (child->d_type == DT_DIR) {
                folderSize += [DAFileUtility calculteFileSizeAtPath:childPath];
                // 把目录本身所占的空间也加上
                if(lstat(childPath, &st) == 0)
                    folderSize += st.st_size;
            }
            else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
                if(lstat(childPath, &st) == 0) {
                    folderSize += st.st_size;
                }
            }
        }
        
    }
    
    closedir(dir);
    return folderSize;
}

+ (double)calculteFileSzieEx:(NSString *)filePath
{
    if (![DAFileUtility isFileExist:filePath]) {
        return 0.0f;
    }
    
    return [DAFileUtility calculteFileSizeAtPath:[filePath cStringUsingEncoding:NSUTF8StringEncoding]];
}

+ (void)deleteFiles:(NSArray *)fileNames inPath:(NSString *)path
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:path error:nil];
    
    if (dirContents == nil) {//文件夹为空时,dirContents不为nil但数目count为0,path为文件时,dirContents=nil
        if ([fileNames containsObject:[path lastPathComponent]]) {
            [DAFileUtility deleteFile:path];
        }
    }
    else {
        for (NSString *dirName in dirContents) {
            if ([fileNames containsObject:dirName]) {
                [DAFileUtility deleteFile:[path stringByAppendingPathComponent:dirName]];
            }
            else {
                [DAFileUtility deleteFiles:fileNames inPath: [path stringByAppendingPathComponent:dirName]];
            }
        }
    }
}


@end
