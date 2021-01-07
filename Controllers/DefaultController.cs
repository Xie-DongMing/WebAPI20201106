using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using WebAPI20201106.Models;

namespace WebAPI20201106.Controllers
{

    /// <summary>
    /// 试一试控制器
    /// </summary>
    public class DefaultController : ApiController
    {
        /// <summary>
        /// 根据用户ID获取用户信息
        /// </summary>
        /// <param name="UserID">用户ID</param>
        /// <returns></returns>
        public userInfo GetUserNameByUserID(string UserID)
        {
            return new userInfo
            {
                userid = UserID,
                username = "x",
                age = 10,
                telephone = "13267003168",
                birthday = DateTime.Today
            };
        }


        /// <summary>
        /// 传入用户信息实体
        /// </summary>
        /// <param name="u">实体参数</param>
        /// <returns></returns>
        /// 
        [HttpPost]
        public userInfo GetUserNameByUser(userInfo u)
        {

            string str_conn = ConfigurationManager.AppSettings[""];

            return new userInfo
            {
                userid = u.userid,
                username = u.username,
                password =u.password,
                age = u.age,
                telephone = u.telephone,
                birthday = u.birthday
            };
        }


        /// <summary>
        /// 初始化数据
        /// </summary>
        /// <param name="count">数据条数</param>
        /// <returns></returns>
        public List<userInfo> IniUsers(int count = 10)
        {
            //阶层函数
            Func<Func<int, int>, Func<int, int>> F = factorial => n => n == 0 ? 1 : n * factorial(n - 1);
   


            List<userInfo> users = new List<userInfo>();
            for (int i = 0; i < count; i++)
            {
                userInfo user = new userInfo
                {
                    ID=i+1,
                    age = i+10,
                    userid = (i * 1000).ToString(),
                    username = (i + 1) % 2 == 0 ? "偶数" : "奇数",
                    password = (i * 1001).ToString(),
                    birthday = DateTime.Now.AddDays(i)
                };
                users.Add(user);
                users.Add(user);
            }


            string dt_json = JsonConvert.SerializeObject(users);
            DataTable dts = JsonConvert.DeserializeObject<DataTable>(dt_json);
            DataTable dt = dts.DefaultView.ToTable(true, "ID,age,userid,username".Split(','));
            string[] s=System.Text.RegularExpressions.Regex.Split("12aa34Aa56AA", "Aa", System.Text.RegularExpressions.RegexOptions.IgnoreCase);



            List<userInfo> users2 = new List<userInfo>();
            Func<List<userInfo>, List<userInfo>> func= new Func<List<userInfo>, List<userInfo>>(GetOdduserInfo);
            users2= func.Invoke(users);

            List<userInfo> users3 = new List<userInfo>();
            users[0].GetFunc = GetOdduserInfo;
            users3 = users[0].GetFunc(users);

            users.Sort(new IAge());//使用自定义的比较器   重写接口 IComparer 里边的Comparer方法


            users.Sort((a, b) => a.ID.CompareTo(b.ID));//ID正序
            users.Sort((a, b) => b.ID.CompareTo(a.ID));//ID倒序
          


            var query = from items in users orderby items.ID select items;  //使用Linq语法实现排序
            List<userInfo> users4 = query.ToList();

            return users;
        }

        /// <summary>
        /// 泛型委托
        /// </summary>
        /// <typeparam name="T1">泛型1</typeparam>
        /// <typeparam name="T2">泛型2</typeparam>
        /// <param name="func">使用到泛型1，泛型2的委托</param>
        /// <param name="a">泛型1参数a</param>
        /// <param name="b">泛型2参数b</param>
        /// <returns></returns>
        public static int Test<T1, T2>(Func<T1, T2, int> func, T1 a, T2 b)
        {
            return func(a, b);
        }

        /// <summary>
        /// 
        /// </summary>
        public delegate void GetHotWaterEventHandler();

        private List<userInfo> GetOdduserInfo(List<userInfo> userInfos)
        {
            List<userInfo> odd= userInfos.Where(u => u.ID%2!= 0).ToList();

            List<userInfo> even = userInfos.Where(u => u.ID% 2 == 0).ToList();

            return odd;
        }

        /// <summary>
        /// 测试返回JObject类型
        /// </summary>
        /// <param name="message">错误信息</param>
        /// <returns></returns>
        public JObject TestJObject(string message)
        {
            JObject obj = new JObject();
            obj.Add("success", false);
            obj.Add("code", "001");
            obj.Add("message", $"错误信息:{message}");
            return obj;
        }




        /// <summary>
        /// 测试HttpResponseMessage
        /// </summary>
        /// <returns></returns>
        public HttpResponseMessage GetUserInfos()
        {
            List<userInfo> users = IniUsers();
            string json = JsonConvert.SerializeObject(users);

            List<userInfo> users2 = JsonConvert.DeserializeObject<List<userInfo>>(json);
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(json);
            dt.TableName = "DataTableName11";
            string dt_json = JsonConvert.SerializeObject(dt);

            return ConvertToHttpResponseMessage(dt);
        }


        /// <summary>
        /// 测试返回通用格式total/data
        /// </summary>
        /// <returns></returns>
        public HttpResponseMessage TestReturnFormat()
        {
            List<userInfo> users = IniUsers();
            ReturnFormat<userInfo> returnFormat = new ReturnFormat<userInfo>
            {
                data = users
            };

            ReturnFormat<userInfo> returnFormat2 = new ReturnFormat<userInfo>();
            
            returnFormat2.data = users;

            string json = JsonConvert.SerializeObject(returnFormat);

            ReturnFormat<userInfo> users2 = JsonConvert.DeserializeObject<ReturnFormat<userInfo>>(json);

            return ConvertToHttpResponseMessage(returnFormat);
        }

        /// <summary>
        /// 测试接收实体List
        /// </summary>
        /// <param name="users"></param>
        /// <returns></returns>
        public HttpResponseMessage TestReceiveListFormat(List<userInfo> users)
            {
            return ConvertToHttpResponseMessage(users);
            }

        /// <summary>
        /// 测试接收实体数组
        /// </summary>
        /// <param name="users"></param>
        /// <returns></returns>
        public HttpResponseMessage TestReceiveArrayFormat(userInfo[] users)
        {
            return ConvertToHttpResponseMessage(users);
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
