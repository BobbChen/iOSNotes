/**
 * Created by chenbo on 2018/1/27.
 */
/**
 * Created by chenbo on 2018/1/26.
 */
// 根据标识来判断使用的模块
import GitHubTrending from 'GitHubTrending';
export var FLAG_STORAGE={flag_popular:'popular',flag_trending:'trending'};

export default class NetWorkManager{
    // 初始化构造方法需要传入flag
    constructor(flag){
        this.flag=flag;
        if(flag===FLAG_STORAGE.flag_trending)this.trending=new GitHubTrending();

    }

    get(url){
        return new Promise((resolve, reject)=>{
            if(this.flag===FLAG_STORAGE.flag_trending){
                this.trending.fetchTrending(url)
                    .then(result=>{
                        resolve(JSON.stringify(result));
                    })
            }else
            {
                fetch(url)
                    .then(response=>response.json())
                    .then(result=>{
                        resolve(result);
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