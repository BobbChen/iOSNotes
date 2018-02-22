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
    TouchableHighlight,
    TextInput,
}from 'react-native';
export default class ViewUtils{

    /**
     * 获取设置页面的item
     * @param callBack 点击回调
     * @param icon 左侧图标
     * @param text 显示的文本
     * @param tintStyle 图标着色
     * @param expandIcon 右侧的图标
     */
    static getSettingItem(callBack,icon,text,tintStyle,expandIcon){
        return(
            <TouchableHighlight
                onPress= {callBack}
            >
                <View style={styles.item}>
                    <View style={{flexDirection:'row',alignItems:'center'}}>
                        <Image style={{width:16,height:16,marginRight:10,tintColor:tintStyle}}
                               source={icon}
                               resizeMethod='stretch'
                        />
                        <Text>{text}</Text>
                    </View>
                    <Image
                        style={{
                                height:22,
                                width:22,
                                marginRight:10,
                                tintColor:tintStyle,
                            }}
                        source={expandIcon?expandIcon:require('../../res/Images/ic_tiaozhuan.png')}
                    />
                </View>

            </TouchableHighlight>
        )


    }

    // 返回导航栏左侧按钮,callBack回调给调用者去处理事件
    static getLeftButton(callBack){
        return <TouchableOpacity
            style={{padding:8}}
            onPress={callBack}
        >
        <Image
            style={{width:26,height:26,tintColor:'white'}}
            source={require('../../res/Images/ic_arrow_back_white_36pt.png')}
        />
        </TouchableOpacity>
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
        backgroundColor:'white'
    },
    tips:{
        fontSize:20,
    },
    row:{
        height:70,
    },
    line:{
        height:1,
        backgroundColor:'black',
    },
    image:{
        width:400,
        height:100,
    },
    item:{
        flexDirection:'row',
        justifyContent:'space-between',
        alignItems:'center',
        padding:10,
        height:60,
        backgroundColor:'white',
    }
})
