using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebAPI20201106.Models;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// API控制器测试
    /// </summary>
    public class ValuesController : ApiController
    {
        // GET api/values

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        /// <summary>
        /// 根据ID获取数据
        /// </summary>
        /// <param name="id">传入Id</param>
        /// <returns></returns>
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        public void Post([FromBody] string value)
        {
        }

        // PUT api/values/5
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }

        ///// <summary>
        ///// 根据用户ID获取用户信息
        ///// </summary>
        ///// <param name="UserID"></param>
        ///// <returns></returns>
        //[System.Web.Http.HttpGet]
        //public userInfo GetUserNameByUserID(string UserID)
        //{
        //    return new userInfo
        //    {
        //        userid = UserID,
        //        username = "x",
        //        age = 10,
        //        telephone = "13267003168",
        //        birthday = DateTime.Today
        //    };
        //}

        ///// <summary>
        ///// 传入用户信息实体
        ///// </summary>
        ///// <param name="u">参数</param>
        ///// <returns></returns>

        //[System.Web.Http.HttpPost]
        //public userInfo GetUserNameByUser(userInfo u)
        //{
        //    return new userInfo
        //    {
        //        userid = u.userid,
        //        username = u.username,
        //        age = u.age,
        //        telephone = u.telephone,
        //        birthday = u.birthday
        //    };
        //}
   
    
    
    
    
    
    
    
    }
}
