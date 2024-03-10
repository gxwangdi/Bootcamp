
1. 分别在前端和后端使用 Union 注入实现“dvwa 数据库 -user 表 - 字段 -first_name 数据”的注入过程，写清楚注入步骤。

2. 分别在前端和后端使用报错注入实现“dvwa 数据库 -user 表 - 字段”的注入过程，写清楚注入步骤，并回答下列关于报错注入的问题：
- 在extractvalue 函数中，为什么’~'写在参数 1 的位置不报错，而写在参数 2 的位置报错？
- 报错注入中，为什么要突破单引号的限制，如何突破？
- 在报错注入过程中，为什么要进行报错，是哪种类型的报错？

3. 任选布尔盲注或者时间盲注在前端和后端实现“库名 - 表名 - 列名”的注入过程，写清楚注入步骤。

4. 利用宽字节注入实现“库名 - 表名 - 列名”的注入过程，写清楚注入步骤。

5. 利用 SQL 注入实现 DVWA 站点的 Getshell，写清楚攻击步骤。

预习：sqlmap
