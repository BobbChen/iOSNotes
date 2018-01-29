/**
 * Created by chenbo on 2018/1/28.
 */
import React,{Component} from 'react';
import {
    View,
    Text,
    StyleSheet,
    WebView,
    TextInput,
    DeviceEventEmitter,
}from 'react-native';
import NavigationBar from './NavigationBar';

const URL='http://www.baidu.com';

export default class WebViewTest extends Component{
    constructor(props){
        super(props);
        this.state={
            url:URL,
            title:'',
            canGoBack:false,
        }
    }

    goBack(){
        if(this.state.canGoBack){
            this.webview.goBack();
        }else
        {
            DeviceEventEmitter.emit('showToast','到顶了');
        }
    }
    go(){
        this.setState({
            url:this.text
        })
    }

    onNavigationStateChange(e){
        this.setState({
            canGoBack:e.canGoBack,
            title:e.title,
        })
    }

    render(){
        return (
            <View style={styles.container}>
                <NavigationBar
                    title={'WebView'}
                    style={{backgroundColor:'#6495ED'}}
                />
                <View style={styles.row}>
                    <Text style={styles.tips} onPress={()=>this.goBack()}>返回</Text>
                    <TextInput
                        style={styles.input}
                        defaultValue={URL}
                        onChangeText={text=>this.text=text}
                    ></TextInput>
                    <Text style={styles.tips} onPress={()=>this.go()}>前往</Text>

                </View>
                <WebView
                    ref={webview=>this.webview=webview}
                    source={{uri:this.state.url}}
                    onNavigationStateChange={(e)=>this.onNavigationStateChange(e)}
                />
            </View>

        )
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
        backgroundColor:'white',
    },
    row:{
        flexDirection:'row',
        alignItems:'center',
        margin:10,
    },
    tips:{
        fontSize:20,
    },
    input:{
        height:40,
        flex:1,
        borderWidth:1,
        margin:2,

    }
})
