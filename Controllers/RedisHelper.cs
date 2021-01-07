using Newtonsoft.Json;
using StackExchange.Redis;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Web;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// 操作Redis帮助类
    /// </summary>
    public class RedisHelper
    {
        /// <summary>
        /// 连接字符串
        /// </summary>
        private static readonly string ConnectionString = ConfigurationManager.AppSettings["RedisConnectionString"];
        /// <summary>
        /// 锁
        /// </summary>
        private static readonly object _lock = new object();
        /// <summary>
        /// 连接对象
        /// </summary>
        private static volatile IConnectionMultiplexer _connection;
        /// <summary>
        /// 数据库
        /// </summary>
        protected static IDatabase _db;
        /// <summary>
        /// 构造方法初始化
        /// </summary>
        static RedisHelper()
        {
            _connection = ConnectionMultiplexer.Connect(ConnectionString);
            _db = GetDatabase();
        }
        /// <summary>
        /// 获取连接
        /// </summary>
        /// <returns></returns>
        protected static IConnectionMultiplexer GetConnection()
        {
            if (_connection != null && _connection.IsConnected)
            {
                return _connection;
            }
            lock (_lock)
            {
                if (_connection != null && _connection.IsConnected)
                {
                    return _connection;
                }

                if (_connection != null)
                {
                    _connection.Dispose();
                }
                _connection = ConnectionMultiplexer.Connect(ConnectionString);
            }

            return _connection;
        }
        /// <summary>
        /// 获取数据库
        /// </summary>
        /// <param name="db"></param>
        /// <returns></returns>
        public static IDatabase GetDatabase(int? db = null)
        {
            return GetConnection().GetDatabase(db ?? -1);
        }
        /// <summary>
        /// 设置
        /// </summary>
        /// <param name="key">键</param>
        /// <param name="data">值</param>
        /// <param name="cacheTime">时间</param>
        public virtual void Set(string key, object data, int cacheTime)
        {
            if (data == null)
            {
                return;
            }
            var entryBytes = Serialize(data);
            var expiresIn = TimeSpan.FromMinutes(cacheTime);

            _db.StringSet(key, entryBytes, expiresIn);
        }

        /// <summary>
        /// 设置String单个值
        /// </summary>
        /// <param name="key">键</param>
        /// <param name="value">值</param>
        /// <returns></returns>
        public bool SetStringValue(string key, string value)
        {
            return _db.StringSet(key, value);
        }

        private static TT Do<TT>(Func<IDatabase, TT> func)
        {

            TT t = func.Invoke(_db);
            return t;
            //或者
            // return func(_db);




        }


        /// <summary>
        /// 
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        /// <param name="expiry"></param>
        /// <returns></returns>
        public static bool StringSet(string key, string value, TimeSpan? expiry = default)
        {
            Func<IDatabase, bool> func = new Func<IDatabase, bool>((a) => Test(a));
            //func.Invoke(_db);
            bool flag = Do(func);
            return Do(db2qqq => db2qqq.StringSet(key, value, expiry));
        }

        /// <summary>
        /// 根据key获取value
        /// </summary>
        /// <param name="key">键</param>
        /// <returns></returns>
        public static string StringGet(string key)
        {
            string result = Do(
                new Func<IDatabase, string>(db => db.StringGet(key))
                );
            Func<IDatabase, string> func = new Func<IDatabase, string>(
                (dbb)=>dbb.StringGet (key)
                );
            string value = Do(func);


            return Do(db => db.StringGet(key));
        }

        public static bool Test(IDatabase database, string a = "")
        {
            bool flag = database.KeyExists("");
            return flag;
        }


        /// <summary>
        /// 根据键获取值
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="key"></param>
        /// <returns></returns>
        public virtual T Get<T>(string key)
        {

            var rValue = _db.StringGet(key);
            if (!rValue.HasValue)
            {
                return default(T);
            }

            var result = Deserialize<T>(rValue);

            return result;
        }



        /// <summary>
        /// 反序列化
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="serializedObject"></param>
        /// <returns></returns>
        protected virtual T Deserialize<T>(byte[] serializedObject)
        {
            if (serializedObject == null)
            {
                return default(T);
            }
            var json = Encoding.UTF8.GetString(serializedObject);
            return JsonConvert.DeserializeObject<T>(json);
        }
        /// <summary>
        /// 判断是否已经设置
        /// </summary>
        /// <param name="key"></param>
        /// <returns></returns>
        public virtual bool IsSet(string key)
        {
            return _db.KeyExists(key);
        }
        /// <summary>
        /// 序列化
        /// </summary>
        /// <param name="data"></param>
        /// <returns>byte[]</returns>
        private byte[] Serialize(object data)
        {
            var json = JsonConvert.SerializeObject(data);
            return Encoding.UTF8.GetBytes(json);
        }

    }
}