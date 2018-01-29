/**
 * Created by chenbo on 2018/1/26.
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
}from 'react-native';
import NewManager from './NewManager';

export default class Fetch extends Component<{}> {
    constructor(props){
        super(props);
        this.state={
            result:''
        }
    }

    // 获取数据
    onLoad(url){
        NewManager.get(url)
            .then(result=>{
                this.setState({
                    result:(JSON.stringify(result))
                })
            })
    }

    // 发送数据
    onSubmit(url,params){
        NewManager.post(url,params)
            .then(result=>{
                this.setState({
                    result:JSON.stringify(result)
                })
            })
    }

    render() {

        return (
            <View style={styles.container}>
                <Text onPress={()=>this.onLoad('https://qphvip.com/Api/PageClassList')}>获取数据</Text>
                <Text>获取到的数据：{this.state.result}</Text>
                <Text onPress={()=>this.onSubmit('https://qphvip.com/index.php/Project/GoodsInfo',{id:'1115'})}>发送数据</Text>
            </View>
        );
    }
}
const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'white',
    },

});
