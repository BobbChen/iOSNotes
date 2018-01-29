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
import NavBar from '../common/NavBar';
import ViewUtils from '../util/ViewUtils';

const URL='http://www.baidu.com';

export default class DetailView extends Component{
    constructor(props){
        super(props);
        // 获取上个页面传来的url
        this.url=this.props.data.html_url;
        let title = this.props.data.full_name;
        this.state={
            url:this.url,
            title:title,
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
        })
    }

    render(){
        return (
            <View style={styles.container}>
                <NavBar
                    title={this.state.title}
                    style={{backgroundColor:'#6495ED'}}
                    leftButton={ViewUtils.getLeftButton(()=>{
                        this.props.navigator.pop();
                    })}
                />
                <WebView
                    ref={webview=>this.webview=webview}
                    source={{uri:this.state.url}}
                    onNavigationStateChange={(e)=>this.onNavigationStateChange(e)}
                    startInLoadingState={true}
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
