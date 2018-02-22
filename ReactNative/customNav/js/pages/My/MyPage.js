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
    ScrollView,
    TouchableHighlight,
}from 'react-native';
import CustomKeyPage from './CustomKeyPage';
import SortKeyPage from './SortKeyPage';
import { Navigator } from'react-native-deprecated-custom-components';
import NavBar from '../../common/NavBar'
import {MORE_MENU} from '../../common/MoreMenu';
import GlobalStyles from '../../../res/styles/GlobalStyles';
import ViewUtils from '../../util/ViewUtils';
import AboutPage from '../About/AboutPage';


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

    onClick(tag){
        /**
         * TargetComponent:跳转的组件
         * params:传递的参数
         */
        let TargetComponent,params={...this.props,menuType:tag}
        switch (tag){
            case MORE_MENU.Custom_Language:
                TargetComponent=CustomKeyPage;
                break;
            case MORE_MENU.Custom_Key:
                TargetComponent=CustomKeyPage;
                break;
            case MORE_MENU.Remove_Key:
                TargetComponent=CustomKeyPage;
                break;
            case MORE_MENU.Sort_Key:
                TargetComponent=CustomKeyPage;
                break;
            case MORE_MENU.Sort_Language:
                TargetComponent=CustomKeyPage;
                break;

            case MORE_MENU.Custom_Theme:
                TargetComponent=CustomKeyPage;
                break;
            case MORE_MENU.About_Author:
                TargetComponent=AboutPage;
                break;

            case MORE_MENU.About:
                TargetComponent=AboutPage;
                break;

        }
        if(TargetComponent){
            var route={
                component:TargetComponent,
                params:{
                    ...this.props,
                    // 根据isRemove来判断是否是移除标签
                    isRemoveKey:false
                }
            };
            this.props.navigator.push(route);
        }


    }

    getItems(tag,icon,text){
        return (ViewUtils.getSettingItem(()=>this.onClick(tag),icon,text,'#6495ED',null))
    }

    render(){
        <Navigator
            initialRoute={{component: MyPage}}
            renderScene={(route, navigator)=>this.renderScene(route, navigator)}

        />
        return(
            <View style={GlobalStyles.root_container}>
                <NavBar
                    title='我的'
                    style={{backgroundColor:'#6495ED'}}
                />
                <ScrollView >
                    <TouchableHighlight
                        onPress={()=>this.onClick(MORE_MENU.Custom_Language)}
                    >
                        <View style={[styles.item,{height:90}]}>
                            <View style={{flexDirection:'row',alignItems:'center'}}>
                                <Image style={{width:40,height:40,marginRight:10,tintColor:'#6495ED'}} source={require('../../../res/Images/ic_trending.png')}/>
                                <Text>GitHub Popular</Text>
                            </View>
                            <Image
                                style={{
                                height:22,
                                width:22,
                                marginRight:10,
                                tintColor:'#6495ED',
                            }}
                                source={require('../../../res/Images/ic_tiaozhuan.png')}
                            />
                        </View>
                    </TouchableHighlight>
                    <View style={GlobalStyles.lineStyle}/>

                    {/*趋势管理*/}
                    <Text style={styles.groupTitle}>趋势管理</Text>
                    <View style={GlobalStyles.lineStyle}/>

                    {this.getItems(
                        MORE_MENU.About,
                        require('./images/ic_custom_language.png'),
                        '自定义预约',
                    )}
                    <View style={GlobalStyles.lineStyle}/>

                    {/*语言排序*/}
                    {this.getItems(
                        MORE_MENU.Sort_Language,
                        require('./images/ic_swap_vert.png'),
                        '语言排序',
                    )}


                    {/*标签管理*/}
                    <Text style={styles.groupTitle}>标签管理</Text>
                    <View style={GlobalStyles.lineStyle}/>
                    {this.getItems(
                        MORE_MENU.Custom_Key,
                        require('./images/ic_custom_language.png'),
                        '自定义标签',
                    )}
                    <View style={GlobalStyles.lineStyle}/>
                    {this.getItems(
                        MORE_MENU.Sort_Key,
                        require('./images/ic_swap_vert.png'),
                        '标签排序',
                    )}

                    <View style={GlobalStyles.lineStyle}/>
                    {this.getItems(
                        MORE_MENU.Remove_Key,
                        require('./images/ic_remove.png'),
                        '移除标签',
                    )}


                    {/*设置*/}
                    <View style={GlobalStyles.lineStyle}/>
                    <Text style={styles.groupTitle}>设置</Text>
                    <View style={GlobalStyles.lineStyle}/>
                    {this.getItems(
                        MORE_MENU.Custom_Theme,
                        require('./images/ic_view_quilt.png'),
                        '自定义主题',
                    )}
                    <View style={GlobalStyles.lineStyle}/>
                    {this.getItems(
                        MORE_MENU.About_Author,
                        require('./images/ic_insert_emoticon.png'),
                        '关于作者',
                    )}
                </ScrollView>





            </View>
        )
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
    },
    item:{
        flexDirection:'row',
        justifyContent:'space-between',
        alignItems:'center',
        padding:10,
        height:60,
        backgroundColor:'white',
    },
    groupTitle:{
        marginLeft:10,
        marginBottom:5,
        marginTop:10,
        fontSize:12,
        color:'gray'
    }

})
