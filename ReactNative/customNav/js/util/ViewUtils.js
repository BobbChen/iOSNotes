/**
 * Created by chenbo on 2018/1/27.
 */
import  React,{Component} from 'react';
import {
    View,
    Text,
    Image,
    StyleSheet,
    ListView,
    TouchableOpacity, // 点击触摸组件
    RefreshControl, // 刷新
    TextInput,
}from 'react-native';
export default class ViewUtils{
    // 返回导航栏左侧按钮,callBack回调给调用者去处理事件
    static getLeftButton(callBack){
        return <TouchableOpacity
            style={{padding:8}}
            onPress={callBack}
        >
        <Image
            style={{width:26,height:26,tintColor:'yellow'}}
            source={require('../../res/Images/ic_arrow_back_white_36pt.png')}
        />
        </TouchableOpacity>
    }
}