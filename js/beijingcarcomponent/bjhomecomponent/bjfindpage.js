/**
 * Created by Yochi on 2017/12/24.
 */

import React,{ Component } from 'react';
import LinearGradient from 'react-native-linear-gradient';
import {

    View,
    Text,
    TouchableOpacity,
    StyleSheet,
    Image,
    FlatList,
    BVLinearGradient,
    ImageBackground,
} from 'react-native';

import { StackNavigator} from 'react-navigation';

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window');

const colums = 2;
const itemWH = (width-(colums+1)*2)/colums;

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
                            title: '汽车报价',
                            img: 'http://img4.duitang.com/uploads/item/201504/18/20150418H3050_efFNW.jpeg',
                            url:'http://m.yiche.com/',
                        },
                        {
                            title: '养车无忧',
                            img: 'http://img5.duitang.com/uploads/item/201409/13/20140913141633_QyVPw.jpeg',
                            url: 'http://m.yangche51.com',
                        },
                        {
                            title: '二手车',
                            img: 'http://img.zcool.cn/community/01a98b554425e20000019ae9971fdd.jpg@1280w_1l_2o_100sh.jpg',
                            url:'https://luna.58.com/m/autotemplate?city=sz&temname=car_common&tag=juhe_common_first_ershouche&PGTID=0d200000-0000-470b-948c-7943830be24f&ClickID=1',
                        },
                        {
                            title: '二手交易',
                            img: 'http://img4.duitang.com/uploads/item/201504/18/20150418H3050_efFNW.jpeg',
                            url:'https://luna.58.com/m/autotemplate?city=sz&temname=sale_common&tag=juhe_common_first_ershou_common&PGTID=0d200000-0000-4ce6-fc98-17f757e739af&ClickID=1',
                        },
                        {
                            title: '找家政',
                            img: 'http://img.zcool.cn/community/0137c856d2bde932f875520ffa3880.jpg@2o.jpg',
                            url:'https://luna.58.com/m/autotemplate?city=sz&temname=jiazheng_common&tag=juhe_common_first_jiazheng_common&PGTID=0d200000-0000-4a78-0ea8-6190c84156c5&ClickID=1',
                        },
                        {
                            title: '发现更多',
                            img: 'http://img.zcool.cn/community/0137c856d2bde932f875520ffa3880.jpg@2o.jpg',
                            url:'https://luna.58.com/m/autotemplate?city=sz&creativeid=116',
                            
                        },
                    ]
                }

                //url:'http://www.hao123.com/auto/wangzhi',

                renderItem={({item})=>this.renderRow(item)}

                keyExtractor = {this._extraUniqueKey}

                showsVerticalScrollIndicator={false}

                numColumns={colums}

                getItemLayout={(data,index)=>(
                    {length: itemWH, offset: (itemWH+2) * index, index}
                )}

                // ItemSeparatorComponent={() => <View style={{height:0.5, backgroundColor:'#e5e5e5'}}></View>}
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

            <LinearGradient colors={['#3974CB','#4169E1','#4194FC','#A5D5FD']} style={styles.itemStyle} >
            
                <View style={styles.itemStyle}>
                    
                    <Text style={styles.itemtitleStyle}>{item.title}</Text>
                </View>
                
            </LinearGradient>
                
                {/*<ImageBackground source={require('../bgimages/wz_renzheng_img.png') } style={styles.itemStyle}>*/}
                
                    {/*<Text style={styles.itemtitleStyle}>{item.title}</Text>*/}
                    {/**/}
                {/*</ImageBackground>*/}

            </TouchableOpacity>
        )
    }

// <Image source={{uri:item.img}} style={styles.itemImageStyle}/>

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
        backgroundColor:'white',
        justifyContent:'center',
        alignItems:'center'
    },
    contentViewStyle: {

        flexDirection:'row',
        //flexWrap:'wrap',
    },

    itemStyle: {
        //backgroundColor:'#D0D3D4',
        // 对齐方式
        alignItems:'center',
        justifyContent:'center',
        // 尺寸
        width:itemWH,
        height:80,
        marginLeft:1,
        marginRight:1,
        marginTop:2,
        overflow: 'hidden',
        //borderBottomWidth: 0.5,
        //borderRightWidth: 0.5,
        borderColor: '#e5e5e5',
    },

    itemImageStyle: {
        // 尺寸
        width:itemWH,
        height:itemWH,
        // 间距
        marginBottom:5,
    },

    itemtitleStyle: {
        color:'white',//'#4194FC',
        fontSize:18, 
        textAlign:'left',
        //alignContent:'center',
        //justifyContent:'center',
        //alignItems:'center',
        lineHeight:30,
        backgroundColor:'transparent',
    },
});
