//
//  BlockPrinciple.c
//  Block
//
//  Created by 陈博 on 2018/1/8.
//  Copyright © 2018年 陈博. All rights reserved.
//

#include "BlockPrinciple.h"
#include <stdio.h>

int main(int argc, const char * argv[]) {
    // insert code here...
    return 0;
}
//
struct __block_impl {
    void * isa;
    int Flags;
    int Reserved;
    void * FuncPtr;
};

struct __main_block_impl_0 {
    struct __block_impl impl;
    struct __main_block_desc_0 * Desc;
    
    
    
};


////
//static struct __main_block_desc_0 {
//    unsigned long reserved;
//    unsigned long Block_size;
//} __main_block_desc_0_DATA = {
//    0,
//    sizeof(struct __main_block_impl_0)
//};
//
////
//
//
//
//struct __main_block_impl_0 {
//    struct __block_impl impl;
//};
//
//

