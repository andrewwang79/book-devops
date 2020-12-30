-- mysql -h127.0.0.1 -P3320  -uroot -p
-- 从库上执行初始化脚本 MASTER_HOST是主库的ip

change master to MASTER_HOST ='172.17.0.1',master_port =12345, master_user ='root', master_password ='123456';
start slave;
