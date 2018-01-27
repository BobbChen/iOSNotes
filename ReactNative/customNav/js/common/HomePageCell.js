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
export default class HomePageCell extends Component{
    render(){
        return <TouchableOpacity style={styles.container}>
            <View style={styles.cell_container}>
                <Text style={styles.title}>{this.props.data.full_name}</Text>
                <Text style={styles.description}>{this.props.data.description}</Text>
                <View style={{flexDirection:'row',justifyContent:'space-between'}}>
                    {/*作者*/}
                    <View style={{flexDirection:'row',alignItems:'center'}}>
                        <Text>作者:</Text>
                        <Image
                            style={{height:22,width:22}}
                            source={{uri:this.props.data.owner.avatar_url}}
                        />
                    </View>

                    {/*收藏数*/}
                    <View style={{flexDirection:'row',alignItems:'center'}}>
                        <Text>收藏数:</Text>
                        <Text>{this.props.data.stargazers_count}</Text>
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