using StackExchange.Redis;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// 关于Redis的读写操作
    /// </summary>
    public class RedisDemoController : ApiController
    {
        /// <summary>
        /// 根据键获取String类型的值
        /// </summary>
        /// <param name="key">键</param>
        /// <returns></returns>
        public string GetStringByKey(string key)
        {
            // RedisHelper helper = new RedisHelper();
            //bool s = helper.Test(db,"");
            //string value =  RedisHelper.GetDatabase().StringGet(str_key);
            string result = RedisHelper.StringGet (key);
            //result = RedisHelper.GetDatabase(1).StringGet(key);
            return result;
        }

        /// <summary>
        /// 设置字符串值（没有新增，有则修改）
        /// </summary>
        /// <param name="key">键</param>
        /// <param name="value">值</param>
        /// <returns></returns>
        public bool StringSet(string key, string value)
        {
            return RedisHelper.StringSet(key, value);
        }



    }
}
