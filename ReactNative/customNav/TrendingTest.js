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
import GitHubTrending from 'GitHubTrending';
import NavigationBar from './NavigationBar';
const URL='https://github.com/trending/'
export default class TrendingTest extends Component{

    constructor(props){
        super(props);
        this.trending=new GitHubTrending();
        this.state={
            result:''
        }


    }

    onLoad(){
        let url = URL + this.text;
        this.trending.fetchTrending(url)
            .then(result=>{
                this.setState({
                    result:JSON.stringify(result)

                })
            })

    }

    render(){
        return (
            <View style={styles.container}>
                <NavigationBar
                    title={'Trending使用'}
                    style={{backgroundColor:'#6495ED'}}
                />
                <TextInput
                    style={{height:30,borderWidth:1}}
                    onChangeText={(text)=>{
                        this.text = text;
                    }}
                />
                <View style={{flexDirection:'row'}}>
                    <Text style={{fontSize:20}} onPress={()=>this.onLoad()}>
                        加载数据
                    </Text>
                    <Text style={{height:500}}>{this.state.result}</Text>
                </View>
            </View>

        )
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
    }
})
