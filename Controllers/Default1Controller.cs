using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Helpers;
using System.Web.Http;
using System.Web.Http.Results;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// 控制器描述
    /// </summary>
    public class Default1Controller : ApiController
    {
        /// <summary>
        /// 测试返回JObject类型
        /// </summary>
        /// <param name="userID"></param>
        /// <returns></returns>
        public JObject TestJObject(string userID)
        {
            JObject obj = new JObject();
            obj.Add("success", false);
            obj.Add("message", "错误信息");
            return obj;
        }
     


        /// <summary>
        /// object实体转换为json
        /// </summary>
        /// <param name="obj"></param>
        /// <returns></returns>
        public HttpResponseMessage ConvertToHttpResponseMessage(object obj)
        {
            string str_json = JsonConvert.SerializeObject(obj);
            HttpResponseMessage result = new HttpResponseMessage 
            {
                Content = new StringContent(str_json, Encoding.UTF8, "application/json") 
            };

            return result;
        }


    }
}
