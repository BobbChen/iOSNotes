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
    Alert,
}from 'react-native';
import ViewUtils from '../../util/ViewUtils';
import NavBar from '../../common/NavBar'
import LanguageDao,{FLAG_LANGUAGE} from '../../expand/LanguageDao';
import ChecBox from 'react-native-check-box';
import ArrayUtil from '../../common/ArrayUtil';

export default class CustomKeyPage extends Component {
    constructor(props){
        super(props);
        this.languageDao=new LanguageDao(FLAG_LANGUAGE.flag_key);
        this.isRemoveKey=this.props.isRemoveKey;
        this.state={
            dataArray:[]
        }
        this.changeValues=[];

    }

    componentDidMount(){
        this.loadData();
    }
    // 加载标签
    loadData(){
        this.languageDao.fetch()
            .then(result=>{
                this.setState({
                    dataArray:result
                })
            })

    }

    renderCheckBox(data){
        return(
            <ChecBox style={{flex:1,padding:10}} onClick={()=>this.onClick(data)}
                     leftText={data.name}

                     isChecked={this.isRemoveKey?false:data.checked}
                     checkedImage={<Image style={{tintColor:'#6495ED'}} source={require('./images/ic_check_box.png')} />}
                     unCheckedImage={<Image style={{tintColor:'#6495ED'}} source={require('./images/ic_check_box_outline_blank.png')}/>}

                     />
        )
    }

    // 点击之后修改,将原来
    onClick(data){
        // 如果不是标签移除页面，才进行状态的修改
        if(!this.isRemoveKey) data.checked = !data.checked;
        for(var i=0,len=this.changeValues.length;i<len;i++){
            let tmp =this.changeValues[i];
            // 如果包换选中的这个，就将次元素移除
            if(tmp===data){
                this.changeValues.splice(i,1);
            }

        }
        // 如果不包含，则将该元素添加到数组中
        this.changeValues.push(data);
    }


    // 返回的时候判断数据是否需要保存
    onSave(){
        // 如果changeValues数组元素不等于0证明发生了修改，则进行持久化保存，否则直接返回
        if(this.changeValues.length===0){
            this.props.navigator.pop();
            return;
        }

        for(let i=0,l=this.changeValues.length;i<l;i++){
            ArrayUtil.remove(this.state.dataArray,this.changeValues[i]);
        }

        this.languageDao.save(this.state.dataArray);
        this.props.navigator.pop();

    }

    // 展示数据
    renderView(){
        if(!this.state.dataArray || this.state.dataArray.length===0) return null;
        let len = this.state.dataArray.length;
        let Views = [];
        for (let i=0,l=len-2;i<l;i+=2){
            Views.push(
                <View key={i}>
                    <View style={styles.item}>
                        {this.renderCheckBox(this.state.dataArray[i])}
                        {this.renderCheckBox(this.state.dataArray[i+1])}
                    </View>
                    <View style={styles.line}></View>
                </View>
            )
        }
        Views.push(
            <View key={len-1}>
                <View style={styles.item}>
                    {len%2===0?this.renderCheckBox(this.state.dataArray[len-2]):null}
                    {this.renderCheckBox(this.state.dataArray[len-1])}
                </View>
                <View style={styles.line}></View>
            </View>
        )


        return Views;
    }
    onBack(){
        if(this.changeValues.length===0){
            this.props.navigator.pop();
        }else
        {
            // 弹出提示信息，是否保存修改
            Alert.alert(
                '提示',
                '要保存修改吗？',
                [
                    {text:'不保存', onPress:()=>{
                        this.props.navigator.pop();
                    },style:'cancel'},
                    {text:'保存',onPress:()=>{
                        this.onSave();
                    }}
                ]


            )


        }
    }



    render(){
        let rightButtonTitle =this.isRemoveKey?'移除':'保存';
        let rightButton = <TouchableOpacity
            onPress={()=>this.onSave()}
        >
            <View style={{margin:5}}>
                <Text style={styles.rightButton}>{rightButtonTitle}</Text>
            </View>
        </TouchableOpacity>

        let title = this.isRemoveKey?'移除标签':'自定义标签';

        return(
            <View style={styles.container}>
                <NavBar
                    title={title}
                    style={{backgroundColor:'#6495ED'}}
                    leftButton={ViewUtils.getLeftButton(()=>this.onBack())}
                    rightButton={rightButton}
                />
                <ScrollView>
                    {this.renderView()}
                </ScrollView>
            </View>
        )
    }
}
const styles=StyleSheet.create({
    container:{
        flex:1,
        backgroundColor:'gray'
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
    rightButton:{
        fontSize:20,
        color:'white'
    },
    line:{
        height:0.3,
        backgroundColor:'gray',

    },
    item:{
        flexDirection:'row',
        alignItems:'center',
    }
})
