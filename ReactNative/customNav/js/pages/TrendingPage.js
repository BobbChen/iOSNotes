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
    DeviceEventEmitter,
}from 'react-native';
import DetailView from './DetailView';
import TrendingCell from '../common/TrendingCell';
import ScrollableTabView,{ScrollableTabBar} from 'react-native-scrollable-tab-view'
import NavBar from '../common/NavBar';
import { Navigator } from'react-native-deprecated-custom-components';
import NavigationBar from '../../NavigationBar';
import NetWorkManager,{FLAG_STORAGE} from '../common/NetWorkManager';
import GitHubTrending from 'GitHubTrending';

import LanguageDao,{FLAG_LANGUAGE} from '../expand/LanguageDao';
const URL='https://github.com/trending/'


export default class TrendingPage extends Component {
    constructor(props){
        super(props);
        this.languageDao = new LanguageDao(FLAG_LANGUAGE.flag_language);
        this.state={
            languages:[],
        }
    }

    componentDidMount(){
        this.loadData();
    }

    // 加载保存在数据库的标签
    loadData(){
        this.languageDao.fetch()
            .then(result=>{
                this.setState({
                    languages:result
                })
            })

    }



    render(){

        let content = this.state.languages.length>0?
            <ScrollableTabView
                // 下划线样式
                tabBarUnderlineStyle = {{backgroundColor:'#e7e7e7',height:2}}

                // 未选中时候的颜色
                tabBarInactiveTextColor = "mintcream"
                // 选中时候的颜色
                tabBarActiveTextColor="white"
                tabBarBackgroundColor="#6495ED"
                renderTabBar={()=><ScrollableTabBar/>}
            >

                {this.state.languages.map((result,i,arr)=>{
                    let lan=arr[i];
                    // 如果订阅了，返回视图,注意PopularTab需要延展属性{...this.props}才能实现跳转
                    return lan.checked?<TrendingTab key={i} tabLabel={lan.name} {...this.props}>{lan.name}</TrendingTab>:null;
                })}
            </ScrollableTabView>:null;



        return(
            <View style={styles.container}>
                <NavigationBar
                    title={'Trending'}
                    style={{backgroundColor:'#6495ED'}}
                />
                {content}
            </View>
        )
    }
}
class TrendingTab extends Component{
    constructor(props){
        super(props);
        this.NetManager = new NetWorkManager(FLAG_STORAGE.flag_trending)
        this.trending=new GitHubTrending();
        this.state={
            isLoading:false,
            result:'',
            dataSource:new ListView.DataSource({rowHasChanged:(r1,r2)=>r1 !== r2})

        }
    }

    // 组件渲染完毕进行数据加载
    componentDidMount(){
        this.loadData();
    }

    loadData(){
        this.setState({
            isLoading:true
        })
        let url = 'https://github.com/trending/c'
        // 'https://api.github.com/search/repositories?q=ios&sort=stars'

        // let url = URL + tabLabel;

        this.trending.fetchTrending(url)
            .then(result=>{
                this.setState({
                    isLoading:false,
                    dataSource:this.state.dataSource.cloneWithRows(result)
                })
            })



        {/*this.NetManager.get(url)
            .then(result=>{
                this.setState({
                    isLoading:false,
                    // 将数据和DataSource进行关联
                    dataSource:this.state.dataSource.cloneWithRows(result.items)
                })
                // 发送通知，显示Tosat
                DeviceEventEmitter.emit('showToast','获取到了数据');
            })

            .catch(error=>{
                this.setState({
                    result:JSON.stringify(result)
                })
            })*/}

    }
    // 页面跳转
    onClickCell(item){
        var route={
            component:DetailView,
            params:{
                ...this.props,
                data:item
            }
        };
        this.props.navigator.push(route);
    }


    renderRow(data){
        return <TrendingCell
            onSelect={()=>this.onClickCell(data)}
            key={data.id}
            data = {data}
        />
    }


    render(){
        return <View style={{flex:1}}>
            <ListView
                dataSource={this.state.dataSource}
                renderRow={(data)=>this.renderRow(data)}
                refreshControl = {<RefreshControl
                        refreshing={this.state.isLoading}
                        // 监听到下拉刷新的时候调用加载数据的方法
                        onRefresh={()=>this.loadData()}
                        title={'正在加载...'}
                        tintColor={'#6495ED'} // iOS
                        colors={['#6495ED']} // android
                        titleColor={'#6495ED'}

                />}

            />

        </View>
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
    }
})
