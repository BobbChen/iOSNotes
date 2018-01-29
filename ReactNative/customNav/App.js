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

  render() {


      return (
      <View style={styles.container}>


          <TabNavigator>

          <TabNavigator.Item
              selected={this.state.selectedTab === 'tab_popular'}
              title="最热"
              selectedTitleStyle={{color:'#6495ED'}}
              renderIcon={() => <Image style={styles.image} source={require('./res/Images/ic_polular.png')} />}
              renderSelectedIcon={() => <Image style={[styles.image,{tintColor:'#6495ED'}]} source={require('./res/Images/ic_polular.png')} />}
              onPress={() => this.setState({ selectedTab: 'tab_popular' })}>
              <View style={styles.page1}>
                <PopularPage {...this.props}/>
              </View>
          </TabNavigator.Item>

          <TabNavigator.Item
              selected={this.state.selectedTab === 'tab_trending'}
              title="趋势"
              selectedTitleStyle={{color:'#6495ED'}}
              renderIcon={() => <Image style={styles.image} source={require('./res/Images/ic_trending.png')} />}
              renderSelectedIcon={() => <Image style={[styles.image,{tintColor:'#6495ED'}] } source={require('./res/Images/ic_trending.png')} />}
              onPress={() => this.setState({ selectedTab: 'tab_trending' })}>
            <View style={styles.page2}>
              <TrendingPage/>
            </View>
          </TabNavigator.Item>

          <TabNavigator.Item
              selected={this.state.selectedTab === 'tab_favorite'}
              title="收藏"
              selectedTitleStyle={{color:'#6495ED'}}
              renderIcon={() => <Image style={styles.image} source={require('./res/Images/ic_favorite.png')} />}
              renderSelectedIcon={() => <Image style={[styles.image,{tintColor:'#6495ED'}] } source={require('./res/Images/ic_favorite.png')} />}
              onPress={() => this.setState({ selectedTab: 'tab_favorite' })}>
            <View style={styles.page2}>
              <WebViewTest {...this.props}/>

            </View>
          </TabNavigator.Item>



          <TabNavigator.Item
              selected={this.state.selectedTab === 'tb_my'}
              title="我的"
              selectedTitleStyle={{color:'#6495ED'}}
              renderIcon={() => <Image style={styles.image} source={require('./res/Images/ic_my.png')} />}
              renderSelectedIcon={() => <Image style={[styles.image,{tintColor:'#6495ED'}] } source={require('./res/Images/ic_my.png')} />}
              onPress={() => this.setState({ selectedTab: 'tb_my' })}>
            <View style={styles.page2}>
              <MyPage {...this.props}/>
            </View>
          </TabNavigator.Item>

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
