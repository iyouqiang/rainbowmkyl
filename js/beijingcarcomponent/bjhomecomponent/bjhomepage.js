/**
 * Created by guiyongdong on 2017/5/21.
 */
import React, {Component} from 'react';
import {
    View,
    Text,
    StyleSheet,
    SectionList,
    Image,
    TouchableOpacity,

} from 'react-native';

import Spinkit from 'react-native-spinkit';
import requesttool from '../bjhttprequest/requesttool';
import requestconfig from '../bjhttprequest/requestconfig';
import {homeInfo} from "../bjhttprequest/bjHomeinfo";

const currentTimestamp = new Date().getTime();
var Dimensions = require('Dimensions');
var {width}    = Dimensions.get('window');
var {height}   = Dimensions.get('window');
var CELLHEIGHT = 100;

export default class bjhomepage extends Component {

    constructor(props) {

        super(props);

        this.state = {

            sections:homeInfo,
            refreshing:false,
            showLoading:true,
        }
    }

    render() {

        return(
            <View style={styles.container}>
                {this._renderSectionlistView()}
            </View>
        )
    }
        componentDidMount() {
    }

    _renderSectionlistView() {

        return (
            <SectionList  style={styles.sectionListStyle}

                          sections={this.state.sections}

                          keyExtractor = {this._extraUniqueKey}

                          refreshing={this.state.refreshing}

                          enableEmptySections={
                                 <View>
                                     <Text>暂无数据</Text>
                                 </View>
                             }

                          onRefresh = {

                                 () => {

                                     this.setState({
                                         refreshing : true,
                                     });

                                     {this._requestHomeinfo()}
                                 }
                             }

                          onEndReachedThreshold={0.3}

                          onEndReached={(info) => {
                                 this.setState({
                                     refreshing : true,
                                 }),
                                     this.setState({
                                         refreshing : false,
                                     })
                                 console.log('我是刷新'+ info);
                             } }

                          showsVerticalScrollIndicator={false}

                          ItemSeparatorComponent={() => <View style={{height:0.5, backgroundColor:'#e5e5e5'}}></View>}

                          renderItem={ this._renderSectionItemCell }
            />
        );
    }

    _extraUniqueKey(item ,index) {

        return "index"+index+item;
    }

    _renderSectionItemCell = ({item, index, section})=>{

        return (
             <TouchableOpacity activeOpacity={0.9} onPress={()=>{

                    // const setParamsAction = NavigationActions.setParams({
                    //     params: {'title':item.title, 'url':item.url},
                    //     key: 'DetailWebPage',
                    // });
                    // this.props.navigation.dispatch(setParamsAction)

                    this.props.navigation.navigate('DetailWebPage',{'title':item.title, 'url':item.url});
                }}>

            <View style={styles.homeTitleViewStyle}>

                <Image  source={{uri:item.images[0]}} style={styles.homeIconStyle} />

                <View style={styles.homeSubTitleViewStyle}>

                    <View>
                        <Text style={styles.homeTitleTextStyle}>{item.title}</Text>
                    </View>

                    <View style={styles.homeSubBottomViewStyle}>
                        <Text style={styles.homeSubTitleTextStyle}>{item.media_name}</Text>
                        <Text style={styles.homeSubTitleTextStyle}>{item.date}</Text>
                    </View>

                </View>

            </View>

             </TouchableOpacity>
        );

    }
        _requestHomeinfo() {

        // requesttool.get(requestconfig.api.bjbaseurl, {
        //     appid:'x01Gjdp0kvyAVA6SZn7DGAt91',
        //     nonce:'carsfdyuiy54',
        //     timestamp:currentTimestamp,
        //     secretkey:'0b0fc9611c27a6cf657d249819dbad1078539e9',
        //     channel_id:'汽车',
        //     offset:'0',
        //     count:'10',
        // }).then((data)=>{
        //
        //     this.setState({
        //
        //         sections:data,
        //         refreshing:false,
        //         showLoading:false,
        //     })
        // })
        //     .catch((error)=>{
        //         console.log('错误信息：'+error);
        //         this.setState({
        //             refreshing: false,
        //             showLoading: false,
        //         })
        //     })
            this.setState({ refreshing : false });
    }
}

const styles = StyleSheet.create({

    container:{

        flex:1,
        justifyContent:'center',
        alignItems:'center',
        backgroundColor:'#F7F7F7'
    },

    sectionListStyle:{
        width:width,
        height:height,
        margin:0,
    },

    homeIconStyle:{

        height:80,
        width:120,
        margin:5,
    },

    homeTitleViewStyle:{

        flexDirection:'row',
        alignItems:'center',
        // justifyContent: '
        // center',
    },

    homeTitleTextStyle:{

        width:width -140,
        fontSize:15,
        color:'#040404',
    },

    homeSubTitleViewStyle:{
        flexDirection:'column',
        margin:5,
        // justifyContent: 'center',
        // alignItems:'center',
    },

    homeSubBottomViewStyle:{

        flexDirection:'row',
        justifyContent: 'space-between',
        marginTop:8,
    },

    homeSubTitleTextStyle:{

        color:'#999999',
        fontSize:12,
    },
});