-- 数据库初始化脚本

-- 创建数据库
CREATE DATABASE nurse;

-- 使用数据库
USE nurse;

-- 创建秒杀库存表
CREATE TABLE seckill (
  `seckill_id`  BIGINT       NOT NULL AUTO_INCREMENT
  COMMENT '商品库存id',
  `name`        VARCHAR(120) NOT NULL
  COMMENT '商品名称',
  `number`      INT          NOT NULL
  COMMENT '库存数量',
  `start_time`  TIMESTAMP    NOT NULL
  COMMENT '秒杀开始时间',
  `end_time`    TIMESTAMP    NOT NULL
  COMMENT '秒杀结束时间',
  `create_time` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '秒杀创建时间',
  PRIMARY KEY (seckill_id),
  KEY idx_start_time(start_time),
  KEY idx_end_time(end_time),
  KEY idx_create_time(create_time)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 1000
  DEFAULT CHARSET = utf8
  COMMENT ='秒杀库存表';

-- 初始化数据
INSERT INTO
  seckill (name, number, start_time, end_time)
VALUES
  ('秒杀苹果', 100, '2018-4-1 03:20:00', '2018-4-2 03:20:00'),
  ('秒杀香蕉', 200, '2018-4-1 03:20:00', '2018-4-2 03:20:00'),
  ('秒杀榴莲', 300, '2018-4-1 03:20:00', '2018-4-2 03:20:00'),
  ('秒杀西瓜', 400, '2018-4-1 03:20:00', '2018-4-2 03:20:00');

-- 成功明细表
CREATE TABLE success_killed (
  `seckill_id`  BIGINT    NOT NULL
  COMMENT '商品库存id',
  `user_phone`  BIGINT    NOT NULL
  COMMENT '用户手机号',
  `state`       TINYINT   NOT NULL DEFAULT -1
  COMMENT '状态:-1无效,0成功,1已付款,2已发货',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
  COMMENT '秒杀创建时间',
  PRIMARY KEY (seckill_id, user_phone), /*联合主键*/
  KEY idx_create_time(create_time)
)
  ENGINE = InnoDB
  DEFAULT CHARSET = utf8
  COMMENT ='秒杀成功明细表';