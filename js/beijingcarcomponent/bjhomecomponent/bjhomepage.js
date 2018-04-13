/**
 * Created by guiyongdong on 2017/5/21.
 */
import React, {Component} from 'react';
import {
    View,
    Text,
    StyleSheet,
    SectionList,
} from 'react-native';

import Spinkit from 'react-native-spinkit';
import requesttool from '../bjhttprequest/requesttool';
import requestconfig from '../bjhttprequest/requestconfig';

const currentTimestamp = new Date().getTime();

export default class bjhomepage extends Component {

    constructor(props) {
        super(props);
        this.state = {

            sections:[],
            refreshing:false,
            showLoading:true,
        }
    }

    render() {
        console.log('render');
        return(
            <View style={styles.container}>
                <Text>HomeTab</Text>
            </View>
        )
    }

        componentDidMount() {

        {this._requestHomeinfo()}
    }

        _requestHomeinfo() {

        requesttool.get(requestconfig.api.bjbaseurl, {
            appid:'x01Gjdp0kvyAVA6SZn7DGAt91',
            nonce:'carsfdyuiy54',
            timestamp:currentTimestamp,
            secretkey:'0b0fc9611c27a6cf657d249819dbad1078539e9',
            channel_id:'汽车',
            offset:'0',
            count:'10',
        }).then((data)=>{

            this.setState({

                sections:data,
                refreshing:false,
                showLoading:false,
            })
        })
            .catch((error)=>{
                console.log('错误信息：'+error);
                this.setState({
                    refreshing: false,
                    showLoading: false,
                })
            })
    }
}

const styles = StyleSheet.create({

    container:{

        flex:1,
        justifyContent:'center',
        alignItems:'center'
    }
});