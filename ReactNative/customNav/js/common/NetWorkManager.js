/**
 * Created by chenbo on 2018/1/27.
 */
/**
 * Created by chenbo on 2018/1/26.
 */
export default class NetWorkManager{
    static get(url){
        return new Promise((resolve, reject)=>{
            fetch(url)
                .then(response=>response.json())
                .then(result=>{
                    resolve(result);
                })
                .catch(error=>{
                    reject(error);
                })

        })
    }

    static post(url,data){
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