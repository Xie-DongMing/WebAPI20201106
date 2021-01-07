using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebAPI20201106.Models
{
    /// <summary>
    /// 接收参数实体类
    /// </summary>
    public class ReceiveFormat
    {
        /// <summary>
        /// 类型
        /// </summary>
        [System.ComponentModel.Description("类型描述")]
        public string ActionType { get; set; }
        /// <summary>
        /// 参数
        /// </summary>
        public Dictionary<string,string> Dic { get; set; }
    }

    /// <summary>
    /// 执行SQL语句接收参数类
    /// </summary>
    public class ExecSQLFormat
    {
        /// <summary>
        /// 连接名称（可省，默认连接ddpt01）
        /// </summary>
        public string ConnectName { get; set; }

        /// <summary>
        /// 执行的SQL语句
        /// </summary>
        public string SqlText { get; set; }
    }


}