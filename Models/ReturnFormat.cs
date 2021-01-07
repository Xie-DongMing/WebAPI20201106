using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Schema;

namespace WebAPI20201106.Models
{
    /// <summary>
    /// 返回格式通用类
    /// </summary>
    /// <typeparam name="TT"></typeparam>
    public class ReturnFormat<TT>
    {
        /// <summary>
        /// 数据总行数
        /// </summary>
        public int total {
               get { return this.data==null?0:this.data.Count; }
           // get;set;
        }
        /// <summary>
        /// 数据明细
        /// </summary>
        public List<TT> data { get; set; }





    }




}