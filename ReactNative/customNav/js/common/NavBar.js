/**
 * Created by chenbo on 2018/1/27.
 */

import React,{Component} from 'react';
import {
    View,
    Text,
    Image,
    StyleSheet,
    Platform,
    StatusBar,
}from 'react-native';
import PropTypes from 'prop-types';

const NAV_HEIGHT_IOS = 44;
const NAV_HEIGHT_ANDROID = 50;
const STATUS_BAR_HEIGHT = 20;
const StatusBarShape={
    // 状态栏背景
    backgroundColor:PropTypes.string,
    barStyle:PropTypes.oneOf(['default','light-content','dark-content']),
    hidden:PropTypes.bool,
}
export default class NavBar extends Component {
    static propTypes={
        title:PropTypes.string,
        titleView:PropTypes.element,
        hide:PropTypes.bool,
        leftButton:PropTypes.element,
        rightButton:PropTypes.element,
        statusBar:PropTypes.shape(StatusBarShape)
    }

    // 为状态栏设置默认值
    static defaultProps={
        statusBar:{
            barStyle:'light-content',
            hidden:false
        }

    }

    constructor(props){
        super(props);
        this.state={
            title:'',
            hide:false,
        }
    }
    render(){
        // 设置状态栏 [styles.statusBar,this.props.statusBar]--获取用户设置值
        let status = <View style={[styles.statusBar,this.props.statusBar]}>
            <StatusBar {...this.props.statusBar}/>
        </View>

        let titleView = this.props.titleView?this.props.titleView:
            <Text style={styles.title}>{this.props.title}</Text>
        let content=<View style={[styles.navBar,this.props.style]}>
            {this.props.leftButton}
            <View style={styles.titleViewContainer}>
                {titleView}
            </View>
            {this.props.rightButton}
        </View>
        return(
            <View style={[styles.container,this.props.style]}>
                {/*状态栏*/}
                {status}
                {/*导航栏*/}
                {content}
            </View>
        )
    }
}
const styles=StyleSheet.create({
    container:{
        backgroundColor:'#6495ED'
    },
    navBar:{
        justifyContent:'space-between',
        alignItems:'center',
        height: NAV_HEIGHT_IOS,
        flexDirection:'row',
        backgroundColor:'red',
    },

    titleViewContainer:{
        justifyContent:'center',
        alignItems:'center',
        position:'absolute',
        left:40,
        right:40,
        top:0,
        bottom:0,
    },

    // 导航标题栏的样式
    title:{
        fontSize:20,
        color:'white',
    },
    statusBar:{
        height:20,
    }
})
