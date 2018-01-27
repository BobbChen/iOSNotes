/**
 * Created by chenbo on 2018/1/25.
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
}from 'react-native';
import Toast,{DURATION} from 'react-native-easy-toast';

var data = {
    "result":[
        {
           "email": "123.com",
            "fullName": "hahaha"
        },
        {
            "email": "123.com",
            "fullName": "hahaha"
        },
        {
            "email": "123.com",
            "fullName": "hahaha"
        },
        {
            "email": "123.com",
            "fullName": "hahaha"
        },
        {
            "email": "123.com",
            "fullName": "hahaha"
        },
        {
            "email": "123.com",
            "fullName": "hahaha"
        },
        {
            "email": "123.com",
            "fullName": "hahaha"
        }
    ]
};
import PropTypes from 'prop-types';
export default class ListViewDemo extends Component {
    constructor(props){
        super(props);
        const ds= new ListView.DataSource({rowHasChanged:(r1,r2)=> r1 !== r2});
        this.state = {
            dataSource:ds.cloneWithRows(data.result),
            isLoading:true,

        }
        this.onLoad();
    }
    renderRow(item){
        // 设置row高度
        return <View style={styles.row}>
            <TouchableOpacity
                onPress={()=>{
                    this.toast.show(item.fullName,DURATION.LENGTH_LONG)
                }
                }
            >
                <Text style={styles.tips}>{item.email}</Text>
                <Text style={styles.tips}>{item.fullName}</Text>
            </TouchableOpacity>
        </View>

    }
    // 设置cell分割线
    renderSeparator(sectionID, rowID, adjacentRowHighlighted){
        return <View style={styles.line}></View>
    }

    renderFooter(){
        return <Image style={styles.image} source={{uri:'https://images.gr-assets.com/hostedimages/1406479536ra/10555627.gif'}}/>
    }

    // 刷新数据
    onLoad(){
        setTimeout(()=>{
            this.setState({
                isLoading:false
            })
        },2000);
    }


    render(){
        return(
            <View style={styles.container}>
                <ListView
                    dataSource={ this.state.dataSource}
                    renderRow={(item)=>this.renderRow(item)}
                    renderSeparator={(sectionID, rowID, adjacentRowHighlighted)=>this.renderSeparator(sectionID, rowID, adjacentRowHighlighted)}
                    // listView页脚
                    renderFooter={()=>this.renderFooter()}
                    refreshControl = {<RefreshControl
                        refreshing={this.state.isLoading}
                        onRefresh={()=>this.onLoad()}
                    />}
                />
                <Toast ref={toast=>{this.toast=toast}}/>

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
    }
})