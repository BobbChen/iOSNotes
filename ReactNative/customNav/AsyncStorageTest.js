/**
 * Created by chenbo on 2018/1/27.
 */
/**
 * Created by chenbo on 2018/1/27.
 */
import React,{Component} from 'react';
import {
    View,
    Text,
    StyleSheet,
    AsyncStorage,
    TextInput,
}from 'react-native';
import Girl from './Girl';
import Toast,{DURATION} from 'react-native-easy-toast';
import NavigationBar from './NavigationBar';
export default class AsyncStorageTest extends Component{
    onSave(){
        AsyncStorage.setItem('KEY',this.text,(error)=>{
            if(!error){
                this.toast.show('保存成功',DURATION.LENGTH_LONG)
            }
        })
    }
    onDelete(){
        AsyncStorage.removeItem('KEY',(error)=>{
            if(!error){
                this.toast.show('移除成功')
            }
        })
    }
    onGet(){
        AsyncStorage.getItem('key',(error,result)=>{
            if(!error){
                this.toast.show('取出的内容为:'+result)
            }
        })
    }
    render(){
        return <View style={styles.container}>
            <NavigationBar
                title={"数据持久化"}
                style={{backgroundColor:'#6495ED'}}
            />
            <TextInput
                style={{borderWidth:1,height:40,margin:6}}
                // 获取输入的文本内容
                onChangeText={text=>this.text=text}
            />
            <View style={{flexDirection:'row'}}>
                <Text style={styles.text} onPress={()=>this.onSave()}>保存</Text>
                <Text style={styles.text} onPress={()=>this.onDelete()}>删除</Text>
                <Text style={styles.text} onPress={()=>this.onGet()}>取出</Text>
            </View>
            <Toast ref={toast=>this.toast=toast}/>


        </View>
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
        backgroundColor:'white'
    },
    text:{
        fontSize:20,
        margin:5,

    }
})