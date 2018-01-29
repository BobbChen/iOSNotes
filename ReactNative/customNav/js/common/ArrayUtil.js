/**
 * Created by chenbo on 2018/1/28.
 */
export default class ArrayUtil{
    static clone(from){
        if (!from)return [];
        let newArray=[];
        for (let i=0,len=from.length;i<len;i++){
            newArray[i]=from[i];
        }
        return newArray;

    }

    // 判断两个数组是否相等
    static isEqual(array1,array2){
        if (!(array1&&array2)) return false;
        if (array1.length!==array2.length) return false;
        for(let i=0,len=array2.length;i<len;i++){
            if (array1[i]!==array2[i]) return false;
        }
        return true;
    }

    // 元素移除
    static remove(array,item){
        if (!array)return;
        for(var i=0,l=array.length;i<l;i++){
            if (item===array[i])array.splice(i,1);
        }
    }
}