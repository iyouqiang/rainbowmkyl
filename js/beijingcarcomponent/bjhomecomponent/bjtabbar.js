import React,{ Component } from 'react';

import {
    StatusBar,
    StyleSheet,
    Platform,
    Image,
    Dimensions
} from 'react-native';

import { StackNavigator,TabNavigator,TabBarBottom,TabBarTop} from 'react-navigation';

import bjhomepage from './bjhomepage';
import bjfindpage from './bjfindpage';
import bjmorepage from './bjmorepage';
import bjwebviewpage from './bjwebviewpage';

const HomeIcon = require('../../jsfakepage/img/ic_tabbar_home_active.png');
const FindIcon = require('../../jsfakepage/img/ic_hometest2_active.png');
const MoreIcon = require('../bgimages/public_list_ic.png');

const mainTab = TabNavigator(
    {
        Homepage:{
            screen:bjhomepage,
            navigationOptions: () => TabOptions('头条', HomeIcon, HomeIcon, '头条'),
        },
        Findpage:{
            screen:bjfindpage,
            navigationOptions: () => TabOptions('发现', FindIcon, FindIcon, '发现'),
        },
        Morepage:{
            screen:bjmorepage,
            navigationOptions: () => TabOptions('更多', MoreIcon, MoreIcon, '更多'),
        }
    },
    {
        // tabBarComponent:TabBarBottom,
        tabBarPosition:'bottom',
        swipeEnabled:true,
        animationEnabled:false,
        lazy:true,
        initialRouteName:'Homepage',
        order:(['Homepage','Findpage','Morepage']),
        backBehavior:'none',
        tabBarOptions:{
            activeTintColor:'#4194FC',
            inactiveTintColor:'#074467',
            showIcon:true,
            showLabel:true,
            upperCaseLabel:false,
            labelStyle:{
                fontSize:12
            },
            indicatorStyle:'green',
            pressColor:'#823453',
            pressOpacity:0.8,
            scrollEnabled:true,
            tabStyle:{
                height:44
            }
        }
    }
);

const TabOptions = (tabBarTitle, normalImage, selectedImage, navTitle) => {

    const tabBarLabel = tabBarTitle;
    const tabBarIcon  = (({ tintColor, focused }) => {
        return (
            <Image resizeMode="stretch"
                // 可以用过判断focused来修改选中图片和默认图片
                source={!focused ? normalImage : selectedImage}
                // 如果想要图标原来的样子可以去掉tintColor
                style={[(Platform.OS === 'ios') ? { height: 26, width: 26 } : { height: 24, width: 24 }, { tintColor: tintColor }]}
            />
        )
    });
    const headerTitle = navTitle;
    const headerTitleStyle = { fontSize: 18, color: 'white', alignSelf: 'center' };
    // header的style
    const headerStyle = { backgroundColor: '#4194FC', marginTop: Platform.OS === 'ios' ? 0 : StatusBar.currentHeight };
    const tabBarVisible = true;
    // const header = null;
    return { tabBarLabel, tabBarIcon, headerTitle, headerTitleStyle, headerStyle, tabBarVisible };
};

const bjNav = StackNavigator(
    {
        mainTab : {
            screen:mainTab
        },

        DetailWebPage :{
            screen:bjwebviewpage
        }
    },

    {
        headerTintColor:'#CC2C1B',
        headerStyle:{ backgroundColor:'#4194FC'},

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
    },
);

// export default class bjtabbar extends Component {
//     render() {
//         return(
//             <bjNav/>
//         );
//     }
// }

export default bjNav;