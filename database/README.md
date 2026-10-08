# 数据库初始化说明

本仓库不包含原始用户、账号密码、订单、联系方式和业务数据快照。

## 已有 MySQL 初始化脚本

请先创建并选择自己的空数据库，再按实际模块导入对应脚本。脚本保留建表语句及少量不含身份信息的菜单/角色定义，不自动创建默认管理员。

- `estate.sql`：28 张表。
- `code/addons/article/install.sql`：1 张表。
- `code/addons/community/install.sql`：2 张表。
- `code/addons/crontab/install.sql`：1 张表。
- `code/addons/device/install.sql`：2 张表。
- `code/addons/duty/install.sql`：1 张表。
- `code/addons/expenses/install.sql`：2 张表。
- `code/addons/friendlylink/install.sql`：1 张表。
- `code/addons/frontendnav/install.sql`：2 张表。
- `code/addons/house/install.sql`：2 张表。
- `code/addons/owners/install.sql`：3 张表。
- `code/addons/page/install.sql`：1 张表。
- `code/addons/parking/install.sql`：2 张表。
- `code/addons/service/install.sql`：4 张表。
- `code/addons/slide/install.sql`：2 张表。
- `code/addons/third/install.sql`：1 张表。
- `code/addons/user/install.sql`：1 张表。
- `code/addons/version/install.sql`：1 张表。
- `code/addons/wechat/install.sql`：4 张表。
- `code/application/admin/command/Install/fastadmin.sql`：18 张表。

导入方式示例（将路径和数据库名替换为实际值）：

```bash
mysql -u YOUR_USER -p YOUR_DATABASE < path/to/schema.sql
```

如果业务登录依赖已有管理员，请根据源码的密码编码规则自行创建本地账号；不要使用原始账号数据。

真实连接信息已替换为本地地址或占位值，运行前请按实际环境填写。
