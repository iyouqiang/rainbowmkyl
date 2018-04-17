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

import navigationOptionInfo from './bjNavigationOptionsInfo';
import Ionicons from "react-native-vector-icons/Ionicons";

var Dimensions = require('Dimensions');
var {width, height} = Dimensions.get('window');

export default class bjwebviewpage extends Component {

    constructor(props){

        super(props);

        this.state = {

        }
    }

    static navigationOptions = props => navigationOptionInfo.commomHeader(props);

    render() {

        let method = this.props.navigation.state.params.method !=null?this.props.navigation.state.params.method:'GET';

        return (
            <View style={styles.container}>
                <WebView ref='webView'
                    style={styles.webViewStyle}
                         source={{uri: this.props.navigation.state.params.url,method: method} }
                         startInLoadingState={true}
                         domStorageEnabled={true}
                         javaScriptEnabled={true}
                         //injectJavaScript={this._removeBannerjs()}
                         injectedJavaScript={'document.getElementsByClassName(\'banner\')[0].style.display=\'none\';'}
                >
                </WebView>
            </View>
        );
    }

    /**

     A传
     this.props.navigation.navigate('DetailWebPage',{'title':item.title, 'url':item.url});
     B拿
     this.props.navigation.state.params.title

     navigate('Detail',{
                   // 跳转的时候携带一个参数去下个页面
                   callback: (data)=>{
                         console.log(data); // 打印值为：'回调参数'
                     }
                   });
     const {navigate,goBack,state} = this.props.navigation;
     // 在第二个页面,在goBack之前,将上个页面的方法取到,并回传参数,这样回传的参数会重走render方法
     state.params.callback('回调参数');
     goBack();
     */
}

// ExampleWebDetailPage.navigationOptions = props => navigationOptionInfo.commomHeader(props);

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
