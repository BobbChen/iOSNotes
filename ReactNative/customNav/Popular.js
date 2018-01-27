/**
 * Created by chenbo on 2018/1/27.
 */
import React,{Component} from 'react';
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
import NavigationBar from './NavigationBar'
import NewManager from './NewManager'
const URL='https://api.github.com/search/repositories?q=';
const QUERY_STR='&sort=stars';
export default class ListViewDemo extends Component {

    onLoad(){
        let url = this.getUrl(this.text);

    }

    // 用于生成完成URL的方法
    getUrl(key){
        return URL+key+QUERY_STR;
    }

    render(){
        return(
            <View style={styles.container}>
                <NavigationBar
                    title='最热'
                    style={{backgroundColor:'#6495ED'}}
                />
                <Text style={styles.tips} onPress={()=>{
                       this.onLoad()
                }}>获取数据</Text>
                <TextInput style={{height:20}}
                           onChangeText={text=>this.text=text}
                ></TextInput>
            </View>
        )
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
        backgroundColor:'gray'
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
    }
})
