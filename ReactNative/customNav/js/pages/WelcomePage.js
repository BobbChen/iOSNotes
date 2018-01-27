/**
 * Created by chenbo on 2018/1/27.
 */
import React, {Component} from 'react';
import {
    View,
    StyleSheet,
    Text,
} from 'react-native'
import NavigationBar from '../common/NavBar'
import App from '../../App'
export default class WelcomePage extends Component {
    constructor(props) {
        super(props);
    }

    componentDidMount() {
        this.timer=setTimeout(()=> {
            this.props.navigator.resetTo({
                component: App,
                params:{
                    theme:this.theme,
                }
            });
        }, 500);
    }
    componentWillUnmount(){
        this.timer&&clearTimeout(this.timer);
    }
    render() {
        return null;
    }
}
const styles = StyleSheet.create({
    container: {
        flex: 1,

    },
    tips: {
        fontSize: 29
    }
})
