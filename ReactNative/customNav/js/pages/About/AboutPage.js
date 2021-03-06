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
    Dimensions,
    Platform,
}from 'react-native';
import {MORE_MENU} from '../../common/MoreMenu';
import ParallaxScrollView from 'react-native-parallax-scroll-view';
import GlobalStyles from '../../../res/styles/GlobalStyles';

import ViewUtils from '../../util/ViewUtils';



export default class AboutPage extends Component {
    constructor(props) {
        super(props);
    }

    // cell点击事件
    onClick(tag){
        /**
         * TargetComponent:跳转的组件
         * params:传递的参数
         */
        let TargetComponent,params={...this.props,menuType:tag}
        switch (tag){
            case MORE_MENU.About_Author:
                break;
            case MORE_MENU.WebSite:
                break;
            case MORE_MENU.FeedBack:
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
    getParallaxConfig(params){
        let config={}
        config.renderBackground=()=>(
            <View key="background">
                <Image source={{uri: params.backgroundImg,
                                width: window.width,
                                height: PARALLAX_HEADER_HEIGHT}}/>
                <View style={{position: 'absolute',
                              top: 0,
                              width: window.width,
                              backgroundColor: 'rgba(0,0,0,.4)',
                              height: PARALLAX_HEADER_HEIGHT}}/>
            </View>
        );
        config.renderForeground=()=>(
            <View key="parallax-header" style={ styles.parallaxHeader }>
                <Image style={ styles.avatar } source={{
                  uri: params.avatar,
                  width: AVATAR_SIZE,
                  height: AVATAR_SIZE
                }}/>
                <Text style={ styles.sectionSpeakerText }>
                    Talks by Rich Hickey
                </Text>
                <Text style={ styles.sectionTitleText }>
                    {params.description}
                </Text>
            </View>
        );
        config.renderStickyHeader=()=>(
            <View key="sticky-header" style={styles.stickySection}>
                <Text style={styles.stickySectionText}>{params.name}</Text>
            </View>
        );
        config.renderFixedHeader=()=>(
            <View key="fixed-header" style={styles.fixedSection}>
                {ViewUtils.getLeftButton(()=>this.props.navigator.pop())}
            </View>
        );

        return config;
    }

    render() {
        let renderConfig=this.getParallaxConfig({
            'name':'GitHub Popular',
            'description':'这里是一段描述内容',
            'avatar':'http://avatar.csdn.net/1/1/E/1_fengyuzhengfan.jpg',
            'backgroundImg':'http://avatar.csdn.net/1/1/E/1_fengyuzhengfan.jpg',


        });
        let conetnt=<View>
            {ViewUtils.getSettingItem(()=>this.onClick,require('../../../res/Images/ic_computer.png'),MORE_MENU.WebSite,'#2196F3')}
            <View style={GlobalStyles.lineStyle}/>
            {ViewUtils.getSettingItem(()=>this.onClick,require('../My/images/ic_insert_emoticon.png'),MORE_MENU.About_Author,'#2196F3')}
            <View style={GlobalStyles.lineStyle}/>
            {ViewUtils.getSettingItem(()=>this.onClick,require('../../../res/Images/ic_feedback.png'),MORE_MENU.FeedBack,'#2196F3')}




        </View>
        return (
          <ParallaxScrollView

            headerBackgroundColor="#333"
            backgroundColor="#2196F3"
            stickyHeaderHeight={ STICKY_HEADER_HEIGHT }
            parallaxHeaderHeight={ PARALLAX_HEADER_HEIGHT }
            backgroundSpeed={10}
              {...renderConfig}
              >
              {conetnt}
          </ParallaxScrollView>
        )}


}

const window = Dimensions.get('window');

const AVATAR_SIZE = 120;
const ROW_HEIGHT = 60;
const PARALLAX_HEADER_HEIGHT = 350;
const STICKY_HEADER_HEIGHT = 70;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: 'black'
    },
    background: {
        position: 'absolute',
        top: 0,
        left: 0,
        width: window.width,
        height: PARALLAX_HEADER_HEIGHT
    },
    stickySection: {
        height: STICKY_HEADER_HEIGHT,
        justifyContent: 'center',
        alignItems:'center',
        paddingTop:(Platform.OS==='ios')?20:0,
    },
    stickySectionText: {
        color: 'white',
        fontSize: 20,
        margin: 10
    },
    fixedSection: {
        position: 'absolute',
        bottom: 0,
        right: 10,
        left:0,
        top:0,
        paddingRight:8,
        flexDirection:'row',
        alignItems:'center',
        paddingTop:(Platform.OS==='ios')?20:0,
        justifyContent:'space-between',
    },
    fixedSectionText: {
        color: '#999',
        fontSize: 20
    },
    parallaxHeader: {
        alignItems: 'center',
        flex: 1,
        flexDirection: 'column',
        paddingTop: 100
    },
    avatar: {
        marginBottom: 10,
        borderRadius: AVATAR_SIZE / 2
    },
    sectionSpeakerText: {
        color: 'white',
        fontSize: 24,
        paddingVertical: 5
    },
    sectionTitleText: {
        color: 'white',
        fontSize: 18,
        paddingVertical: 5
    },
    row: {
        overflow: 'hidden',
        paddingHorizontal: 10,
        height: ROW_HEIGHT,
        backgroundColor: 'white',
        borderColor: '#ccc',
        borderBottomWidth: 1,
        justifyContent: 'center'
    },
    rowText: {
        fontSize: 20
    }
});



