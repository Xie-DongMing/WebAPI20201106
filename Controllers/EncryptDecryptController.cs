using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Web.Http;
using System.IO;
using Newtonsoft.Json.Linq;

namespace WebAPI20201106.Controllers
{
    /// <summary>
    /// 加密解密控制器
    /// </summary>
    public class EncryptDecryptController : ApiController
    {

        /// <summary>
        /// MD5加密
        /// MD5为不可逆的加密方式一般用作密码验证，当密码加密结果一致时则认为登陆成功；
        /// </summary>
        /// <param name="str"></param>
        /// <returns>返回加密后字符串</returns>
        public JObject MD5Encrypt(string str)
        {
            JObject obj = new JObject();
            try
            {
                MD5 md5 = new MD5CryptoServiceProvider();
                byte[] bytes = Encoding.Default.GetBytes(str);//将要加密的字符串转换为字节数组
                byte[] encryptdata = md5.ComputeHash(bytes);//将字符串加密后也转换为字符数组 //求哈希值
                string result = Convert.ToBase64String(encryptdata);//将加密后的字节数组转换为加密字符串

                obj.Add("success", true);
                obj.Add("result", result);
            }
            catch (Exception ex)
            {
                obj.Add("success", false);
                obj.Add("result", ex.Message);

            }
            return obj;
        }

        /// <summary>
        /// DES加密
        /// </summary>
        /// <param name="str">加密字符串</param>
        /// <param name="key">加密秘钥,8位,可不填使用默认值</param>
        /// <param name="iv">加密向量,8位,可不填使用默认值</param>
        /// <returns>返回加密字符串</returns>
        public JObject DESEncrypt(string str, string key = "", string iv = "")
        {
            JObject obj = new JObject();
            try
            {
                if (key == "")
                {
                    key = System.Configuration.ConfigurationManager.AppSettings["byKey"];
                }
                if (iv == "")
                {
                    iv = System.Configuration.ConfigurationManager.AppSettings["byIV"];
                }

                byte[] byKey = Encoding.Default.GetBytes(key);
                byte[] byIV = Encoding.Default.GetBytes(iv);

                DESCryptoServiceProvider dESCrypto = new DESCryptoServiceProvider();
                MemoryStream memory = new MemoryStream();//先创建 一个内存流
                CryptoStream cryptoStream = new CryptoStream(memory, dESCrypto.CreateEncryptor(byKey, byIV), CryptoStreamMode.Write);//将内存流连接到加密转换流
                StreamWriter sw = new StreamWriter(cryptoStream);
                sw.Write(str);//将要加密的字符串写入加密转换流
                sw.Close();
                cryptoStream.Close();
                memory.Close();
                dESCrypto.Dispose();
                byte[] buffer = memory.ToArray();//将加密后的流转换为字节数组

                string result = Convert.ToBase64String(buffer);//将加密后的字节数组转换为字符串
                obj.Add("success", true);
                obj.Add("result", result);
            }
            catch (Exception ex)
            {
                obj.Add("success", false);
                obj.Add("result", ex.Message);
            }
            return obj;
        }

        /// <summary>
        /// DES解密
        /// </summary>
        /// <param name="str">解密字符串</param>
        /// <param name="key">解密秘钥,必须与加密时相同,可不填使用默认值</param>
        /// <param name="iv">解密向量,必须与加密时相同,可不填使用默认值</param>
        /// <returns>返回解密字符串</returns>
        public JObject DESDecrypt(string str, string key="", string iv="")
        {
            JObject obj = new JObject();
            try
            {
                if (key == "")
                {
                    key = System.Configuration.ConfigurationManager.AppSettings["byKey"];
                }
                if (iv == "")
                {
                    iv = System.Configuration.ConfigurationManager.AppSettings["byIV"];
                }

                byte[] byKey = Encoding.Default.GetBytes(key);
                byte[] byIV = Encoding.Default.GetBytes(iv);

                byte[] byEnc = Convert.FromBase64String(str);

                DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
                MemoryStream ms = new MemoryStream(byEnc);
                CryptoStream cst = new CryptoStream(ms, cryptoProvider.CreateDecryptor(byKey, byIV), CryptoStreamMode.Read);
                StreamReader sr = new StreamReader(cst);
                string result = sr.ReadToEnd();
                sr.Close();
                cst.Close();
                ms.Close();
                cryptoProvider.Dispose();
                obj.Add("success", true);
                obj.Add("result", result);
            }
            catch (Exception ex)
            {
                obj.Add("success", false);
                obj.Add("result", ex.Message);
            }
            return obj;
        }

    }
}
