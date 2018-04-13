'use strict'

const requestconfig = {
    api:{
        bjbaseurl:'http://o.go2yd.com/open-api/caijing/channel',
    },

    map:{
        method: 'POST',
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
        },
        timeout:8000,
    }
}

module.exports = requestconfig

/**
 汽车头条
 http://o.go2yd.com/open-api/caijing/channel?
 appid=x01Gjdp0kvyAVA6SZn7DGAt9&
 nonce=carsfdyuiy54&
 timestamp=1523582054&
 secretkey=0b0fc9611c27a6cf657d249819dbad1078539e91&
 channel_id=%E6%B1%BD%E8%BD%A6&
 offset=0&count=10

 http://www.cheshouye.com/api/weizhang/
 https://bj.122.gov.cn/views/inquiry.html

 {
 "status": "success",
 "code": 0,
 "channel": "汽车",
 "result": [{
 "docid": "0Imi82nD",
 "url": "https:\/\/www.yidianzixun.com\/article\/0Imi82nD?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/0Imi82nD?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-12 14:35:58",
 "title": "雪佛兰新科迈罗发布，降低门槛抢思域饭碗，将成为街车了？",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=0Imi82oEZk&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0Imi82WpWc&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0Imi82wJqm&type=_180x120&source=caijing"],
 "source": "燕赵女司机",
 "ctype": "news",
 "summary": "提起雪佛兰科迈罗，可能有人并不知道是哪款车。但是一说出它的另外一个名字——大黄蜂，可以说无人不知无人不晓。电影《变形金刚》的上映，让这款美式肌肉跑车火遍了全球。",
 "media_pic": "http:\/\/si1.go2yd.com\/get-image\/0G8bqiN9R3o",
 "media_name": "燕赵女司机",
 "category": ["汽车"]
 }, {
 "docid": "0Imrach8",
 "url": "https:\/\/www.yidianzixun.com\/article\/0Imrach8?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/0Imrach8?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-12 18:12:22",
 "title": "世界上最昂贵的车牌1.28亿，那国内最贵的车牌多少钱？",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=0Imrac6uxy&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0ImracSzuE&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0Imrac8rtn&type=_180x120&source=caijing"],
 "source": "汽车有文化",
 "ctype": "news",
 "summary": "在很多人眼里，车牌号只是标识车辆身份的号牌，但是对于土豪们来说，车牌号也是身份的象征。那些钱好像在他们眼里根本不算什么，参加拍卖，买上亿的车牌都不是问题。",
 "media_pic": "http:\/\/s.go2yd.com\/b\/ig0221oy.jpg",
 "media_name": "汽车有文化",
 "category": ["汽车"]
 }, {
 "docid": "0IlvfWb2",
 "url": "https:\/\/www.yidianzixun.com\/article\/0IlvfWb2?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/0IlvfWb2?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-11 10:01:40",
 "title": "一夜疯涨几十万！贸易战开打后，美国车能有多惨？奔驰宝马竟也遭殃！",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=0IlvfWs3jP&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0IlvfW8ID9&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0IlvfWGx9b&type=_180x120&source=caijing"],
 "source": "凤凰新闻",
 "ctype": "news",
 "summary": "对原产于美国的汽车、大豆、化工品等14类106项商品加征25%的关税，并且实施日期将视美国政府对我国商品加征关税的实际情况另行公布。",
 "mtype": 1,
 "category": ["汽车"]
 }, {
 "docid": "V_01YhP6lU",
 "url": "https:\/\/www.yidianzixun.com\/article\/V_01YhP6lU?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/V_01YhP6lU?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-12 10:22:23",
 "title": "汽车店老板透漏，手动挡车型的三大禁忌！千万小心一定别犯",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=http://si1.go2yd.com/get-image/0MHcVdSVsDQ&type=_180x120&source=caijing"],
 "source": "有罚单请签收",
 "ctype": "video",
 "summary": "",
 "media_pic": "http:\/\/si1.go2yd.com\/get-image\/0814CQvSYbI",
 "media_name": "有罚单请签收",
 "duration": 129,
 "category": ["汽车"]
 }, {
 "docid": "0ImMg4B4",
 "url": "https:\/\/www.yidianzixun.com\/article\/0ImMg4B4?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/0ImMg4B4?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-12 00:04:00",
 "title": "春季严查北斗导航开始了！山东、河北、安徽等地严查行车记录仪！",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=0ImMg4lh9L&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0ImMg40C8x&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0ImMg4Xs0B&type=_180x120&source=caijing"],
 "source": "自主汽车",
 "ctype": "news",
 "summary": "俗话说，\"春困秋乏夏打盹\"，春季成为了疲劳驾驶的高峰期，为了防止长途司机疲劳驾驶而引发车祸，最近运管严查北斗\/GPS行车记录仪的地方明显增多。",
 "category": ["汽车"]
 }, {
 "docid": "0ImMg2Pc",
 "url": "https:\/\/www.yidianzixun.com\/article\/0ImMg2Pc?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/0ImMg2Pc?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-12 00:04:00",
 "title": "2018年5月1日起，超过这个岁数就不能开车了，你了解多少？",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=0ImMg2Cjaa&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0ImMg2umU4&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0ImMg2ZZsb&type=_180x120&source=caijing"],
 "source": "自主汽车",
 "ctype": "news",
 "summary": "走过鸡年，就该是狗年了，2017年你的驾照到手了吗？如果有考驾照的想法，准备考试的小伙伴们你们知道驾驶正考试改革了吗？自从去年开始，驾考就进行的一次改革，已经进行了许多改革。今年，对驾驶证考试的年龄又做出了调整：",
 "category": ["汽车"]
 }, {
 "docid": "V_01YmuThg",
 "url": "https:\/\/www.yidianzixun.com\/article\/V_01YmuThg?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/V_01YmuThg?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-13 08:45:52",
 "title": "保时捷718有哪些坑，迫使你多花10w+去买？",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=V_01YmuTuv81&type=_180x120&source=caijing"],
 "source": "AL频道",
 "ctype": "video",
 "summary": "很多人都知道，买保时捷就像吃麻辣烫一样，很多配置都要加钱，否则你的车就会很“素”，看起来完全不值这个价。那么，究竟有哪些东西要钱，又需要多少钱，让我们见识一下吧。",
 "media_pic": "http:\/\/si1.go2yd.com:8082\/get-image\/02c1v2lj4uO",
 "media_name": "AL频道",
 "duration": 414,
 "category": ["汽车"]
 }, {
 "docid": "0IljnqlS",
 "url": "https:\/\/www.yidianzixun.com\/article\/0IljnqlS?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/0IljnqlS?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-10 21:53:53",
 "title": "【992 | 围观】一只苍蝇76万？！奔驰尾灯里有只苍蝇，车主起诉双倍赔钱！",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=0IljnqfJaI&type=_180x120&source=caijing"],
 "source": "河北交通广播",
 "ctype": "news",
 "summary": "发现自己的奔驰车尾灯里有苍蝇，王先生大为恼火，认为这辆车存在质量瑕疵，于是，他把车辆生产商奔驰公司诉至法院，请求法院确认车辆有质量瑕疵，奔驰公司收回车辆，并双倍返还购车款！今天（4月10号）上午，这样一起案件在北京大兴法院开庭审理。",
 "media_pic": "http:\/\/si1.go2yd.com:8082\/get-image\/02lhSdL4Kky",
 "media_name": "河北交通广播",
 "category": ["汽车"]
 }, {
 "docid": "0IkdaThD",
 "url": "https:\/\/www.yidianzixun.com\/article\/0IkdaThD?s=caijing&appid=s3rd_caijing",
 "share_url": "https:\/\/www.yidianzixun.com\/article\/0IkdaThD?s=caijing&appid=s3rd_caijing&yd_share=1",
 "date": "2018-04-09 09:12:03",
 "title": "开到报废都不一定懂，自动挡车的“五不要”不信你看",
 "images": ["http:\/\/i1.go2yd.com\/corpimage.php?url=0IkdaTUeVc&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0IkdaTvAyr&type=_180x120&source=caijing", "http:\/\/i1.go2yd.com\/corpimage.php?url=0IkdaT6YP0&type=_180x120&source=caijing"],
 "source": "阿贵看车",
 "ctype": "news",
 "summary": "众所周知，相对于手动挡汽车自动挡汽车在使用方面具备了很多优势，特别是不用频繁换挡这一方面，就胜出手动挡车很多。但是，并不意味着什么都不用管，想怎么开就怎么开。当驾驶自动挡汽车时，同样需要认真操作。",
 "media_pic": "http:\/\/si1.go2yd.com\/get-image\/0KWqQZplntI",
 "media_name": "阿贵看车",
 "category": ["汽车"]
 }]
 }
 */