
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SQLHelp;
using WebAPI20201106.Models;
using Oracle.ManagedDataAccess.Client;
using System.Text;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// 调度平台测试
    /// </summary>
    public class DDPTtestController : ApiController
    {

        /// <summary>
        /// 通过用户名获取用户信息
        /// </summary>
        /// <param name="userid">用户ID(工号)</param>
        /// <returns></returns>
        public HttpResponseMessage GetUserInfoByUserID(string userid)
        {
            string sql = "Select * From tblUser Where usercode=:userid";//:userid  参数名称必须以冒号开头
            OracleParameter[] ops={
            new OracleParameter(":userid",OracleDbType.Varchar2)  //这里的冒号可以省略
            };
            ops[0].Value = userid;
            DataTable dt = OracleHelp.GetDataTable(sql, ops);

            string sql2 = "Select * From tblUser Where usercode=:userid or organiZationID=:Orgid";
            List<OracleParameter> oracleParameters = new List<OracleParameter>();
            OracleParameter oracleParameter1 = new OracleParameter(":userid", OracleDbType.Varchar2)
            {
                Value = userid
            };
            oracleParameters.Add(oracleParameter1);
            OracleParameter oracleParameter2 = new OracleParameter(":ORGID", OracleDbType.Int32)
            {
                Value = 181
            };
            oracleParameters.Add(oracleParameter2);


            DataTable dt2 = OracleHelp.GetDataTable(sql2, oracleParameters);
            if (dt != dt2) {
                dt = dt2;
            }

            return DBHelp.ConvertToHttpResponseMessage(dt);
        }

        /// <summary>
        ///  完工入库取消添加Log测试
        /// </summary>
        /// <param name="billno">入库单号</param>
        /// <returns></returns>

        [HttpGet]
        public JObject PostTransactionGoodsInfData(string billno)
        {

            JObject obj = new JObject();
            bool IsSuccess;
            string ErrorCode, ErrorMessage;

            try
            {

             

                string sql = "select * from TBLINTERFACELOG";
                KZS.PLF.BLLCommon.CustomQuery customquery = new KZS.PLF.BLLCommon.CustomQuery();
                customquery.CustomSQL = sql;
                DataTable dt = customquery.DoQuery();

                //类名
                Sunwoda.Ddpt.Tools.SDK.PostTransactionGoodsInf post = new Sunwoda.Ddpt.Tools.SDK.PostTransactionGoodsInf();
                //参数
                string In_billno = "";
                Sunwoda.Ddpt.Tools.SDK.PostTransParam postParam = new Sunwoda.Ddpt.Tools.SDK.PostTransParam();
                postParam.OrgID = 1;
                postParam.DocumentName = In_billno;
                postParam.DocumentType = "WRKSNCancel";
                postParam.FuncCode = "DocBillSNCancel";
                postParam.TransStyCode = "DocBillSNCancel";
                postParam.UserCode = "2009250070";
                postParam.TransDate = DateTime.Now;

                KZS.PLF.BLLCommon.OutputMessage output = post.PostTransactionGoodsInfData(postParam);

                IsSuccess = output.IsSuccess;
                ErrorCode = output.ErrorCode;
                ErrorMessage = output.ErrorMessage;
            }
            catch (Exception ex)
            {
                IsSuccess = false;
                ErrorCode = ex.Source;
                ErrorMessage = ex.Message;

                //KZS.PLF.LogService.Log.Error(this.GetType().FullName, "Exception GetWhonHandDetailByOverDate", ex);
                //KZS.PLF.LogService.Log.Info(this.GetType().FullName, "End GetWhonHandDetailByOverDate");
               
            }

            obj.Add("IsSuccess", IsSuccess);
            obj.Add("ErrorCode", ErrorCode);
            obj.Add("ErrorMessage", ErrorMessage);
            return obj;

        }


        /// <summary>
        /// 测试传入字典类型--参数一String，参数二Dictionary
        /// </summary>
        /// <param name="Type">类型</param>
        /// <param name="dic">参数名称dic</param>
        /// <returns></returns>
        public JObject PostByDictionary(string Type,Dictionary<string, string> dic)
        {

            Dictionary<string, string> dicTest = new Dictionary<string, string>();
            for (int i = 0; i < 5; i++)
            {
                dicTest.Add($"A{i}", $"{i}");
            }

            string json = JsonConvert.SerializeObject(dicTest);
            bool IsSuccess = false;
            string ErrorCode = string.Empty, ErrorMessage = string.Empty;
             

            foreach (var item in dic)
            {
                ErrorCode = item.Key;
                ErrorMessage = item.Value;
            }


            JObject obj = new JObject();
            obj.Add("IsSuccess", IsSuccess);
            obj.Add("ErrorCode", ErrorCode);
            obj.Add("ErrorMessage", ErrorMessage);
            return obj;

        }



        /// <summary>
        /// 测试传入字典类型--参数一Dictionary，参数二String
        /// </summary>
        /// <param name="dic">字典</param>
        /// <param name="Type">类型参数</param>
        /// <returns></returns>
        public JObject PostByDictionaryAA(Dictionary<string, string> dic,string Type)
        {

            Dictionary<string, string> dicTest = new Dictionary<string, string>();
            for (int i = 0; i < 5; i++)
            {
                dicTest.Add($"A{i}", $"{i}");
            }

            string json = JsonConvert.SerializeObject(dicTest);

            JObject obj = new JObject();
            bool IsSuccess = false;
            string ErrorCode = string.Empty, ErrorMessage = string.Empty;

            foreach (var item in dic)
            {
                ErrorCode = item.Key;
                ErrorMessage = item.Value;
            }

            obj.Add("IsSuccess", IsSuccess);
            obj.Add("ErrorCode", ErrorCode);
            obj.Add("ErrorMessage", ErrorMessage);
            return obj;




        }
        /// <summary>
        /// 测试传入字典类
        /// </summary>
        /// <param name="receiveFormat">接收参数实体</param>
        /// <returns></returns>
        public JObject PostByClassDictionary(ReceiveFormat receiveFormat )
        {



            string ActionType = receiveFormat.ActionType;
            Dictionary<string,string> dic = receiveFormat.Dic;

            JObject obj = new JObject();
            bool IsSuccess = false;
            string ErrorCode = string.Empty, ErrorMessage = string.Empty;

            foreach (var item in dic)
            {
                ErrorCode = item.Key;
                ErrorMessage = item.Value;
            }

            obj.Add("IsSuccess", IsSuccess);
            obj.Add("ErrorCode", ErrorCode);
            obj.Add("ErrorMessage", ErrorMessage);
            return obj;

        }


        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="execSQLFormat">传入参数实体</param>
        /// <returns>返回SQL语句结果的json对象</returns>
        public HttpResponseMessage ExecSQL(ExecSQLFormat execSQLFormat) {
            DataTable dt = DBHelp.GetDataTable_SQL(execSQLFormat.SqlText,execSQLFormat.ConnectName);
            HttpResponseMessage responseMessage = DBHelp.ConvertToHttpResponseMessage (dt);
            return responseMessage;
        }

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="execSQLFormat">传入参数实体</param>
        /// <returns>返回SQL语句结果的json对象</returns>
        public HttpResponseMessage ExecOracle(ExecSQLFormat execSQLFormat)
        {
            DataTable dt = DBHelp.GetDataTable_Oracle(execSQLFormat.SqlText, execSQLFormat.ConnectName);
            HttpResponseMessage responseMessage = DBHelp.ConvertToHttpResponseMessage(dt);
            return responseMessage;
        }

        /// <summary>
        /// 测试执行SQL
        /// </summary>
        /// <param name="execSQLFormat">传入参数实体</param>
        /// <returns></returns>

        [HttpPost]
        public JObject ExecuteCommand(ExecSQLFormat execSQLFormat)
        {
            JObject obj = new JObject();
            int count = DBHelp.ExecuteCommand(execSQLFormat.SqlText, execSQLFormat.ConnectName);
            obj.Add("rows", count);
            obj.Add("success", count>=0);
            return obj;
        }


        /// <summary>
        /// 供应商标签管理同步导入
        /// </summary>
        /// <param name="excelPath">excel文件路径</param>
        /// <returns></returns>
        public JObject SupplierSyncLabelUpload(string excelPath)
        {
            //excelPath=@"D:\Users\2009250070\Desktop\supplierUpload.xlsx"
            JObject obj = new JObject();
            DataTable dt_upload = new ExcelHelpController().ExcelToDataTable(excelPath);
            if (dt_upload.Rows.Count == 0)
            {
                obj.Add("IsSuccess", false);
                obj.Add("ErrorMessage", "没有读取到要处理的数据行");
                return obj;
            }
            if (dt_upload.Columns.Count < 4)
            {
                obj.Add("IsSuccess", false);
                obj.Add("ErrorMessage", "导入模板资料要求需要有4列(组织ID,供应商编码,物料编码,物料名称)");
                return obj;
            }

            dt_upload.Columns[0].ColumnName = "Orgid";
            dt_upload.Columns[1].ColumnName = "vendorCode";
            dt_upload.Columns[2].ColumnName = "MitemName";
            dt_upload.Columns[3].ColumnName = "MitemDesc";

            string Orgid, VendorCode, MitemName;
            string column_all = "Orgid,VendorCode,MitemName";
            dt_upload = dt_upload.DefaultView.ToTable(true, column_all.Split(','));

            StringBuilder sql_dt_exists = new StringBuilder();
            bool hasValue = false;//标记是否有拼接sql
            sql_dt_exists.Append("select distinct to_char(Instid) Instid,to_char(Orgid) Orgid,eattribute79 vendorCode,MitemName from tblMitem_b where ");
            sql_dt_exists.AppendLine(" (to_char(Orgid),MitemName) in ");
            sql_dt_exists.AppendLine(" ( ");
            for (int i = 0; i < dt_upload.Rows.Count; i++)
            {
                Orgid = dt_upload.Rows[i]["Orgid"].ToString().Trim().Replace("'", "''");
                VendorCode = dt_upload.Rows[i]["VendorCode"].ToString().Trim().Replace("'", "''");
                MitemName = dt_upload.Rows[i]["MitemName"].ToString().Trim().Replace("'", "''");
                if (Orgid == "" || VendorCode == "" || MitemName == "") continue;
                sql_dt_exists.AppendLine(hasValue==false? $"('{Orgid}','{MitemName}')" : $",('{Orgid}','{MitemName}')");
                hasValue = true;
            }
            sql_dt_exists.AppendLine(" ) ");

            if (hasValue == false)
            {
                obj.Add("IsSuccess", false);
                obj.Add("ErrorMessage", "组织ID,供应商编码,物料编码不能为空");
                return obj;
            }


            DataTable dt_exists = DBHelp.GetDataTable_Oracle(sql_dt_exists.ToString());
            if (dt_exists.Rows.Count == 0)
            {
                obj.Add("IsSuccess", false);
                obj.Add("ErrorMessage", "没有找到与Excel匹配的资料，请确认资料中对应组织ID,物料编码是否存在");
                return obj;
            }


            //Linq将两个合并
            var result = from upload in dt_upload.AsEnumerable()
                         from exists in dt_exists.AsEnumerable()
                         where upload.Field<string>("Orgid") == exists.Field<string>("Orgid")
                         && upload.Field<string>("MitemName") == exists.Field<string>("MitemName")
                         select new
                         {
                             Instid = exists.Field<string>("Instid"),
                             Orgid = exists.Field<string>("Orgid"),
                             MitemName = exists.Field<string>("MitemName"),
                             VendorCode_old = exists.Field<string>("VendorCode"),
                             VendorCode_new = upload.Field<string>("VendorCode"),
                         };


            StringBuilder sql_update = new StringBuilder();
            var lists = result.ToList();
            foreach (var item in lists)
            {
                if (string.IsNullOrEmpty(item.VendorCode_old) == true)
                {
                    sql_update.AppendLine($"update tblMitem_b set eattribute79='{item.VendorCode_new}' where Instid='{item.Instid}';");
                }
                else if (item.VendorCode_old.Split(',').Contains(item.VendorCode_new))
                {
                    continue;
                }
                else
                {
                    sql_update.AppendLine($"update tblMitem_b set eattribute79=eattribute79||','||'{item.VendorCode_new}' where Instid='{item.Instid}';");
                }
            }

            if (string.IsNullOrEmpty(sql_update.ToString())) {
                obj.Add("IsSuccess", false);
                obj.Add("ErrorMessage", "没有要更新的资料(请确认资料是否已经同步过了！！！)");
                return obj;
            }

            int count = DBHelp.ExecuteCommand(string.Format("begin {0} end;", sql_update.ToString()));
            obj.Add("IsSuccess", true);
            obj.Add("ErrorMessage", "导入成功");
            return obj;
        }



    }
}
