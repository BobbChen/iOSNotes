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
import CustomKeyPage from './CustomKeyPage';
import SortKeyPage from './SortKeyPage';
import { Navigator } from'react-native-deprecated-custom-components';
import NavBar from '../../common/NavBar'
export default class MyPage extends Component {
    constructor(props){
        super(props);
        // this.pushCustomPage = this.pushCustomPage.bind(this);
    }
    pushRemoveCustomPage(){
        var route={
            component:CustomKeyPage,
            params:{
                ...this.props,
                // 根据isRemove来判断是否是移除标签
                isRemoveKey:true
            }
        };
        this.props.navigator.push(route);

    }


    // 自定义标签页面
    pushCustomPage(){
        var route={
            component:CustomKeyPage,
            params:{
                ...this.props,
                // 根据isRemove来判断是否是移除标签
                isRemoveKey:false
            }
        };
        this.props.navigator.push(route);

    }

    // 标签排序页面
    pushSortKeyPage(){
        var route={
            component:SortKeyPage,
            params:{...this.props}
        };
        this.props.navigator.push(route);
    }

    render(){
        <Navigator
            initialRoute={{component: MyPage}}
            renderScene={(route, navigator)=>this.renderScene(route, navigator)}

        />
        return(
            <View style={styles.container}>
                <NavBar
                    title='我的'
                    style={{backgroundColor:'#6495ED'}}
                />

                <Text style={styles.tips}
                      onPress={this.pushCustomPage.bind(this)
                }>跳转到自定义标签页</Text>

                {/*跳转到标签排序页面*/}
                <Text style={styles.tips}
                      onPress={this.pushSortKeyPage.bind(this)
                }>跳转到标签排序页面</Text>

                {/*跳转到标签移除页面*/}
                <Text style={styles.tips}
                      onPress={this.pushRemoveCustomPage.bind(this)
                }>跳转到标签移除页面</Text>

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
