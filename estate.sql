-- Public initialization: schema only, no original users or business records.

-- Create and select your database before import.

SET NAMES utf8mb4;

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE IF NOT EXISTS `es_activity`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '活动内容',
  `place` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '活动地点',
  `begin_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '活动开始时间',
  `end_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '活动截止时间',
  `sponsor_unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '举办单位',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '状态 0 无效 1 有效',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '小区活动信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码',
  `salt` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码盐',
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '头像',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '电子邮箱',
  `loginfailure` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '失败次数',
  `logintime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录时间',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `token` varchar(59) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'Session标识',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员表' ROW_FORMAT = COMPACT;

CREATE TABLE IF NOT EXISTS `es_admin_log`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '管理员名字',
  `url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作页面',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '日志标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `useragent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'User-Agent',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 204 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员日志表' ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `es_attachment`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '物理路径',
  `imagewidth` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '宽度',
  `imageheight` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '宽度',
  `imagetype` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片类型',
  `imageframes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '图片帧数',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'mime类型',
  `extparam` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '透传数据',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建日期',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `uploadtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上传时间',
  `storage` enum('local','upyun','qiniu') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `sha1` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '附件表' ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `es_auth_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父组别',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '组名',
  `rules` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '规则ID',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分组表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_auth_group_access`  (
  `uid` int(10) UNSIGNED NOT NULL COMMENT '会员ID',
  `group_id` int(10) UNSIGNED NOT NULL COMMENT '级别ID',
  UNIQUE INDEX `uid_group_id`(`uid`, `group_id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限分组表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_auth_rule`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` enum('menu','file') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'file' COMMENT 'menu为菜单,file为权限节点',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '规则名称',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图标',
  `condition` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '条件',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '备注',
  `ismenu` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否为菜单',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `weigh`(`weigh`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 693 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '节点表' ROW_FORMAT = COMPACT;

CREATE TABLE IF NOT EXISTS `es_building`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '栋数编号，建议BD开头',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '栋数名称',
  `house` int(10) NOT NULL COMMENT '总户数',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  `lift` int(10) NULL DEFAULT NULL COMMENT '电梯数',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '栋数信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_category`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '父ID',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '栏目类型',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `nickname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `flag` set('hot','index','recommend') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片',
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `diyname` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '自定义名称',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `weigh`(`weigh`, `id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '分类表' ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `es_community`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '小区编号，建议CM开头',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '小区名称',
  `introduction` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '简介',
  `thumb` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '坐落地址',
  `area` decimal(15, 2) NOT NULL COMMENT '占地面积，单位：平米',
  `developer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '开发商名称',
  `estate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '物业公司名称',
  `greening_rate` decimal(10, 2) NOT NULL COMMENT '绿化率，单位：百分比',
  `total_building` int(11) NOT NULL COMMENT '总栋数',
  `total_owner` int(11) NOT NULL COMMENT '总户数',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '小区信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_community_admin`  (
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '小区编号，建议CM开头',
  `admin_id` int(11) UNSIGNED NOT NULL COMMENT '管理员id',
  UNIQUE INDEX `cm_admin_id`(`community_code`, `admin_id`) USING BTREE,
  INDEX `community_code`(`community_code`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '小区管理员关系表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_complain`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `member_id` int(11) NOT NULL COMMENT '投诉成员id',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '投诉名称',
  `reason` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '投诉事由',
  `is_anonymity` tinyint(1) UNSIGNED NULL DEFAULT 1 COMMENT '是否匿名 0 不匿名 1 匿名',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业主投诉信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量名',
  `group` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量标题',
  `tip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '变量描述',
  `type` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '类型:string,text,int,bool,array,datetime,date,file',
  `value` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变量值',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '变量字典数据',
  `rule` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '验证规则',
  `extend` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '扩展属性',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_crontab`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '事件类型',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '事件标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事件内容',
  `schedule` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'Crontab格式',
  `sleep` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '延迟秒数执行',
  `maximums` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大执行次数 0为不限',
  `executes` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '已经执行的次数',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `begintime` int(10) NOT NULL DEFAULT 0 COMMENT '开始时间',
  `endtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '结束时间',
  `executetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最后执行时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `status` enum('completed','expired','hidden','normal') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务表' ROW_FORMAT = DYNAMIC;

CREATE TABLE IF NOT EXISTS `es_device`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备编号，建议DV开头',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备名称',
  `brand` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '品牌',
  `price` decimal(10, 2) NOT NULL COMMENT '购买价格（单价）',
  `quantity` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '购买数量',
  `buy_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '购买时间',
  `durable_years` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '预计使用年限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产设备信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_device_maintain`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `device_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '设备编号，建议DV开头',
  `unit` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '维修单位名称',
  `contacts` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '维修人名称',
  `contacts_tel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '维修人联系方式',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `last_maintain_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '最后一次维护时间',
  `next_maintain_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '下次维护时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资产设备维修记录表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_duty`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '值班人名称，多个值班人用英文逗号隔开',
  `start_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '值班开始时间',
  `end_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '值班结束时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '物业员工值班信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_expenses`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `house_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '缴费人，即房产编号，建议HS开头',
  `project_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '缴费项目编号，建议EP开头',
  `amount_total` decimal(10, 2) NOT NULL COMMENT '应收金额',
  `amount_paid` decimal(10, 2) NOT NULL COMMENT '实收金额',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '缴费时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '费用信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_expenses_project`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目编号，建议EP开头',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '项目名称',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '收费项目信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_house`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `building_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '栋数编号，建议BD开头',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房产编号，建议HS开头',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房产名称',
  `owner_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '户主姓名',
  `owner_tel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '户主联系方式',
  `rooms` int(10) NOT NULL COMMENT '房间数',
  `unit` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '单元信息',
  `floor` int(10) NOT NULL COMMENT '楼层信息',
  `desc` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '房产描述',
  `enter_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '入住时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '房产信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_mailbox`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '信件标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '信件内容',
  `member_id` int(11) NOT NULL COMMENT '成员id',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '状态 0 未读 1 已读',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业主信箱信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_member`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `house_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '房产编号，建议HS开头',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '成员姓名',
  `identity_id` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `tel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系方式',
  `occupation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职业',
  `birth` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '出生日期',
  `gender` tinyint(1) NOT NULL COMMENT '性别 0 女 1 男',
  `owner_type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '成员类型 1 户主 2 家庭成员，3 租户',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `photo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '成员照片，拍照上传即可',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '小区成员信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_parking_space`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '车位编号，建议PK开头',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '车位名称',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '状态 0 闲置中 1 使用中',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '停车位基本信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_parking_space_use`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `pk_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '车位编号，建议PK开头',
  `license_plate` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '车辆牌照',
  `owner` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '车辆所有人',
  `tel` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '联系电话',
  `begin_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '截止时间',
  `type` tinyint(1) UNSIGNED NOT NULL COMMENT '使用性质 1 租 2 买',
  `cost` decimal(10, 2) NOT NULL COMMENT '费用',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '停车位使用记录表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_pet`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `member_id` int(11) NOT NULL COMMENT '家庭成员id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宠物名称',
  `color` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '宠物颜色',
  `photo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '宠物照片，拍照上传即可',
  `adopt_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '收养时间',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '宠物信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_repair`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `community_code` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '所属小区编号，建议CM开头',
  `member_id` int(11) NOT NULL COMMENT '报修成员id',
  `device_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '报修设备名称',
  `desc` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '报修描述',
  `status` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '状态 0 待受理 1 已受理 2 已维修',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '业主报修信息表' ROW_FORMAT = Dynamic;

CREATE TABLE IF NOT EXISTS `es_test`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `admin_id` int(10) NOT NULL COMMENT '管理员ID',
  `category_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类ID(单选)',
  `category_ids` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类ID(多选)',
  `week` enum('monday','tuesday','wednesday') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '星期(单选):monday=星期一,tuesday=星期二,wednesday=星期三',
  `flag` set('hot','index','recommend') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标志(多选):hot=热门,index=首页,recommend=推荐',
  `genderdata` enum('male','female') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'male' COMMENT '性别(单选):male=男,female=女',
  `hobbydata` set('music','reading','swimming') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '爱好(多选):music=音乐,reading=读书,swimming=游泳',
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '内容',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片',
  `images` varchar(1500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '图片组',
  `attachfile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '附件',
  `keywords` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '关键字',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  `city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '省市',
  `price` float(10, 2) UNSIGNED NOT NULL DEFAULT 0.00 COMMENT '价格',
  `views` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击',
  `startdate` date NULL DEFAULT NULL COMMENT '开始日期',
  `activitytime` datetime NULL DEFAULT NULL COMMENT '活动时间(datetime)',
  `year` year NULL DEFAULT NULL COMMENT '年',
  `times` time NULL DEFAULT NULL COMMENT '时间',
  `refreshtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '刷新时间(int)',
  `createtime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '更新时间',
  `weigh` int(10) NOT NULL DEFAULT 0 COMMENT '权重',
  `switch` tinyint(1) NOT NULL DEFAULT 0 COMMENT '开关',
  `status` enum('normal','hidden') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'normal' COMMENT '状态',
  `state` enum('0','1','2') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '1' COMMENT '状态值:0=禁用,1=正常,2=推荐',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '测试表' ROW_FORMAT = COMPACT;

CREATE TABLE IF NOT EXISTS `es_vehicle`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `member_id` int(11) NOT NULL COMMENT '家庭成员id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '车辆名称',
  `license_plate` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '车辆牌照',
  `color` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '车辆颜色',
  `photo` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '车辆照片，拍照上传即可',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '修改时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '车辆信息表' ROW_FORMAT = Dynamic;

INSERT INTO `es_auth_group` VALUES (1, 0, '超级管理员', '*', 1710157369, 1710157369, 'normal');

INSERT INTO `es_auth_group` VALUES (2, 1, '小区管理员', '1,9,10,13,14,15,16,17,40,41,42,43,44,45,46,582,583,585,587,588,589,590,591,592,593,594,595,596,597,598,599,600,601,602,603,604,605,606,607,608,609,610,611,612,613,614,615,616,617,618,619,620,621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,658,659,660,661,662,663,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682,683,684,685,686,687,688,689,690,691,692,5,581', 1710157369, 1710157369, 'normal');

INSERT INTO `es_auth_group` VALUES (3, 2, '小区普通员工', '', 1710157369, 1710157369, 'normal');

INSERT INTO `es_auth_group` VALUES (4, 2, '业主', '658,659,660,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682', 1710157369, 1710157369, 'normal');

INSERT INTO `es_auth_rule` VALUES (1, 'file', 0, 'dashboard', 'Dashboard', 'fa fa-dashboard\r', '', 'Dashboard tips', 1, 1710157369, 1710157369, 201, 'normal');

INSERT INTO `es_auth_rule` VALUES (2, 'file', 0, 'general', 'General', 'fa fa-cogs', '', '', 1, 1710157369, 1710157369, 137, 'normal');

INSERT INTO `es_auth_rule` VALUES (3, 'file', 0, 'category', 'Category', 'fa fa-list\r', '', 'Category tips', 1, 1710157369, 1710157369, 119, 'hidden');

INSERT INTO `es_auth_rule` VALUES (4, 'file', 0, 'addon', 'Addon', 'fa fa-rocket', '', 'Addon tips', 1, 1710157369, 1710157369, 0, 'hidden');

INSERT INTO `es_auth_rule` VALUES (5, 'file', 0, 'auth', 'Auth', 'fa fa-group', '', '', 1, 1710157369, 1710157369, 99, 'normal');

INSERT INTO `es_auth_rule` VALUES (6, 'file', 2, 'general/config', 'Config', 'fa fa-cog', '', 'Config tips', 1, 1710157369, 1710157369, 60, 'Hidden');

INSERT INTO `es_auth_rule` VALUES (7, 'file', 2, 'general/attachment', 'Attachment', 'fa fa-file-image-o', '', 'Attachment tips', 1, 1710157369, 1710157369, 53, 'normal');

INSERT INTO `es_auth_rule` VALUES (8, 'file', 2, 'general/profile', 'Profile', 'fa fa-user\r', '', '', 1, 1710157369, 1710157369, 34, 'normal');

INSERT INTO `es_auth_rule` VALUES (9, 'file', 5, 'auth/admin', 'Operator', 'fa fa-user', '', 'Admin tips', 1, 1710157369, 1710157369, 118, 'normal');

INSERT INTO `es_auth_rule` VALUES (10, 'file', 5, 'auth/adminlog', 'Operator log', 'fa fa-list-alt', '', 'Admin log tips', 1, 1710157369, 1710158168, 113, 'hidden');

INSERT INTO `es_auth_rule` VALUES (11, 'file', 5, 'auth/group', 'Group', 'fa fa-group', '', 'Group tips', 1, 1710157369, 1710158160, 109, 'hidden');

INSERT INTO `es_auth_rule` VALUES (12, 'file', 5, 'auth/rule', 'Rule', 'fa fa-bars', '', 'Rule tips', 1, 1710157369, 1710158173, 104, 'hidden');

INSERT INTO `es_auth_rule` VALUES (13, 'file', 1, 'dashboard/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 136, 'normal');

INSERT INTO `es_auth_rule` VALUES (14, 'file', 1, 'dashboard/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 135, 'normal');

INSERT INTO `es_auth_rule` VALUES (15, 'file', 1, 'dashboard/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 133, 'normal');

INSERT INTO `es_auth_rule` VALUES (16, 'file', 1, 'dashboard/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 134, 'normal');

INSERT INTO `es_auth_rule` VALUES (17, 'file', 1, 'dashboard/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 132, 'normal');

INSERT INTO `es_auth_rule` VALUES (18, 'file', 6, 'general/config/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 52, 'Hidden');

INSERT INTO `es_auth_rule` VALUES (19, 'file', 6, 'general/config/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 51, 'normal');

INSERT INTO `es_auth_rule` VALUES (20, 'file', 6, 'general/config/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 50, 'normal');

INSERT INTO `es_auth_rule` VALUES (21, 'file', 6, 'general/config/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 49, 'normal');

INSERT INTO `es_auth_rule` VALUES (22, 'file', 6, 'general/config/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 48, 'normal');

INSERT INTO `es_auth_rule` VALUES (23, 'file', 7, 'general/attachment/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 59, 'normal');

INSERT INTO `es_auth_rule` VALUES (24, 'file', 7, 'general/attachment/select', 'Select attachment', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 58, 'normal');

INSERT INTO `es_auth_rule` VALUES (25, 'file', 7, 'general/attachment/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 57, 'normal');

INSERT INTO `es_auth_rule` VALUES (26, 'file', 7, 'general/attachment/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 56, 'normal');

INSERT INTO `es_auth_rule` VALUES (27, 'file', 7, 'general/attachment/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 55, 'normal');

INSERT INTO `es_auth_rule` VALUES (28, 'file', 7, 'general/attachment/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 54, 'normal');

INSERT INTO `es_auth_rule` VALUES (29, 'file', 8, 'general/profile/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 33, 'normal');

INSERT INTO `es_auth_rule` VALUES (30, 'file', 8, 'general/profile/update', 'Update profile', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 32, 'normal');

INSERT INTO `es_auth_rule` VALUES (31, 'file', 8, 'general/profile/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 31, 'normal');

INSERT INTO `es_auth_rule` VALUES (32, 'file', 8, 'general/profile/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 30, 'normal');

INSERT INTO `es_auth_rule` VALUES (33, 'file', 8, 'general/profile/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 29, 'normal');

INSERT INTO `es_auth_rule` VALUES (34, 'file', 8, 'general/profile/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 28, 'normal');

INSERT INTO `es_auth_rule` VALUES (35, 'file', 3, 'category/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 142, 'hidden');

INSERT INTO `es_auth_rule` VALUES (36, 'file', 3, 'category/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 141, 'hidden');

INSERT INTO `es_auth_rule` VALUES (37, 'file', 3, 'category/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 140, 'hidden');

INSERT INTO `es_auth_rule` VALUES (38, 'file', 3, 'category/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 139, 'hidden');

INSERT INTO `es_auth_rule` VALUES (39, 'file', 3, 'category/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 138, 'hidden');

INSERT INTO `es_auth_rule` VALUES (40, 'file', 9, 'auth/admin/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 117, 'normal');

INSERT INTO `es_auth_rule` VALUES (41, 'file', 9, 'auth/admin/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 116, 'normal');

INSERT INTO `es_auth_rule` VALUES (42, 'file', 9, 'auth/admin/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 115, 'normal');

INSERT INTO `es_auth_rule` VALUES (43, 'file', 9, 'auth/admin/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 114, 'normal');

INSERT INTO `es_auth_rule` VALUES (44, 'file', 10, 'auth/adminlog/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 112, 'normal');

INSERT INTO `es_auth_rule` VALUES (45, 'file', 10, 'auth/adminlog/detail', 'Detail', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 111, 'normal');

INSERT INTO `es_auth_rule` VALUES (46, 'file', 10, 'auth/adminlog/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 110, 'normal');

INSERT INTO `es_auth_rule` VALUES (47, 'file', 11, 'auth/group/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 108, 'normal');

INSERT INTO `es_auth_rule` VALUES (48, 'file', 11, 'auth/group/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 107, 'normal');

INSERT INTO `es_auth_rule` VALUES (49, 'file', 11, 'auth/group/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 106, 'normal');

INSERT INTO `es_auth_rule` VALUES (50, 'file', 11, 'auth/group/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 105, 'normal');

INSERT INTO `es_auth_rule` VALUES (51, 'file', 12, 'auth/rule/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 103, 'normal');

INSERT INTO `es_auth_rule` VALUES (52, 'file', 12, 'auth/rule/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 102, 'normal');

INSERT INTO `es_auth_rule` VALUES (53, 'file', 12, 'auth/rule/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 101, 'normal');

INSERT INTO `es_auth_rule` VALUES (54, 'file', 12, 'auth/rule/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 100, 'normal');

INSERT INTO `es_auth_rule` VALUES (55, 'file', 4, 'addon/index', 'View', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (56, 'file', 4, 'addon/add', 'Add', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (57, 'file', 4, 'addon/edit', 'Edit', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (58, 'file', 4, 'addon/del', 'Delete', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (59, 'file', 4, 'addon/local', 'Local install', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (60, 'file', 4, 'addon/state', 'Update state', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (61, 'file', 4, 'addon/install', 'Install', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (62, 'file', 4, 'addon/uninstall', 'Uninstall', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (63, 'file', 4, 'addon/config', 'Setting', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (64, 'file', 4, 'addon/refresh', 'Refresh', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (65, 'file', 4, 'addon/multi', 'Multi', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (104, 'file', 2, 'general/crontab', '定时任务', 'fa fa-tasks', '', '类似于Linux的Crontab定时任务,可以按照设定的时间进行任务的执行,目前仅支持三种任务:请求URL、执行SQL、执行Shell', 1, 1710157369, 1710157369, 0, 'Hidden');

INSERT INTO `es_auth_rule` VALUES (105, 'file', 104, 'general/crontab/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (106, 'file', 104, 'general/crontab/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (107, 'file', 104, 'general/crontab/edit', '编辑 ', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (108, 'file', 104, 'general/crontab/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (109, 'file', 104, 'general/crontab/multi', '批量更新', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (581, 'file', 0, 'community/index', '小区管理', 'fa fa-list-alt', '', '用于展示小区列表信息，以及增加、修改、删除等操作', 1, 1710157369, 1710157369, 200, 'normal');

INSERT INTO `es_auth_rule` VALUES (582, 'file', 581, 'community/index/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (583, 'file', 581, 'community/index/detail', '详情', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (584, 'file', 581, 'community/index/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (585, 'file', 581, 'community/index/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (586, 'file', 581, 'community/index/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (587, 'file', 0, 'expenses', '收费管理', 'fa fa-usd', '', '', 1, 1710157369, 1710157369, 194, 'normal');

INSERT INTO `es_auth_rule` VALUES (588, 'file', 587, 'expenses/index', '收费明细管理', 'fa fa-list-alt', '', '用于展示物业收费明细列表信息，以及增加、修改、删除等操作', 1, 1710157369, 1710157369, 2, 'normal');

INSERT INTO `es_auth_rule` VALUES (589, 'file', 588, 'expenses/index/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (590, 'file', 588, 'expenses/index/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (591, 'file', 588, 'expenses/index/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (592, 'file', 588, 'expenses/index/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (593, 'file', 587, 'expenses/project', '收费项目管理', 'fa fa-list-alt', '', '用于展示收费项目列表信息，以及增加、修改、删除等操作', 1, 1710157369, 1710157369, 1, 'normal');

INSERT INTO `es_auth_rule` VALUES (594, 'file', 593, 'expenses/project/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (595, 'file', 593, 'expenses/project/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (596, 'file', 593, 'expenses/project/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (597, 'file', 593, 'expenses/project/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (598, 'file', 0, 'house', '房产管理', 'fa fa-home', '', '', 1, 1710157369, 1710157369, 199, 'normal');

INSERT INTO `es_auth_rule` VALUES (599, 'file', 598, 'house/index', '房产管理', 'fa fa-list-alt', '', '用于展示房产列表信息，以户为单位', 1, 1710157369, 1710157369, 2, 'normal');

INSERT INTO `es_auth_rule` VALUES (600, 'file', 599, 'house/index/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (601, 'file', 599, 'house/index/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (602, 'file', 599, 'house/index/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (603, 'file', 599, 'house/index/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (604, 'file', 598, 'house/building', '栋数管理', 'fa fa-list-alt', '', '用于展示小区里每一栋的基础信息', 1, 1710157369, 1710157369, 1, 'normal');

INSERT INTO `es_auth_rule` VALUES (605, 'file', 604, 'house/building/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (606, 'file', 604, 'house/building/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (607, 'file', 604, 'house/building/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (608, 'file', 604, 'house/building/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (609, 'file', 0, 'owners', '业主信息管理', 'fa fa-user', '', '', 1, 1710157369, 1710157369, 198, 'normal');

INSERT INTO `es_auth_rule` VALUES (610, 'file', 609, 'owners/index', '人员管理', 'fa fa-list-alt', '', '用于管理小区里每个住户的基本信息，包括业主、家庭成员及租户等信息', 1, 1710157369, 1710157369, 3, 'normal');

INSERT INTO `es_auth_rule` VALUES (611, 'file', 610, 'owners/index/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (612, 'file', 610, 'owners/index/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (613, 'file', 610, 'owners/index/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (614, 'file', 610, 'owners/index/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (615, 'file', 609, 'owners/vehicle', '车辆管理', 'fa fa-list-alt', '', '用于管理小区里的车辆信息，包括业主、家庭成员及租户的车辆', 1, 1710157369, 1710157369, 2, 'normal');

INSERT INTO `es_auth_rule` VALUES (616, 'file', 615, 'owners/vehicle/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (617, 'file', 615, 'owners/vehicle/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (618, 'file', 615, 'owners/vehicle/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (619, 'file', 615, 'owners/vehicle/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (620, 'file', 609, 'owners/pet', '宠物管理', 'fa fa-list-alt', '', '用于管理小区里的宠物信息，包括业主、家庭成员及租户饲养的宠物', 1, 1710157369, 1710157369, 1, 'normal');

INSERT INTO `es_auth_rule` VALUES (621, 'file', 620, 'owners/pet/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (622, 'file', 620, 'owners/pet/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (623, 'file', 620, 'owners/pet/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (624, 'file', 620, 'owners/pet/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (625, 'file', 0, 'parking', '停车位管理', 'fa fa-film', '', '', 1, 1710157369, 1710157369, 197, 'normal');

INSERT INTO `es_auth_rule` VALUES (626, 'file', 625, 'parking/index', '车位管理', 'fa fa-list-alt', '', '用于管理小区里每一个停车位的基本信息', 1, 1710157369, 1710157369, 2, 'normal');

INSERT INTO `es_auth_rule` VALUES (627, 'file', 626, 'parking/index/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (628, 'file', 626, 'parking/index/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (629, 'file', 626, 'parking/index/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (630, 'file', 626, 'parking/index/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (631, 'file', 625, 'parking/usage', '车位使用管理', 'fa fa-list-alt', '', '用于管理小区里每一个停车位的使用情况', 1, 1710157369, 1710157369, 1, 'normal');

INSERT INTO `es_auth_rule` VALUES (632, 'file', 631, 'parking/usage/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (633, 'file', 631, 'parking/usage/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (634, 'file', 631, 'parking/usage/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (635, 'file', 631, 'parking/usage/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (658, 'file', 0, 'service', '服务管理', 'fa fa-coffee', '', '', 1, 1710157369, 1710157369, 196, 'hidden');

INSERT INTO `es_auth_rule` VALUES (659, 'file', 658, 'service/activity', '活动管理', 'fa fa-list-alt', '', '用于管理小区里不定期举办的各种活动', 1, 1710157369, 1710157369, 4, 'normal');

INSERT INTO `es_auth_rule` VALUES (660, 'file', 659, 'service/activity/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (661, 'file', 659, 'service/activity/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (662, 'file', 659, 'service/activity/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (663, 'file', 659, 'service/activity/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (664, 'file', 659, 'service/activity/detail', '查看详情', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (665, 'file', 658, 'service/repair', '报修管理', 'fa fa-list-alt', '', '用于管理小区里业主的报修信息', 1, 1710157369, 1710157369, 3, 'normal');

INSERT INTO `es_auth_rule` VALUES (666, 'file', 665, 'service/repair/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (667, 'file', 665, 'service/repair/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (668, 'file', 665, 'service/repair/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (669, 'file', 665, 'service/repair/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (670, 'file', 665, 'service/repair/detail', '查看详情', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (671, 'file', 658, 'service/complain', '投诉管理', 'fa fa-list-alt', '', '用于管理小区里业主的投诉信息', 1, 1710157369, 1710157369, 2, 'normal');

INSERT INTO `es_auth_rule` VALUES (672, 'file', 671, 'service/complain/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (673, 'file', 671, 'service/complain/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (674, 'file', 671, 'service/complain/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (675, 'file', 671, 'service/complain/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (676, 'file', 671, 'service/complain/detail', '查看详情', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (677, 'file', 658, 'service/mailbox', '信箱管理', 'fa fa-list-alt', '', '用于管理小区里业主的信箱信息，包括工作建议，意见反馈等。', 1, 1710157369, 1710157369, 1, 'normal');

INSERT INTO `es_auth_rule` VALUES (678, 'file', 677, 'service/mailbox/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (679, 'file', 677, 'service/mailbox/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (680, 'file', 677, 'service/mailbox/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (681, 'file', 677, 'service/mailbox/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (682, 'file', 677, 'service/mailbox/detail', '查看详情', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (683, 'file', 0, 'device/index', '资产设备管理', 'fa fa-legal', '', '用于管理小区里的公共设备，比如电梯，路灯，垃圾桶，配电箱等', 1, 1710157369, 1710157369, 195, 'hidden');

INSERT INTO `es_auth_rule` VALUES (684, 'file', 683, 'device/index/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (685, 'file', 683, 'device/index/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (686, 'file', 683, 'device/index/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (687, 'file', 683, 'device/index/del', '删除', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (688, 'file', 683, 'device/index/detail', '查看详情', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (689, 'file', 0, 'duty/index', '值班管理', 'fa fa-calendar', '', '用于管理小区物业的员工值班情况', 1, 1710157369, 1710157369, 193, 'Hidden');

INSERT INTO `es_auth_rule` VALUES (690, 'file', 689, 'duty/index/index', '查看', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (691, 'file', 689, 'duty/index/add', '添加', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

INSERT INTO `es_auth_rule` VALUES (692, 'file', 689, 'duty/index/edit', '修改', 'fa fa-circle-o', '', '', 0, 1710157369, 1710157369, 0, 'normal');

SET FOREIGN_KEY_CHECKS=1;
