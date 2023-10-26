import 'dart:developer';

import 'package:mysql_utils/mysql_utils.dart';

MysqlUtils mySqlConnection = MysqlUtils(
  settings: {
    'host': '127.0.0.1',
    'port': 3306,
    'user': 'root',
    'password': '123456',
    'db': 'dartfrogdb',
    'maxConnections': 10,
    'secure': false,
    'prefix': '',
    'pool': true,
    'collation': 'utf8mb4_general_ci',
    'sqlEscape': true,
  },
  errorLog: (String error) {
    log(error);
  },
  sqlLog: (String sql) {
    log(sql);
  },
  connectInit: (db1) async {
    log('Database connected');
  },
);
