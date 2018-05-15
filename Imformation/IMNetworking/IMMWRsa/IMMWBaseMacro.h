//
//  MWBaseMacro.h
//
//
//  Created by JoshuaD on 15/6/3.
//  Copyright (c) 2015年 JoshuaD. All rights reserved.
//

#ifndef IMMWBaseMacro_h
#define IMMWBaseMacro_h

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif




//---------------------打印日志--------------------------


#define MWBUNDLE_NAME   @"MaoWanBundle.bundle"
#define MWBUNDLE_PATH   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MWBUNDLE_NAME]
#define MWBUNDLE        [NSBundle bundleWithPath: MWBUNDLE_PATH]

#define MWBundleUIImage(Name) [UIImage imageWithContentsOfFile:[MWBUNDLE_PATH stringByAppendingPathComponent:Name]]

#endif
