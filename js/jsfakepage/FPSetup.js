
import React, { Component } from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    View,
    Image
} from 'react-native';

const MeIcon = require('./img/ic_tabbar_me_active.png');
const Hometest2 = require('./img/ic_hometest2_active.png');

export default class FPSetup extends Component {

    static navigationOptions = ({navigation,screenProps}) => ({
        // 这里面的属性和App.js的navigationOptions是一样的。
        headerTitle:navigation.state.params?navigation.state.params.headerTitle:'ESetup',
        tabBarLabel:navigation.state.params?navigation.state.params.tabBarLabel:'ESetup',
        tabBarIcon: (({tintColor,focused}) => {
            if(focused){
                // 做操作
            }
            return(
                <Image
                    // 可以用过判断focused来修改选中图片和默认图片
                    source={!focused ? Hometest2 : MeIcon}
                    // 如果想要图标原来的样子可以去掉tintColor
                    style={[{height:35,width:35 }]}
                />
            )
        }),
        headerRight:(
            <Text style={{color:'red',marginRight:20}} onPress={()=>navigation.state.params.navigatePress()}>我的</Text>
        ),
    })

    componentDidMount(){
        // 通过在componentDidMount里面设置setParams将title的值动态修改
        this.props.navigation.setParams({
            headerTitle:'测试测试成都市',
            tabBarLabel:'标题测试',
            navigatePress:this.navigatePress
        });
    }

    navigatePress = () => {
        alert('点击headerRight');
    }

    render() {
        return (
            <View style={styles.container}>
               <Text>马甲页面</Text>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
        backgroundColor: 'blue',
    },
    welcome: {
        fontSize: 20,
        textAlign: 'center',
        margin: 10,
    },
    instructions: {
        marginTop:10,
        textAlign: 'center',
        color: '#333333',
        marginBottom: 5,
        fontSize:18
    },
});

