/**
 * Created by chenbo on 2018/1/26.
 */
import React,{Component} from 'react';
import {
    AsyncStorage,
}from 'react-native';

import GitHubTrending from 'GitHubTrending';

// 根据标识来判断使用的模块
export var FLAG_STORAGE={flag_popular:'popular',flag_trending:'trending'};

export default class NewManager{
    // 初始化构造方法需要传入flag
    constructor(flag){
        this.flag=flag;
        if(flag===FLAG_STORAGE.flag_trending)this.trending=new GitHubTrending();

    }

    // 获取数据(包含缓存)
    getDataAndLoacation(url){
        return new Promise((resolve, reject)=> {
            // 先获取缓存数据
            this.getlocaData(url)
                .then(result=>{
                    if(result){
                        resolve(result)
                    }else{
                        this.get(url)
                            .then(result=>{
                                resolve(result);
                            })
                    }
                })
        })
    }






    // 获取离线缓存在本地的数据
    getlocaData(url){
        return new Promise((resolve, reject)=>{
            AsyncStorage.getItem(url,(error,result)=>{
                if (!error){
                    resolve(JSON.stringify(result));
                }
            })
        })
    }


    // 保存数据到数据库
    saveData(url,data,callBack){
        if (!url||!data) return;

        // 处理数据，判断数据是否过时,update_data--当前时间
        let wrapData = {items:data,update_data:new Date().getTime()};

        AsyncStorage.setItem(url,wrapData,callBack);

    }

    // 数据是否过时
    checkData(longTime){
        let currentDate=new Date();
        let tDate=new Date();
        tDate.setTime(longTime);
        // 月份不相等，过时
        if(currentDate.getMonth()!==tDate.getMonth()) return false;
        if(currentDate.getDay()!==tDate.getDay()) return false;
        // 时间相差四个小时以上，数据过时
        if(currentDate.getHours()-tDate.getHours()>4) return false;
        return true;
    }


    get(url){
        return new Promise((resolve, reject)=>{
            if(this.flag===FLAG_STORAGE.flag_trending){
                this.trending.fetchTrending(url)
                    .then(result=>{
                        resolve(result);

                    })
            }else
            {
                fetch(url)
                    .then(response=>response.json())
                    .then(result=>{
                        resolve(result.items);
                        // 获取到数据之后缓存一次
                        this.saveData(url,result.items);

                    })
                    .catch(error=>{
                        reject(error);
                    })
            }

        })
    }

    post(url,data){
        return new Promise((resolve, reject)=>{
            fetch(url,{
                method:'POST',
                header:{
                    'Accept':'applocation/json',
                    'Content-Type':'applocation/json'
                },
                body:JSON.stringify(data)
            })
                .then(response=>response.json())
                .then(result=>{
                    resolve(result);
                })
                .catch(error=>{
                    reject(error);
                })


        })

    }
}