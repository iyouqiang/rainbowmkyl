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
import {addOneInfo} from "../bjhttprequest/bjHomeinfo";
import {addtwoInfo} from "../bjhttprequest/bjHomeinfo";
import {addThirdInfo} from "../bjhttprequest/bjHomeinfo";

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
            loadingstr:'上拉加载更多',
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

                          ListFooterComponent={()=><View style={{height:30, alignItems: 'center'}}><Text>{this.state.loadingstr}</Text></View>}

                          onEndReached={(info)=>{
                              
                              let lastDic = this.state.sections[0];
                              var lastArray = lastDic.data;
                              
                              let addTempInfo = [];
                              
                              switch(lastArray.length/10)
                              {
                                  case 1:
                                      addTempInfo = addOneInfo;
                                      break;
                                  case 2:
                                      addTempInfo = addtwoInfo;
                                      break;
                                  case 3:
                                      addTempInfo = addThirdInfo;
                              }
                              
                              if (lastArray.length/10 > 3 ) {
    
                                  this.setState({loadingstr:'没有更多数据'});
                                  return;
                              }
                              
                              var temparray = lastArray.concat(addOneInfo);
                              let tempHome  = [{ title:'汽车', data: temparray}];
                              
                              this.setState({
                                  sections:tempHome,
                                  loadingstr:'正在加载',
                              });
    
                              this.timer = setTimeout(
                                  () => {
                                        this.setState({loadingstr:'上拉加载更多'});
                                      },
                                  500
                              );
                          }}
                          
                          onEndReachedThreshold={0}
            />
        );
    }
    
    componentWillUnmount() {
        // 如果存在this.timer，则使用clearTimeout清空。
        // 如果你使用多个timer，那么用多个变量，或者用个数组来保存引用，然后逐个clear
        this.timer && clearTimeout(this.timer);
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
        backgroundColor:'white'
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
    
        fontFamily:'Courier',
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