using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Services;

namespace WebAPI20201106
{
    /// <summary>
    /// WebService1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        /// <summary>
        /// Hello方法
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        /// <summary>
        /// 测试输入字符
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        [WebMethod(enableSession: true, Description = "输入的字符--返回当前时间")]
        [HttpGet]
        public string HelloTest(string str) => $"{str}--{DateTime.Now:g}";


        /// <summary>
        /// 测试返回DataTable
        /// </summary>
        /// <param name="row">返回DataTable行数</param>
        /// <param name="column">返回DataTable列数</param>
        /// <returns></returns>

        [WebMethod(enableSession: true, Description = "返回DataTable<br>row:返回DataTable行数<br>column:返回DataTable列数")]
        [HttpGet]
        public DataTable GetDatatable(int row, int column)
        {

            DataTable dataTable = new DataTable
            {
                TableName = "DataTableXml",
            };
            for (int i = 0; i < column; i++)
            {
                dataTable.Columns.Add($"column{i}");
            }
            for (int i = 0; i < row; i++)
            {
                DataRow dr = dataTable.NewRow();
                for (int j = 0; j < column; j++)
                {
                    dr[j] = $"{i}*{j}={i * j}";
                }
                dataTable.Rows.Add(dr);
            }

            return dataTable;
        }

        /// <summary>
        /// 传入DataTable返回Datatable
        /// </summary>
        /// <param name="dt">传入DataTable</param>
        /// <returns></returns>
        [WebMethod(EnableSession =  true, Description = "传入DataTable返回Datatable")]

        public DataTable GetDatatable2(DataTable dt)
        {
            return dt;
        }
    }
}
