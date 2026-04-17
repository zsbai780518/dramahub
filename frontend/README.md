# UniApp 前端项目结构说明

## 目录结构

```
frontend/
├── pages/                        # 页面目录
│   ├── home/                     # 首页
│   │   └── index.vue
│   ├── drama/                    # 短剧列表/详情
│   │   ├── list.vue
│   │   └── detail.vue
│   ├── play/                     # 播放页
│   │   └── index.vue
│   ├── pay/                      # 支付页
│   │   ├── index.vue
│   │   └── success.vue
│   └── mine/                     # 个人中心
│       ├── index.vue
│       ├── profile.vue
│       ├── member.vue
│       ├── order.vue
│       ├── wallet.vue
│       └── settings.vue
├── components/                   # 组件目录
│   ├── DramaCard.vue             # 短剧卡片
│   ├── EpisodeItem.vue           # 剧集列表项
│   ├── VideoPlayer.vue           # 视频播放器
│   ├── PayButton.vue             # 支付按钮
│   ├── PayMethod.vue             # 支付方式选择
│   ├── MemberCard.vue            # 会员卡片
│   ├── UserAvatar.vue            # 用户头像
│   └── Loading.vue               # 加载组件
├── static/                       # 静态资源
│   ├── images/                   # 图片
│   │   ├── logo.png
│   │   ├── placeholder.png
│   │   └── icons/
│   └── style/                    # 样式
│       ├── common.scss           # 公共样式
│       ├── variables.scss        # 变量
│       └── mixins.scss           # 混合
├── utils/                        # 工具类
│   ├── request.js                # 请求封装
│   ├── storage.js                # 存储封装
│   ├── auth.js                   # 认证工具
│   ├── pay.js                    # 支付工具
│   ├── i18n.js                   # 国际化
│   └── helpers.js                # 辅助函数
├── api/                          # API 接口
│   ├── user.js                   # 用户接口
│   ├── drama.js                  # 短剧接口
│   ├── episode.js                # 剧集接口
│   ├── order.js                  # 订单接口
│   ├── payment.js                # 支付接口
│   ├── member.js                 # 会员接口
│   └── category.js               # 分类接口
├── store/                        # Vuex 状态管理
│   ├── index.js
│   ├── modules/
│   │   ├── user.js
│   │   ├── drama.js
│   │   └── pay.js
├── locale/                       # 多语言
│   ├── zh-CN.js                  # 中文
│   ├── en-US.js                  # 英文
│   ├── th-TH.js                  # 泰语
│   ├── id-ID.js                  # 印尼语
│   ├── es-ES.js                  # 西班牙语
│   └── ar-SA.js                  # 阿拉伯语
├── manifest.json                 # 应用配置
├── pages.json                    # 页面配置
├── App.vue                       # 应用入口
├── main.js                       # 入口文件
├── uni.scss                      # UniApp 样式变量
└── package.json                  # 依赖配置
```

## 核心配置

### pages.json - 页面配置

```json
{
  "pages": [
    {
      "path": "pages/home/index",
      "style": {
        "navigationBarTitleText": "首页",
        "enablePullDownRefresh": true
      }
    },
    {
      "path": "pages/drama/list",
      "style": {
        "navigationBarTitleText": "短剧列表"
      }
    },
    {
      "path": "pages/drama/detail",
      "style": {
        "navigationBarTitleText": "短剧详情"
      }
    },
    {
      "path": "pages/play/index",
      "style": {
        "navigationBarTitleText": "播放",
        "navigationStyle": "custom"
      }
    },
    {
      "path": "pages/pay/index",
      "style": {
        "navigationBarTitleText": "支付"
      }
    },
    {
      "path": "pages/mine/index",
      "style": {
        "navigationBarTitleText": "我的"
      }
    }
  ],
  "tabBar": {
    "color": "#999999",
    "selectedColor": "#FF6B35",
    "list": [
      {
        "pagePath": "pages/home/index",
        "text": "首页",
        "iconPath": "static/icons/home.png",
        "selectedIconPath": "static/icons/home-active.png"
      },
      {
        "pagePath": "pages/drama/list",
        "text": "短剧",
        "iconPath": "static/icons/drama.png",
        "selectedIconPath": "static/icons/drama-active.png"
      },
      {
        "pagePath": "pages/mine/index",
        "text": "我的",
        "iconPath": "static/icons/mine.png",
        "selectedIconPath": "static/icons/mine-active.png"
      }
    ]
  }
}
```

