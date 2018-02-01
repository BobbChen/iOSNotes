/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
    Platform,
    StyleSheet,
    Text,
    View,
    Image,
    DeviceEventEmitter,
} from 'react-native';
import Popular from './Popular'
import { Navigator } from 'react-native-deprecated-custom-components';
const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' +
    'Cmd+D or shake for dev menu',
  android: 'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});
import NavigationBar from './NavigationBar';
import ListViewDemo from './ListViewDemo';
import Fetch from './Fetch';
import PropTypes from 'prop-types'; // ES6
import TabNavigator from 'react-native-tab-navigator';
import Boy from './Boy';
import WebViewTest from './WebViewTest';
import TrendingTest from './TrendingTest';

import PopularPage from './js/pages/PopularPage';
import TrendingPage from './js/pages/TrendingPage';
import AsyncStorageTest from './AsyncStorageTest';
import MyPage from './js/pages/My/MyPage';
import Toast,{DURATION} from 'react-native-easy-toast';



export default class App extends Component<{}> {
  constructor(props){
    super(props);
    this.state={
      selectedTab:'tab_popular',
    }

  }
  componentDidMount(){
      // 注册一个监听，只要监听到'showToast'标示，就触发对应的事件
      this.listener=DeviceEventEmitter.addListener('showToast',(text)=>{
            this.toast.show(text,DURATION.LENGTH_LONG);

      });


  }

  // 组件移除的时候，移除监听
  componentWillUnmount(){
    this.listener&&this.listener.remove();
  }

  _renderItem(Component,selectTab,title,tabBarImage){
      return <TabNavigator.Item
          selected={this.state.selectedTab === selectTab}
          title={title}
          selectedTitleStyle={{color:'#6495ED'}}
          renderIcon={() => <Image
                              style={styles.image}
                              source={tabBarImage}
          />}
          renderSelectedIcon={() => <Image style={[styles.image,{tintColor:'#6495ED'}]} source={require('./res/Images/ic_polular.png')} />}
          onPress={() => this.setState({ selectedTab: selectTab })}>
          <View style={styles.page1}>
              <Component {...this.props}/>
          </View>
      </TabNavigator.Item>
  }

  render() {
      return (
      <View style={styles.container}>
          <TabNavigator>
              {this._renderItem(PopularPage,'tab_popular',"最热",require('./res/Images/ic_polular.png'))}
              {this._renderItem(TrendingPage,'tab_trending',"趋势",require('./res/Images/ic_trending.png'))}
              {this._renderItem(WebViewTest,'tab_favorite',"收藏",require('./res/Images/ic_favorite.png'))}
              {this._renderItem(MyPage,'tb_my',"我的",require('./res/Images/ic_my.png'))}
        </TabNavigator>
        <Toast ref={toast=>this.toast=toast}/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: 'white',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },

  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  page1:{
    flex:1,
    backgroundColor:'red',

  },
  page2:{
    flex:1,
    backgroundColor:'white',

  },
  image:{
    height:22,
    width:22
  },

});
