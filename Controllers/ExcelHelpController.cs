

using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// 操作Excel帮助控制器
    /// </summary>
    public class ExcelHelpController : ApiController
    {
        private IWorkbook workbook = null;

        /// <summary>
        /// 将DataTable数据导入到excel中
        /// </summary>
        /// <param name="data">要导入的数据</param>
        /// <param name="sheetName">导出excel的sheet的名称</param>
        /// <param name="header">导出excel的列名</param>
        /// <returns>导入数据行数(包含列名那一行)</returns>
        //public int DataTableToExcel(DataTable data, string sheetName="Sheet1", string[] header=null)
        //{
        //    int i = 0;
        //    int j = 0;
        //    int count = 0;
        //    ISheet sheet = null;

        //    FileStream fs = new FileStream(fileName, FileMode.OpenOrCreate, FileAccess.ReadWrite);
        //    if (fileName.IndexOf(".xlsx") > 0) // 2007版本
        //        workbook = new XSSFWorkbook();
        //    else if (fileName.IndexOf(".xls") > 0) // 2003版本
        //        workbook = new HSSFWorkbook();

        //    try
        //    {
        //        if (workbook != null)
        //        {
        //            sheet = workbook.CreateSheet(sheetName);
        //        }
        //        else
        //        {
        //            return -1;
        //        }

        //        if (isColumnWritten == true) //写入DataTable的列名
        //        {
        //            IRow row = sheet.CreateRow(0);
        //            for (j = 0; j <= data.Columns.Count-1;j++)
        //            {
        //                row.CreateCell(j).SetCellValue(data.Columns[j].ColumnName);
        //            }
        //            count = 1;
        //        }
        //        else
        //        {
        //            count = 0;
        //        }

        //        for (i = 0; i <= data.Rows.Count-1; i++)
        //        {
        //            IRow row = sheet.CreateRow(count);
        //            for (j = 0; j <= data.Columns.Count-1; j++)
        //            {
        //                row.CreateCell(j).SetCellValue(data.Rows[i][j].ToString());
        //            }
        //            count++;
        //        }
        //        workbook.Write(fs); //写入到excel
        //        return count;
        //    }
        //    catch (Exception ex)
        //    {
        //        Console.WriteLine("Exception: " + ex.Message);
        //        return -1;
        //    }
        //}



        /// <summary>
        /// 将excel中的数据导入到DataTable中
        /// </summary>
        ///  <param name="dt_format">读取的DataTable格式</param>
        /// <param name="excelFilePath">Excel文档路径</param>
        /// <param name="index_sheet">读取第几个Sheet，默认值为0</param>
        /// <param name="index_startRow">从Sheet的第几行开始读取，默认值为1</param>
        /// <param name="index_startColumn">从Sheet的第几列开始读取，默认值为0</param>
        /// <returns>返回的DataTable</returns>

        [HttpGet]
        public DataTable ExcelToDataTable(string excelFilePath, int index_sheet = 0, int index_startRow = 1, int index_startColumn = 0)
        {
            ISheet sheet;

            DataTable dt_format = null;

            DataTable dt_return = new DataTable();

            if (!File.Exists(excelFilePath))
            {
                return dt_return;
            }

            //string fullPath = @"\WebSite1\Default.aspx";
            //string filename = System.IO.Path.GetFileName(fullPath);//文件名 “Default.aspx”
            //string extension = System.IO.Path.GetExtension(fullPath);//扩展名 “.aspx”
            //string fileNameWithoutExtension = System.IO.Path.GetFileNameWithoutExtension(fullPath);// 没有扩展名的文件名 “Default”

            string extension =Path.GetExtension(excelFilePath).ToLower();


            try
            {
                FileStream fs = new FileStream(excelFilePath, FileMode.Open, FileAccess.Read);
                if (extension == ".xls")// 2003版本
                {
                    workbook = new HSSFWorkbook(fs);
                }
                else if (extension == ".xlsx") // 2007版本
                {
                    workbook = new XSSFWorkbook(fs);
                }
                else
                {
                    return dt_return;
                }


                sheet = workbook.GetSheetAt(index_sheet); //workbook.GetSheet(sheetName);


                if (sheet != null)
                {
                    IRow firstRow = sheet.GetRow(index_startRow);
                    int cellCount = firstRow.LastCellNum; //一行最后一个cell的编号 即总的列数
                    int rowCount = sheet.LastRowNum;   //最后一列的标号,即总的行数

                    //构造 dt_return
                    if (dt_format != null)
                    {
                        dt_return = dt_format.Clone();
                    }
                    else
                    {
                        for (int i = 0; i <= cellCount - 1- index_startColumn; i++)
                        {
                            dt_return.Columns.Add($"Columns{i+ index_startColumn}");
                        }
                    }


                    for (int i = 0; i <= rowCount - 1; i++)
                    {
                        IRow row = sheet.GetRow(i + index_startRow);
                        if (row == null) continue; //没有数据的行默认是null　　　　　　　

                        DataRow dataRow = dt_return.NewRow();
                        for (int j = 0; j <= dt_return.Columns.Count - 1; j++)
                        {

                            if (row.GetCell(j + index_startColumn) != null) //同理，没有数据的单元格都默认是null
                            {
                                string str_temp = row.GetCell(j + index_startColumn).ToString();
                                dataRow[j] = str_temp;
                            }
                        }

                        dt_return.Rows.Add(dataRow);
                    }
                }

                return dt_return;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Exception: " + ex.Message);
                return dt_return;
            }
        }



    }
}
