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
    Modal,
    Platform,
}from 'react-native';
import CustomKeyPage from './CustomKeyPage';
import SortKeyPage from './SortKeyPage';
import { Navigator } from'react-native-deprecated-custom-components';
import NavBar from '../../common/NavBar'
import {MORE_MENU} from '../../common/MoreMenu';
import GlobalStyles from '../../../res/styles/GlobalStyles';
import ViewUtils from '../../util/ViewUtils';
import AboutPage from '../About/AboutPage';
import ThemeFactory,{ThemeFlags} from '../../../res/styles/ThemeFactory';

export default class CustomTheme extends Component {
    onSelectTheme(ThemeKey){
        this.props.onClose()
    }

    // 创建主题view
    getThemeItem(ThemeKey){
        return <TouchableHighlight
            style={{flex:1}}
            underlayColor='white'
            onPress={()=>this.onSelectTheme(ThemeKey)}
        >
            <View style={[{backgroundColor:ThemeFlags[ThemeKey]}, styles.themeItem]}>

                <Text style={styles.themeTetx}>{ThemeKey}</Text>
            </View>

        </TouchableHighlight>
    }

    // 创建主题列表
    renderThemeItems(){
        var views=[];
        for(let i=0,keys=Object.keys(ThemeFlags),l=keys.length;i<l;i+=3){
            key1=keys[i],key2=keys[i+1],key3=keys[i+2];
            // 根据value创建View
            views.push(<View key={i} style={{flexDirection:'row'}}>
                {this.getThemeItem(key1)}
                {this.getThemeItem(key2)}
                {this.getThemeItem(key3)}
            </View>)
        }
        return views;
    }

    renderContentView(){
        return(
            <Modal
                animationType={"slide"}
                transparent={true}
                // 根据上个页面传来的属性来决定modal框是否显示
                visible={this.props.visible}
                onRequestClose={() => this.props.onClose()}
            >
                <View style={styles.modalContainer}>
                    <ScrollView>
                        {this.renderThemeItems()}
                    </ScrollView>
                </View>

            </Modal>
        )
    }

    render(){
        let view=this.props.visible?<View style={GlobalStyles.root_container}>
                {this.renderContentView()}
            </View>:null;

        return view;
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
    },
    modalContainer:{
        flex:1,
        margin:10,
        marginTop:Platform.OS==='ios'?20:10,
        backgroundColor:'white',
        borderRadius:3,
        shadowColor:'gray',
        shadowOffset:{width:2,height:2},
        shadowOpacity:0.5,
        shadowRadius:2,

    },
    themeItem:{
        flex:1,
        height:120,
        margin:3,
        padding:3,
        borderRadius:2,
        justifyContent:'center',
        alignItems:'center',

    },
    themeTetx:{
        color:'white',
        fontWeight:'500',
        fontSize:16,
    }

})
