/**
 * Created by Yochi on 2017/12/24.
 */
'use strict'

import React,{ Component } from 'react';
import {

    View,
    Text,
    TouchableOpacity,
    StyleSheet,
    Image,
    Platform,
} from 'react-native';

import Ionicons from "react-native-vector-icons/Ionicons";

let navigationOptionInfo = {

}

navigationOptionInfo.commomHeader = (props) => {

    const { navigation } = props;
    const { state } = navigation;
    const { params } = state;

    return {

        headerTitle: `${params.title}`,
        headerLeft:(
            <TouchableOpacity onPress={()=>{

                navigation.goBack();
            }}>
                <View style={{width:60, bottom:0, left:10}}>
                    <Ionicons name={ "ios-arrow-back-outline" }  size={25} color='white' style={{backgroundColor:'transparent'}}/>
                </View>

            </TouchableOpacity>
        ),

        headerStyle : { backgroundColor: '#4194FC', marginTop: Platform.OS === 'ios' ? 0 : StatusBar.currentHeight },
        headerTitleStyle : { fontSize: 18, color: 'white', alignSelf: 'center' },

        gesturesEnabled:false,
        mode:'card',  // card 默认 modal iOS独有
        headerMode:'screen',
        /**
         headerMode: 导航栏的显示模式:
         float: 无透明效果, 默认
         screen: 有渐变透明效果, 如微信QQ的一样
         none: 隐藏导航栏
         * */
        cardStyle:({backgroundColor:'blue'}),
        onTransitionStart:((route)=>{
            console.log('开始动画');
        }),
        onTransitionEnd:((route)=>{
            console.log('结束动画');
        }),
    };
}

module.exports = navigationOptionInfo;