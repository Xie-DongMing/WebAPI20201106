using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI20201106.Models
{
    /// <summary>
    /// 用户信息
    /// </summary>
    public class userInfo
    {
        /// <summary>
        /// 实例ID
        /// </summary>
        public int ID { get; set; }
        /// <summary>
        /// 用户ID
        /// </summary>
        public string userid { get; set; }
        /// <summary>
        /// 姓名
        /// </summary>
        public string username { get; set; }

        /// <summary>
        /// 密码
        /// </summary>
        public string password { get; set; }

        /// <summary>
        /// 年龄
        /// </summary>
        public int age { get; set; }

        /// <summary>
        /// 电话号码
        /// </summary>
        public string telephone { get; set; }

        /// <summary>
        /// 出生日期
        /// </summary>
        public DateTime birthday { get; set; }

        /// <summary>
        /// 对userInfo定义的委托
        /// </summary>
        public Func<List<userInfo>, List<userInfo>> GetFunc { get; set; }

    }


    /// <summary>
    /// 比较器 按年龄排序
    /// </summary>
    public class IAge : IComparer<userInfo>
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="x"></param>
        /// <param name="y"></param>
        /// <returns></returns>
        public int Compare(userInfo x, userInfo y)
        {
            return x.age.CompareTo(y.age);
        }

    }




}