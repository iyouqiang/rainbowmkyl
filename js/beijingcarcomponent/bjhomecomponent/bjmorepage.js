/**
 * Created by Yochi on 2017/12/24.
 */

import React,{ Component } from 'react';
import {

    View,
    Text,
    TouchableOpacity,
    StyleSheet,
    Image,
    WebView,
} from 'react-native';

import { StackNavigator} from 'react-navigation';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window');

const colums = 2;
const itemWH = (width-(colums+1)*10)/colums;

export default class bjmorepage extends Component {
    
    render() {
        return (
            <View style={styles.container}>
                <WebView ref='webView'
                         style={styles.webViewStyle}
                         //https://luna.58.com/m/autotemplate?city=sz&creativeid=116' 
                         //http://www.hao123.com/auto/wangzhi
                         //http://m.weizhangwang.com/#_motz_
                         source={{uri:'https://m.jiazhao.com/weizhang/'} }
                         startInLoadingState={true}
                         domStorageEnabled={true}
                         javaScriptEnabled={true}
                         injectedJavaScript={'document.getElementsByClassName(\'head\')[0].style.display=\'none\';'}
                >
                </WebView>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex:1,
        backgroundColor:'white',
        justifyContent:'center',
        alignItems:'center'
    },
    webViewStyle: {
        flex:1,
        width:width,
    }
});
