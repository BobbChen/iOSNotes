/**
 * Created by chenbo on 2018/1/27.
 */
import React,{Component} from 'react';
import {
    View,
    Text,
    Image,
    TouchableOpacity,
    StyleSheet,
}from 'react-native';
import HTMLView from 'react-native-htmlview'

import { Navigator } from'react-native-deprecated-custom-components';

export default class TrendingCell extends Component{
    render(){
        return <TouchableOpacity
            onPress={this.props.onSelect}
            style={styles.container}>
            <View style={styles.cell_container}>
                <Text style={styles.title}>{this.props.data.fullName}</Text>
                <HTMLView
                    value={this.props.data.description}
                    onLinkPress={(url)=>{}}
                />


                <Text style={styles.description}>{this.props.data.meta}</Text>
                <View style={{flexDirection:'row',justifyContent:'space-between'}}>
                    {/*作者*/}
                    <View style={{flexDirection:'row',alignItems:'center'}}>
                        <Text>Build By:</Text>
                        {this.props.data.contributors.map((result,i,array)=>{
                            return<Image
                                key={i}
                                style={{height:22,width:22}}
                                source={{uri:array[i]}}
                            />
                        })}
                    </View>

                    <Image style={{width:22,height:22}} source={require('../../res/Images/ic_star.png')}/>

                </View>
            </View>
        </TouchableOpacity>
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
    },
    cell_container:{
        backgroundColor:'white',
        padding:10,
        marginLeft:5,
        marginRight:5,
        // 垂直边距
        marginVertical:3,
        borderWidth:0.5,
        shadowColor:'gray',
        shadowOffset:{width:0.5,height:0.5},
        shadowOpacity:0.4,
        shadowRadius:1,
        borderColor:'#dddddd',
        // android阴影
        elevation:2,
    },
    title:{
        fontSize:16,
        color:'#212121',
        marginBottom:2,
    },
    description:{
        fontSize:14,
        color:'#757575',
        marginBottom:2,
        borderRadius:2,

    }

})