### manifest.json - 应用配置

```json
{
  "name": "DramaHub",
  "appid": "__UNI__DRAMA_HUB",
  "description": "海外短视频短剧发行平台",
  "versionName": "1.0.0",
  "versionCode": "100",
  "transformPx": false,
  "app-plus": {
    "usingComponents": true,
    "modules": {},
    "distribute": {
      "android": {
        "permissions": [
          "<uses-permission android:name=\"android.permission.INTERNET\"/>",
          "<uses-permission android:name=\"android.permission.ACCESS_NETWORK_STATE\"/>"
        ]
      },
      "ios": {},
      "sdkConfigs": {}
    }
  },
  "quickapp": {},
  "mp-weixin": {
    "appid": "",
    "setting": {
      "urlCheck": false
    },
    "usingComponents": true
  },
  "h5": {
    "title": "DramaHub",
    "router": {
      "mode": "hash",
      "base": "./"
    }
  }
}
```

## 核心 API 接口封装

### utils/request.js - 请求封装

```javascript
import { getToken, removeToken } from './auth'

const BASE_URL = 'https://api.dramahub.com'

export function request(options) {
  return new Promise((resolve, reject) => {
    const token = getToken()
    
    uni.request({
      url: BASE_URL + options.url,
      method: options.method || 'GET',
      data: options.data || {},
      header: {
        'Content-Type': 'application/json',
        'Authorization': token ? `Bearer ${token}` : '',
        'Language': uni.getStorageSync('language') || 'zh'
      },
      timeout: 10000,
      success: (res) => {
        if (res.statusCode === 200) {
          if (res.data.code === 0) {
            resolve(res.data.data)
          } else if (res.data.code === 401) {
            removeToken()
            uni.navigateTo({ url: '/pages/login/index' })
            reject(res.data)
          } else {
            uni.showToast({ title: res.data.msg, icon: 'none' })
            reject(res.data)
          }
        } else {
          uni.showToast({ title: '网络错误', icon: 'none' })
          reject(res)
        }
      },
      fail: (err) => {
        uni.showToast({ title: '请求失败', icon: 'none' })
        reject(err)
      }
    })
  })
}

export const get = (url, data) => request({ url, method: 'GET', data })
export const post = (url, data) => request({ url, method: 'POST', data })
```

### api/payment.js - 支付接口

```javascript
import { post } from '@/utils/request'

// 创建订单
export function createOrder(data) {
  return post('/api/order/create', data)
}

// 发起支付
export function pay(data) {
  return post('/api/payment/pay', data)
}

// 唤起微信支付
export function wechatPay(payParams) {
  return new Promise((resolve, reject) => {
    uni.requestPayment({
      provider: 'wxpay',
      orderInfo: payParams,
      success: resolve,
      fail: reject
    })
  })
}

// 唤起支付宝支付
export function alipayPay(payParams) {
  return new Promise((resolve, reject) => {
    uni.requestPayment({
      provider: 'alipay',
      orderInfo: payParams,
      success: resolve,
      fail: reject
    })
  })
}

// PayPal 支付
export function paypalPay(payParams) {
  // H5 跳转或 SDK 调用
  return post('/api/payment/paypal', payParams)
}
```

## 多语言配置 (locale/)

### zh-CN.js
```javascript
export default {
  common: {
    confirm: '确认',
    cancel: '取消',
    loading: '加载中...',
    noData: '暂无数据'
  },
  home: {
    recommend: '热门推荐',
    newRelease: '新剧上线',
    category: '分类'
  },
  drama: {
    tryWatch: '试看',
    unlock: '解锁',
    fullUnlock: '全集解锁',
    episodes: '集'
  },
  pay: {
    selectMethod: '选择支付方式',
    paySuccess: '支付成功',
    payFailed: '支付失败'
  }
}
```

## 环境要求

- Node.js >= 14
- HBuilderX (推荐) 或 VS Code
- UniApp CLI

## 运行步骤

1. 安装依赖：`npm install`
2. 配置 API 地址：`utils/request.js`
3. 运行到浏览器：`npm run dev:h5`
4. 运行到微信开发者工具：`npm run dev:mp-weixin`
5. 打包 APP：`npm run build:app-plus`

## 多端编译

```bash
# H5
npm run dev:h5

# 微信小程序
npm run dev:mp-weixin

# Android APP
npm run build:app-android

# iOS APP
npm run build:app-ios
```
