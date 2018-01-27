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
import HomePageCell from '../common/HomePageCell';
import ScrollableTabView,{ScrollableTabBar} from 'react-native-scrollable-tab-view'
import NavBar from '../common/NavBar';
import NavigationBar from '../../NavigationBar';
import NetWorkManager from '../common/NetWorkManager';
const URL='https://api.github.com/search/repositories?q=';
const QUERY_STR='&sort=stars';

export default class ListViewDemo extends Component {


    render(){
        return(
            <View style={styles.container}>
                <NavigationBar
                    title={'最热'}
                    style={{backgroundColor:'#6495ED'}}
                />

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
                    <PopularTab tabLabel="Java">Java</PopularTab>
                    <PopularTab tabLabel="iOS">iOS</PopularTab>
                    <PopularTab tabLabel="Android">Android</PopularTab>
                    <PopularTab tabLabel="JavaScript">JavaScript</PopularTab>

                </ScrollableTabView>

                {/*<Text style={styles.tips} onPress={()=>{
                       this.onLoad()
                }}>获取数据</Text>
                <TextInput style={{height:40,borderWidth:1}}
                           onChangeText={text=>this.text=text}
                ></TextInput>

                <Text style={{height:500}}>{this.state.result}</Text>*/}

            </View>
        )
    }
}
class PopularTab extends Component{
    constructor(props){
        super(props);
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
        let url = URL+this.props.tabLabel+QUERY_STR
        // 'https://api.github.com/search/repositories?q=ios&sort=stars'
        NetWorkManager.get(url)
            .then(result=>{
                this.setState({
                    isLoading:false,
                    // 将数据和DataSource进行关联
                    dataSource:this.state.dataSource.cloneWithRows(result.items)
                })
            })
            .catch(error=>{
                this.setState({
                    result:JSON.stringify(result)
                })
            })
    }

    renderRow(data){
        return <HomePageCell data = {data}/>
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
