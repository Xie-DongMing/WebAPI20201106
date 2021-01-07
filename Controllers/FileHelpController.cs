using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// 关于文件上传下载控制器
    /// </summary>
    public class FileHelpController : ApiController
    {

        //前端代码
        //        上传文件<input type="file" id="file" />
        //<input type = "button" id="upload" value="上传文件" />

        //<script>
        //    //上传
        //    $("#upload").click(function () {
        //            var formData = new FormData();
        //            var file = document.getElementById("file").files[0];
        //            formData.append("fileInfo", file);
        //        $.ajax({
        //            url: "../api/File/UploadFile",
        //            type: "POST",
        //            data: formData,
        //            contentType: false,//必须false才会自动加上正确的Content-Type
        //            processData: false,//必须false才会避开jQuery对 formdata 的默认处理，XMLHttpRequest会对 formdata 进行正确的处理
        //            success: function(data) {
        //                    alert(data);
        //                },
        //            error: function(data) {
        //                    alert("上传失败！");
        //                }
        //            });
        //        });
        //</script>


        /// <summary>
        /// 上传文件
        /// </summary>
        [HttpPost]
        public JObject UploadFile()
        {
            JObject obj = new JObject();
            try
            {
                string uploadPath = System.Web.HttpContext.Current.Server.MapPath("~/ApiUploadFile/");
                string uploadPath2 = Environment.CurrentDirectory;
                System.Web.HttpRequest request = System.Web.HttpContext.Current.Request;
                System.Web.HttpFileCollection fileCollection = request.Files;
                // 判断是否有文件
                if (fileCollection.Count > 0)
                {
                    // 获取文件
                    System.Web.HttpPostedFile httpPostedFile = fileCollection[0];
                    string fileName = httpPostedFile.FileName;// 文件名称
                    string fileExtension = Path.GetExtension(fileName);// 文件扩展名
                    string filePath = uploadPath + httpPostedFile.FileName;// 上传路径
                    // 如果目录不存在则要先创建
                    if (!Directory.Exists(uploadPath))
                    {
                        Directory.CreateDirectory(uploadPath);
                    }
                    // 保存新的文件
                    while (File.Exists(filePath))
                    {
                        fileName = Guid.NewGuid().ToString() + fileExtension;
                        filePath = uploadPath + fileName;
                    }
                    httpPostedFile.SaveAs(filePath);
                    obj.Add("success", true);
                    obj.Add("fileName", fileName);
                }
                else
                {
                    obj.Add("success", false);
                    obj.Add("fileName", "文件不存在");
                }
            }
            catch (Exception ex)
            {
                obj.Add("success", false);
                obj.Add("fileName", ex.Message);
            }
            return obj;
        }

        /// <summary>
        /// 文件下载
        /// </summary>
        /// <param name="fileName">文件名称</param>
        /// <returns></returns>
        /// 
        [HttpGet]
        public JObject DownloadFile(string fileName)
        {
            JObject obj = new JObject();

            try
            {
                System.Web.HttpRequest httpRequest = System.Web.HttpContext.Current.Request;
                string filePath = System.Web.HttpContext.Current.Server.MapPath("~/ApiUploadFile/");
                filePath = Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~/ApiUploadFile/"), fileName);
                if (File.Exists(filePath))
                {
                    System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                    response.Clear();
                    response.ClearHeaders();
                    response.ClearContent();
                    response.Buffer = true;
                    response.AddHeader("content-disposition", string.Format("attachment; FileName={0}", fileName));
                    response.Charset = "utf-8";
                    response.ContentEncoding = System.Text.Encoding.GetEncoding("GB2312");
                    response.ContentType = System.Web.MimeMapping.GetMimeMapping(fileName);
                    response.WriteFile(filePath);
                    response.Flush();
                    response.Close();
                    obj.Add("success", true);
                    obj.Add("message", "");
                }
                else
                {
                    obj.Add("success", false);
                    obj.Add("message", "文件不存在！");

                }
            }
            catch (Exception ex)
            {
                obj.Add("success", false);
                obj.Add("message", ex.Message);
            }
            return obj;
        }


    }
}
