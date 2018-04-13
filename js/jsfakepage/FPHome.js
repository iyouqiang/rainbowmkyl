/**
 * Created by Mike on 2017/10/23.
 * 输入不同业主的URL页面 ，切换不同的业主App ， 另一个作用是作为 上架审核App
 */
import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    TextInput,
    TouchableOpacity,
    Dimensions,
    Alert,
    ImageBackground
} from 'react-native';

import { NavigationActions } from 'react-navigation'

let { height, width } = Dimensions.get('window');


const resetAction = NavigationActions.reset({
    index: 0,
    actions: [
        NavigationActions.navigate({ routeName: 'MainTab' })
    ]
});


export default class FPHome extends Component {

    render() {
        return (
            <View style={styles.container}>
                <Text style={styles.titleStyle}>马甲页面</Text>
            </View>
        )
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: '#c0ff3d',
    },

    titleStyle: {
        width: 70,
        color: 'black',
        fontSize: 16,
    },

});
