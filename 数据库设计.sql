-- ============================================================
-- 海外短视频短剧发行平台 - 数据库表结构设计
-- 基于 ThinkPHP6 + MySQL 8.0
-- ============================================================

-- 用户相关表
CREATE TABLE `user` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) DEFAULT NULL COMMENT '手机号',
  `password` varchar(255) NOT NULL COMMENT '密码 (加密)',
  `nickname` varchar(50) DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '头像',
  `gender` tinyint(1) DEFAULT 0 COMMENT '性别 0 未知 1 男 2 女',
  `birthday` date DEFAULT NULL COMMENT '生日',
  `country` varchar(50) DEFAULT NULL COMMENT '国家',
  `language` varchar(20) DEFAULT 'zh' COMMENT '语言',
  `currency` varchar(10) DEFAULT 'USD' COMMENT '默认币种',
  `member_level` tinyint(2) DEFAULT 0 COMMENT '会员等级 0 普通用户',
  `member_expire_time` int(11) DEFAULT 0 COMMENT '会员过期时间',
  `balance` decimal(10,2) DEFAULT 0.00 COMMENT '余额',
  `total_recharge` decimal(10,2) DEFAULT 0.00 COMMENT '累计充值',
  `total_consumption` decimal(10,2) DEFAULT 0.00 COMMENT '累计消费',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态 0 禁用 1 正常',
  `login_time` int(11) DEFAULT 0 COMMENT '最后登录时间',
  `login_ip` varchar(50) DEFAULT NULL COMMENT '最后登录 IP',
  `create_time` int(11) DEFAULT 0 COMMENT '注册时间',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `status` (`status`),
  KEY `member_level` (`member_level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 用户第三方登录
CREATE TABLE `user_third` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户 ID',
  `platform` varchar(20) NOT NULL COMMENT '平台 google facebook wechat alipay',
  `openid` varchar(100) NOT NULL COMMENT '第三方 openid',
  `unionid` varchar(100) DEFAULT NULL COMMENT '第三方 unionid',
  `access_token` varchar(255) DEFAULT NULL COMMENT '访问令牌',
  `refresh_token` varchar(255) DEFAULT NULL COMMENT '刷新令牌',
  `expires_in` int(11) DEFAULT 0 COMMENT '令牌过期时间',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `platform_openid` (`platform`,`openid`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户第三方登录表';

-- 内容方表
CREATE TABLE `content_provider` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '关联用户 ID',
  `company_name` varchar(200) DEFAULT NULL COMMENT '公司名称',
  `company_type` varchar(50) DEFAULT NULL COMMENT '公司类型',
  `license_no` varchar(100) DEFAULT NULL COMMENT '营业执照号',
  `license_image` varchar(255) DEFAULT NULL COMMENT '营业执照图片',
  `contact_name` varchar(50) DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) DEFAULT NULL COMMENT '联系电话',
  `contact_email` varchar(100) DEFAULT NULL COMMENT '联系邮箱',
  `bank_name` varchar(100) DEFAULT NULL COMMENT '开户行',
  `bank_account` varchar(50) DEFAULT NULL COMMENT '银行账号',
  `bank_country` varchar(50) DEFAULT NULL COMMENT '开户行国家',
  `alipay_account` varchar(100) DEFAULT NULL COMMENT '支付宝账号',
  `wechat_account` varchar(100) DEFAULT NULL COMMENT '微信账号',
  `profit_rate` decimal(5,2) DEFAULT 0.00 COMMENT '分润比例%',
  `status` tinyint(1) DEFAULT 0 COMMENT '状态 0 待审核 1 通过 2 驳回',
  `reject_reason` text COMMENT '驳回原因',
  `create_time` int(11) DEFAULT 0 COMMENT '申请时间',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='内容方表';

-- 短剧表
CREATE TABLE `drama` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_id` bigint(20) UNSIGNED NOT NULL COMMENT '内容方 ID',
  `title` varchar(200) NOT NULL COMMENT '剧名',
  `original_title` varchar(200) DEFAULT NULL COMMENT '原名',
  `cover_image` varchar(255) DEFAULT NULL COMMENT '封面图',
  `banner_image` varchar(255) DEFAULT NULL COMMENT '横幅图',
  `description` text COMMENT '剧情简介',
  `category_id` int(11) DEFAULT 0 COMMENT '分类 ID',
  `tags` varchar(255) DEFAULT NULL COMMENT '标签',
  `total_episodes` int(11) DEFAULT 0 COMMENT '总集数',
  `episode_duration` int(11) DEFAULT 0 COMMENT '单集时长 (分钟)',
  `language` varchar(20) DEFAULT 'zh' COMMENT '原声语言',
  `subtitle_languages` varchar(100) DEFAULT NULL COMMENT '字幕语言',
  `release_date` date DEFAULT NULL COMMENT '上线日期',
  `status` tinyint(1) DEFAULT 0 COMMENT '状态 0 待审核 1 已上线 2 已下线 3 驳回',
  `is_recommend` tinyint(1) DEFAULT 0 COMMENT '是否推荐',
  `is_vip` tinyint(1) DEFAULT 0 COMMENT '是否会员专享',
  `view_count` bigint(20) DEFAULT 0 COMMENT '播放量',
  `favorite_count` int(11) DEFAULT 0 COMMENT '收藏量',
  `like_count` int(11) DEFAULT 0 COMMENT '点赞量',
  `score` decimal(3,1) DEFAULT 0.0 COMMENT '评分',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `provider_id` (`provider_id`),
  KEY `category_id` (`category_id`),
  KEY `status` (`status`),
  KEY `is_recommend` (`is_recommend`),
  KEY `view_count` (`view_count`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='短剧表';

-- 短剧分语言信息表
CREATE TABLE `drama_language` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `drama_id` bigint(20) UNSIGNED NOT NULL COMMENT '短剧 ID',
  `language` varchar(20) NOT NULL COMMENT '语言代码',
  `title` varchar(200) DEFAULT NULL COMMENT '翻译后剧名',
  `description` text COMMENT '翻译后简介',
  `subtitle_url` varchar(255) DEFAULT NULL COMMENT '字幕文件 URL',
  `dubbing_url` varchar(255) DEFAULT NULL COMMENT '配音文件 URL',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `drama_language` (`drama_id`,`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='短剧多语言表';

-- 剧集表
CREATE TABLE `episode` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `drama_id` bigint(20) UNSIGNED NOT NULL COMMENT '短剧 ID',
  `episode_number` int(11) NOT NULL COMMENT '集数',
  `title` varchar(200) DEFAULT NULL COMMENT '集名',
  `cover_image` varchar(255) DEFAULT NULL COMMENT '封面图',
  `video_url` varchar(500) NOT NULL COMMENT '视频 URL(OSS/CDN)',
  `video_duration` int(11) DEFAULT 0 COMMENT '视频时长 (秒)',
  `video_size` bigint(20) DEFAULT 0 COMMENT '视频大小 (字节)',
  `definition` varchar(20) DEFAULT 'HD' COMMENT '清晰度 SD/HD/FHD',
  `is_free` tinyint(1) DEFAULT 0 COMMENT '是否免费',
  `is_try` tinyint(1) DEFAULT 1 COMMENT '是否可试看',
  `try_duration` int(11) DEFAULT 180 COMMENT '试看时长 (秒)',
  `price` decimal(10,2) DEFAULT 0.00 COMMENT '单集价格 (基准币种)',
  `view_count` bigint(20) DEFAULT 0 COMMENT '播放量',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态 0 隐藏 1 上架',
  `sort` int(11) DEFAULT 0 COMMENT '排序',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `drama_id` (`drama_id`),
  KEY `episode_number` (`episode_number`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='剧集表';

-- 分类表
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '分类名',
  `parent_id` int(11) DEFAULT 0 COMMENT '父分类 ID',
  `icon` varchar(255) DEFAULT NULL COMMENT '图标',
  `sort` int(11) DEFAULT 0 COMMENT '排序',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分类表';

-- 订单表
CREATE TABLE `order` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) NOT NULL COMMENT '订单号',
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户 ID',
  `order_type` tinyint(2) NOT NULL COMMENT '订单类型 1 单集解锁 2 全集解锁 3 会员订阅 4 充值礼包',
  `product_id` bigint(20) DEFAULT 0 COMMENT '商品 ID(剧集/会员/礼包)',
  `product_name` varchar(200) DEFAULT NULL COMMENT '商品名称',
  `original_price` decimal(10,2) DEFAULT 0.00 COMMENT '原价',
  `pay_price` decimal(10,2) DEFAULT 0.00 COMMENT '实付金额',
  `currency` varchar(10) DEFAULT 'USD' COMMENT '支付币种',
  `exchange_rate` decimal(10,4) DEFAULT 1.0000 COMMENT '汇率',
  `pay_channel` varchar(20) DEFAULT NULL COMMENT '支付渠道',
  `pay_status` tinyint(2) DEFAULT 0 COMMENT '支付状态 0 待支付 1 已支付 2 支付失败 3 已退款',
  `pay_time` int(11) DEFAULT 0 COMMENT '支付时间',
  `expire_time` int(11) DEFAULT 0 COMMENT '订单过期时间',
  `refund_time` int(11) DEFAULT 0 COMMENT '退款时间',
  `refund_reason` varchar(255) DEFAULT NULL COMMENT '退款原因',
  `coupon_id` bigint(20) DEFAULT 0 COMMENT '优惠券 ID',
  `coupon_amount` decimal(10,2) DEFAULT 0.00 COMMENT '优惠券抵扣',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`order_no`),
  KEY `user_id` (`user_id`),
  KEY `pay_status` (`pay_status`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='订单表';

-- 支付流水表
CREATE TABLE `payment_record` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_no` varchar(50) NOT NULL COMMENT '订单号',
  `transaction_id` varchar(100) DEFAULT NULL COMMENT '第三方交易号',
  `pay_channel` varchar(20) NOT NULL COMMENT '支付渠道',
  `pay_amount` decimal(10,2) DEFAULT 0.00 COMMENT '支付金额',
  `currency` varchar(10) DEFAULT 'USD' COMMENT '支付币种',
  `pay_status` tinyint(2) DEFAULT 0 COMMENT '支付状态 0 待支付 1 成功 2 失败',
  `pay_time` int(11) DEFAULT 0 COMMENT '支付时间',
  `callback_data` text COMMENT '回调数据',
  `refund_status` tinyint(2) DEFAULT 0 COMMENT '退款状态 0 未退款 1 退款中 2 已退款 3 退款失败',
  `refund_time` int(11) DEFAULT 0 COMMENT '退款时间',
  `refund_amount` decimal(10,2) DEFAULT 0.00 COMMENT '退款金额',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_no` (`order_no`),
  KEY `transaction_id` (`transaction_id`),
  KEY `pay_channel` (`pay_channel`),
  KEY `pay_status` (`pay_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付流水表';

-- 会员表
CREATE TABLE `member` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户 ID',
  `level` tinyint(2) NOT NULL COMMENT '会员等级 1 月度 2 季度 3 年度',
  `start_time` int(11) NOT NULL COMMENT '开始时间',
  `end_time` int(11) NOT NULL COMMENT '结束时间',
  `auto_renew` tinyint(1) DEFAULT 0 COMMENT '是否自动续费',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态 0 无效 1 有效 2 过期',
  `create_time` int(11) DEFAULT 0 COMMENT '开通时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `status` (`status`),
  KEY `end_time` (`end_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='会员表';

-- 用户观看记录表
CREATE TABLE `user_watch_record` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户 ID',
  `drama_id` bigint(20) UNSIGNED NOT NULL COMMENT '短剧 ID',
  `episode_id` bigint(20) UNSIGNED DEFAULT 0 COMMENT '剧集 ID',
  `last_episode_id` bigint(20) UNSIGNED DEFAULT 0 COMMENT '最后观看剧集 ID',
  `watch_progress` int(11) DEFAULT 0 COMMENT '观看进度 (秒)',
  `is_finished` tinyint(1) DEFAULT 0 COMMENT '是否看完',
  `view_count` int(11) DEFAULT 0 COMMENT '观看次数',
  `create_time` int(11) DEFAULT 0 COMMENT '首次观看时间',
  `update_time` int(11) DEFAULT 0 COMMENT '最后观看时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_drama` (`user_id`,`drama_id`),
  KEY `user_id` (`user_id`),
  KEY `drama_id` (`drama_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户观看记录表';

-- 用户解锁记录表
CREATE TABLE `user_unlock` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户 ID',
  `drama_id` bigint(20) UNSIGNED NOT NULL COMMENT '短剧 ID',
  `episode_id` bigint(20) UNSIGNED DEFAULT 0 COMMENT '剧集 ID(0 表示全集)',
  `unlock_type` tinyint(2) DEFAULT 1 COMMENT '解锁类型 1 单集 2 全集 3 会员',
  `order_no` varchar(50) DEFAULT NULL COMMENT '关联订单号',
  `expire_time` int(11) DEFAULT 0 COMMENT '过期时间 (0 永久)',
  `create_time` int(11) DEFAULT 0 COMMENT '解锁时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_episode` (`user_id`,`episode_id`),
  KEY `user_id` (`user_id`),
  KEY `drama_id` (`drama_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户解锁记录表';

-- 分润记录表
CREATE TABLE `profit_record` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_id` bigint(20) UNSIGNED NOT NULL COMMENT '内容方 ID',
  `order_no` varchar(50) NOT NULL COMMENT '订单号',
  `drama_id` bigint(20) UNSIGNED DEFAULT 0 COMMENT '短剧 ID',
  `order_amount` decimal(10,2) DEFAULT 0.00 COMMENT '订单金额',
  `profit_rate` decimal(5,2) DEFAULT 0.00 COMMENT '分润比例%',
  `profit_amount` decimal(10,2) DEFAULT 0.00 COMMENT '分润金额',
  `currency` varchar(10) DEFAULT 'USD' COMMENT '币种',
  `status` tinyint(2) DEFAULT 0 COMMENT '状态 0 待结算 1 已结算 2 已提现',
  `settle_time` int(11) DEFAULT 0 COMMENT '结算时间',
  `withdraw_time` int(11) DEFAULT 0 COMMENT '提现时间',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `provider_id` (`provider_id`),
  KEY `order_no` (`order_no`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='分润记录表';

-- 提现记录表
CREATE TABLE `withdraw` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `provider_id` bigint(20) UNSIGNED NOT NULL COMMENT '内容方 ID',
  `withdraw_no` varchar(50) NOT NULL COMMENT '提现单号',
  `amount` decimal(10,2) NOT NULL COMMENT '提现金额',
  `currency` varchar(10) DEFAULT 'USD' COMMENT '币种',
  `withdraw_type` varchar(20) DEFAULT 'bank' COMMENT '提现方式 bank 银行 alipay 微信',
  `bank_info` text COMMENT '银行信息 JSON',
  `fee` decimal(10,2) DEFAULT 0.00 COMMENT '手续费',
  `tax` decimal(10,2) DEFAULT 0.00 COMMENT '税费',
  `actual_amount` decimal(10,2) DEFAULT 0.00 COMMENT '实际到账',
  `status` tinyint(2) DEFAULT 0 COMMENT '状态 0 待审核 1 处理中 2 已完成 3 已驳回',
  `reject_reason` varchar(255) DEFAULT NULL COMMENT '驳回原因',
  `complete_time` int(11) DEFAULT 0 COMMENT '完成时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) DEFAULT 0 COMMENT '申请时间',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `withdraw_no` (`withdraw_no`),
  KEY `provider_id` (`provider_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='提现记录表';

-- 优惠券表
CREATE TABLE `coupon` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '优惠券名称',
  `type` tinyint(2) DEFAULT 1 COMMENT '类型 1 满减 2 折扣 3 新人券',
  `amount` decimal(10,2) DEFAULT 0.00 COMMENT '优惠金额',
  `discount` decimal(5,2) DEFAULT 0.00 COMMENT '折扣 (8.5 折)',
  `min_amount` decimal(10,2) DEFAULT 0.00 COMMENT '最低使用金额',
  `max_amount` decimal(10,2) DEFAULT 0.00 COMMENT '最高抵扣金额',
  `total_count` int(11) DEFAULT 0 COMMENT '发放总量',
  `received_count` int(11) DEFAULT 0 COMMENT '已领取数量',
  `used_count` int(11) DEFAULT 0 COMMENT '已使用数量',
  `start_time` int(11) DEFAULT 0 COMMENT '开始时间',
  `end_time` int(11) DEFAULT 0 COMMENT '结束时间',
  `status` tinyint(1) DEFAULT 1 COMMENT '状态 0 停用 1 启用',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `end_time` (`end_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券表';

-- 用户优惠券表
CREATE TABLE `user_coupon` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户 ID',
  `coupon_id` bigint(20) UNSIGNED NOT NULL COMMENT '优惠券 ID',
  `status` tinyint(2) DEFAULT 0 COMMENT '状态 0 未使用 1 已使用 2 已过期',
  `order_no` varchar(50) DEFAULT NULL COMMENT '使用订单号',
  `receive_time` int(11) DEFAULT 0 COMMENT '领取时间',
  `use_time` int(11) DEFAULT 0 COMMENT '使用时间',
  `expire_time` int(11) DEFAULT 0 COMMENT '过期时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `coupon_id` (`coupon_id`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户优惠券表';

-- 系统配置表
CREATE TABLE `system_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_key` varchar(50) NOT NULL COMMENT '配置键',
  `config_value` text COMMENT '配置值',
  `config_type` varchar(20) DEFAULT 'string' COMMENT '配置类型',
  `config_desc` varchar(255) DEFAULT NULL COMMENT '配置说明',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统配置表';

-- 支付渠道配置表
CREATE TABLE `payment_channel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_code` varchar(20) NOT NULL COMMENT '渠道代码',
  `channel_name` varchar(50) NOT NULL COMMENT '渠道名称',
  `channel_type` varchar(20) DEFAULT 'overseas' COMMENT '类型 overseas 海外 wechat 微信 alipay 支付宝',
  `config` text COMMENT '配置参数 JSON',
  `is_enabled` tinyint(1) DEFAULT 1 COMMENT '是否启用',
  `supported_countries` text COMMENT '支持国家 JSON',
  `supported_currencies` varchar(255) DEFAULT NULL COMMENT '支持币种',
  `fee_rate` decimal(5,4) DEFAULT 0.0000 COMMENT '费率',
  `settle_cycle` varchar(20) DEFAULT 'T+1' COMMENT '结算周期',
  `sort` int(11) DEFAULT 0 COMMENT '排序',
  `create_time` int(11) DEFAULT 0 COMMENT '创建时间',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `channel_code` (`channel_code`),
  KEY `is_enabled` (`is_enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='支付渠道配置表';

-- 操作日志表
CREATE TABLE `admin_log` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) DEFAULT 0 COMMENT '管理员 ID',
  `action` varchar(100) DEFAULT NULL COMMENT '操作',
  `module` varchar(50) DEFAULT NULL COMMENT '模块',
  `controller` varchar(50) DEFAULT NULL COMMENT '控制器',
  `method` varchar(50) DEFAULT NULL COMMENT '方法',
  `params` text COMMENT '参数',
  `ip` varchar(50) DEFAULT NULL COMMENT 'IP',
  `user_agent` varchar(255) DEFAULT NULL COMMENT 'User-Agent',
  `create_time` int(11) DEFAULT 0 COMMENT '操作时间',
  PRIMARY KEY (`id`),
  KEY `admin_id` (`admin_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='操作日志表';

-- 汇率表
CREATE TABLE `exchange_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `currency` varchar(10) NOT NULL COMMENT '币种',
  `rate` decimal(10,4) NOT NULL COMMENT '汇率 (相对于 USD)',
  `update_time` int(11) DEFAULT 0 COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `currency` (`currency`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='汇率表';

-- 初始数据
INSERT INTO `category` (`id`, `name`, `parent_id`, `sort`, `status`) VALUES
(1, '甜宠', 0, 1, 1),
(2, '霸总', 0, 2, 1),
(3, '悬疑', 0, 3, 1),
(4, '逆袭', 0, 4, 1),
(5, '复仇', 0, 5, 1),
(6, '穿越', 0, 6, 1),
(7, '都市', 0, 7, 1),
(8, '古装', 0, 8, 1);

INSERT INTO `system_config` (`config_key`, `config_value`, `config_desc`) VALUES
('site_name', 'DramaHub', '平台名称'),
('site_logo', '', '平台 Logo'),
('default_currency', 'USD', '默认币种'),
('try_duration', '180', '默认试看时长 (秒)'),
('profit_rate', '50.00', '默认分润比例%');

-- 索引优化建议
-- 1. 订单表、支付流水表按时间分区
-- 2. 用户观看记录定期清理
-- 3. 热点数据使用 Redis 缓存
