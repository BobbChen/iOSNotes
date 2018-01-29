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
    TouchableHighlight,
    Alert,
}from 'react-native';
import CustomKeyPage from './CustomKeyPage';
import LanguageDao,{FLAG_LANGUAGE} from '../../expand/LanguageDao';
import ArrayUtil from '../../common/ArrayUtil';
import SortableListView from 'react-native-sortable-listview';
import { Navigator } from'react-native-deprecated-custom-components';
import NavBar from '../../common/NavBar'
import ViewUtils from '../../util/ViewUtils';

export default class SortKeyPage extends Component {
    constructor(props){
        super(props);
        this.dataArray=[];
        this.sortResultArray=[];
        this.orginalCheckArray=[];
        this.state={
            checkedArray:[]
        }

    }

    componentDidMount(){
        this.languageDao = new LanguageDao(FLAG_LANGUAGE.flag_key);
        this.loadDta();
    }

    // 读取数据库中所有标签
    loadDta(){
        this.languageDao.fetch()
            .then(result=>{
                // 从数据中筛选出已经订阅过的标签
                this.getCheckedItem(result);

            })

    }

    getCheckedItem(result){
        // 记录一次原始数据
        this.dataArray = result;
        let checkedArray=[];
        for (let i=0,len=result.length;i<len;i++){
            let data=result[i];
            // 已经订阅，放入checkedArray
            if(data.checked) checkedArray.push(data);

        }
        this.setState({
            checkedArray:checkedArray
        })
        this.originalCheckedArray=ArrayUtil.clone(checkedArray);
    }

    onSave(isChecked){
        // 判断是否排序发生变化
        if(!isChecked&&ArrayUtil.isEqual(this.orginalCheckArray,this.state.checkedArray)){
            this.props.navigator.pop();
            return;
        }
        // 获取最新的排序结果
        this.getSortResult();
        // 将最新的结果进行保存
        this.languageDao.save(this.sortResultArray);
        this.props.navigator.pop();

    }

    getSortResult(){

        this.sortResultArray = ArrayUtil.clone(this.dataArray);
        for (let i = 0, j = this.originalCheckedArray.length; i < j; i++) {
            let item = this.originalCheckedArray[i];
            let index = this.dataArray.indexOf(item);
            this.sortResultArray.splice(index, 1, this.state.checkedArray[i]);
        }
        {/*
        this.sortResultArray = ArrayUtil.clone(this.dataArray);
        for(let i=0,l=this.orginalCheckArray.length;i<l;i++){
            let item = this.orginalCheckArray[i];
            // 获取位置
            let index =this.dataArray.indexOf(item);
            this.sortResultArray.splice(index, 1, this.state.checkedArray[i]);


        }
        */}
    }

    render(){

        let rightButton= <TouchableOpacity
            onPress={()=>this.onSave()}
        >
            <View style={{margin:5,color:'white'}}>
                <Text style={styles.rightButton}>保存</Text>
            </View>
        </TouchableOpacity>

        return(
            <View style={styles.container}>
                <NavBar
                    title='我的'
                    style={{backgroundColor:'#6495ED'}}
                    leftButton={ViewUtils.getLeftButton(()=>{
                        if (ArrayUtil.isEqual(this.originalCheckedArray,this.state.checkedArray)){
                            // 如果相等，没有排序，直接返回上一页
                            this.props.navigator.pop();
                        }else{
                            // 弹出提示信息，是否保存修改
                            Alert.alert(
                                '提示',
                                '要保存修改吗？',
                                [
                                    {text:'不保存', onPress:()=>{
                                        this.props.navigator.pop();
                                    },style:'cancel'},
                                    {text:'保存',onPress:()=>{
                                        this.onSave(true);
                                    }}
                                ]
                            )
                        }

                    })}
                    rightButton={rightButton}
                />

                <SortableListView
                    style={{ flex: 1 }}
                    data={this.state.checkedArray}

                    order={Object.keys(this.state.checkedArray)}
                    onRowMoved={e => {
                      this.state.checkedArray.splice(e.to, 0, this.state.checkedArray.splice(e.from, 1)[0])
                      this.forceUpdate()
                    }}
                    renderRow={row => <SortCell data={row} />}
                />

            </View>
        )
    }
}

class SortCell extends Component{
    render(){
        return (
        // TouchableHighlight组件内部子元素只能有一个
            <TouchableHighlight
                underlayColor={'#eee'}
                style={styles.item}
                {...this.props.sortHandlers}
            >
                <View style={styles.row}>
                    <Image
                        style={styles.image}
                        source={require('./images/ic_sort.png')}/>
                    <Text>{this.props.data.name}</Text>
                </View>
            </TouchableHighlight>
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
        padding: 25,
        backgroundColor: '#F8F8F8',
        borderBottomWidth: 1,
        borderColor: '#eee',
    },
    row:{
        flexDirection:'row',
        alignItems:'center',
    },
    image:{
        tintColor:'#2196f3',
        height:16,
        width:16,
        marginRight:10,
    },
    rightButton:{
        fontSize:16,
        color:'white',
    }
})
