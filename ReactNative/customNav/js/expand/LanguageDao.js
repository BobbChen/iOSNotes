/**
 * Created by chenbo on 2018/1/27.
 */
import React,{Component} from 'react';
import {
    View,
    Text,
    StyleSheet,
    AsyncStorage,
    TextInput,
}from 'react-native';
import keys from '../../res/data/keys.json';
export var FLAG_LANGUAGE={flag_language:'flag_language_language',flag_key:'flag_language_key'};
export default class LanguageDao{
    // 根据传入的flag来判断调用者是哪个模块
    constructor(flag){
        this.flag = flag
    }
    save(data){
        AsyncStorage.setItem(this.flag,JSON.stringify(data),(error)=>{

        });
    }



    fetch(){
        return new Promise((resolve,reject)=>{
            AsyncStorage.getItem(this.flag,(error,result)=>{
                if(error){
                    reject(error);
                }else{
                    if(result){
                        try{
                            resolve(JSON.parse(result));
                        }catch (e){
                            reject(e);
                        }
                    }else
                    {
                        var data =this.flag===FLAG_LANGUAGE.flag_key?keys:null;
                        this.save(data);
                        resolve(data);
                    }
                }
            })
        })

    }
}

