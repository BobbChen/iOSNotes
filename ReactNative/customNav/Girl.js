/**
 * Created by chenbo on 2018/1/27.
 */
import React,{Component} from 'react';
import {
    View,
    Text,
    StyleSheet,
}from 'react-native';
export default class Girl extends Component{
    constructor(props){
        super(props);
        this.state={
        }
    }
    render(){
        return (
            <View style={styles.container}>
                <Text style={styles.text}>I am Girl</Text>
                <Text style={styles.text}>{this.props.word}</Text>
            </View>

        )
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
        backgroundColor:'white',
        // 文本居中
        justifyContent:'center',

    },
    text:{
        fontSize:22
    }
})