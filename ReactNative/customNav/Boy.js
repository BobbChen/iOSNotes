/**
 * Created by chenbo on 2018/1/27.
 */
import React,{Component} from 'react';
import {
    View,
    Text,
    StyleSheet,
}from 'react-native';
import Girl from './Girl';
export default class Boy extends Component{
    constructor(props){
        super(props);
        this.state={
            word:''
        }
    }
    render(){
        return <View style={styles.container}>
            <Text style={styles.text}>I am Boy</Text>
            <Text style={styles.text} onPress={()=>{
                this.props.navigator.push({
                    component:Girl,
                    params:{
                        word:'玫瑰',
                        onCallBack:(word)=>{
                            this.setState({word:word})
                        }
                    }
                })
            }}>送给Girl一枝玫瑰</Text>
            <Text style={styles.text}>{this.state.word}</Text>
        </View>
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
        backgroundColor:'gray'
    },
    text:{
        fontSize:20
    }
})