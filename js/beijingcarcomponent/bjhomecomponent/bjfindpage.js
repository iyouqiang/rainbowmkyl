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
    FlatList,
} from 'react-native';

import { StackNavigator} from 'react-navigation';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window');

const colums = 3;
const itemWH = (width-(colums+1)*10)/colums;

export default class bjfindpage extends Component {

    constructor(props){
        super(props)

        this.state = {

            swipeToClose: true,
            sliderValue: 0.3,
            currentitemData:'http://www.w3school.com.cn/example/html5/mov_bbb.mp4',
        }
    }

    render() {
        return (
            <View style={styles.container}>
                {this.renderCollectionView()}
            </View>
        );
    }

    renderCollectionView(){
        return(
            <FlatList
                data={
                    [
                        {
                            title: '汽车违章查询',
                            img: 'http://img.25pp.com/uploadfile/soft/images/2014/1011/20141011053559683.jpg',
                            url:'http://www.stc.gov.cn/YLB/XXCX/JDCCX/201310/t20131030_443.htm',
                        },
                        {
                            title: '汽车报价大全',
                            img: 'http://img5.duitang.com/uploads/item/201409/13/20140913141633_QyVPw.jpeg',
                            url:'https://app.autohome.com.cn/apps/',
                        },
                        {
                            title: '爱卡汽车',
                            img: 'http://img.zcool.cn/community/01a98b554425e20000019ae9971fdd.jpg@1280w_1l_2o_100sh.jpg',
                            url:'http://www.xcar.com.cn/',
                        },
                        {
                            title: '汽车之家',
                            img: 'http://img4.duitang.com/uploads/item/201504/18/20150418H3050_efFNW.jpeg',
                            url:'https://www.autohome.com.cn',
                        },
                        {
                            title: 'hao123汽车',
                            img: 'http://img.zcool.cn/community/0137c856d2bde932f875520ffa3880.jpg@2o.jpg',
                            url:'http://www.hao123.com/auto/wangzhi',
                        },
                        {
                            title: '易车网',
                            img: 'http://img.zcool.cn/community/0137c856d2bde932f875520ffa3880.jpg@2o.jpg',
                            url:'http://m.yiche.com/',
                        },
                    ]
                }

                renderItem={({item})=>this.renderRow(item)}

                keyExtractor = {this._extraUniqueKey}

                showsVerticalScrollIndicator={false}

                numColumns={colums}

                getItemLayout={(data,index)=>(
                    {length: itemWH, offset: (itemWH+2) * index, index}
                )}
            />
        );
    }

    _extraUniqueKey(item ,index) {

        return "index"+index+item;
    }

    renderRow(item){
        return(
            <TouchableOpacity
                activeOpacity={0.8}
                onPress={()=>this.clickAction(item)}
            >
                <View style={styles.itemStyle}>
                    <Image source={{uri:item.img}} style={styles.itemImageStyle}/>
                    <Text style={styles.itemtitleStyle}>{item.title}</Text>
                </View>
            </TouchableOpacity>
        )
    }

    clickAction(item){

        this.setState({
            currentitemData:item.vidoe,
        })

         this.props.navigation.navigate('DetailWebPage',{'title':item.title, 'url':item.url});
    }

    componentDidMount() {

    }
}

const styles = StyleSheet.create({
    container: {
        flex:1,
        backgroundColor:'#FFF2E8',
        justifyContent:'center',
        alignItems:'center'
    },
    contentViewStyle: {

        flexDirection:'row',
        //flexWrap:'wrap',
    },

    itemStyle: {
        backgroundColor:'black',
        // 对齐方式
        alignItems:'center',
        //justifyContent:'center',
        // 尺寸
        width:itemWH,
        //height:itemWH + 40,
        margin:5,
        marginTop:10,
        overflow: 'hidden',
    },

    itemImageStyle: {
        // 尺寸
        width:itemWH,
        height:itemWH,
        // 间距
        marginBottom:5,
    },
    itemtitleStyle: {
        color:'white',
        fontSize:13,
        textAlign:'left',
        //alignContent:'center',
        //justifyContent:'center',
        //alignItems:'center',
        marginBottom:5,
        lineHeight:15,
    },
    backgroundVideo: {
        position: 'absolute',
        backgroundColor:'white',
        width:width,
        height:height,
        top: 0,
        left: 0,
        bottom: 0,
        right: 0,
    },
});
