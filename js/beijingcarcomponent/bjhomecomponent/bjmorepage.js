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
                         source={{uri: 'http://www.hao123.com/auto/wangzhi'} }
                         startInLoadingState={true}
                         domStorageEnabled={true}
                         javaScriptEnabled={true}
                >
                </WebView>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex:1,
        backgroundColor:'#FFF2E8',
        justifyContent:'center',
        alignItems:'center'
    },
    webViewStyle: {
        flex:1,
        width:width,
    }
});
