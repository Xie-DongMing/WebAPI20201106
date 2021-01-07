using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// 关于WebConfig的控制器
    /// </summary>
    public class WebConfigController : ApiController
    {
        /// <summary>
        /// 根据key获取配置文件对应的值
        /// </summary>
        /// <param name="key">配置文件Key值</param>
        /// <returns></returns>
        public JObject GetWebConfigValueByKey(string key = "")
        {
            string value = ConfigurationManager.AppSettings[key];
            JObject obj = new JObject();
            obj.Add(key, value);
            return obj;
        }
    }
}
